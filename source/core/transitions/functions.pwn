#if defined _TRANSITIONS_FUNCTIONS_
	#endinput
#endif
#define _TRANSITIONS_FUNCTIONS_

Transition_Start(playerid, bool:in = true, task_count = -1, task_in = -1)
{
	Transition_Stop(playerid);

	PlayerTextDrawBoxColor(playerid, p_tdTransition{playerid}, (in ? 0 : 255));

	SetPVarInt(playerid, !"transition_in", in);
	SetPVarInt(playerid, !"transition_task_count", task_count);
	SetPVarInt(playerid, !"transition_task_in", task_in);
	SetPVarInt(playerid, !"transition_timer", SetTimerEx(!"TIMER_ProcessTransition", 30, true, !"iiii", playerid, in, task_count, task_in));
	return 1;
}

Transition_StartInline({F@_@, F@_@i, F@_@iii}:func, playerid, count = -1, bool:in = true, func_tag = tagof(func))
{
	Indirect_Claim(func);
	Indirect_SetMeta(func, func_tag);

	SetPVarInt(playerid, !"transition_callback", _:func);

	if(!Transition_IsActive(playerid))
	{
		Transition_Start(playerid, true, count, in);
	}
	else
	{
		SetPVarInt(playerid, !"transition_task_count", count);
		SetPVarInt(playerid, !"transition_task_in", in);
		Transition_Resume(playerid);
	}

	return 1;
}

Transition_Stop(playerid)
{
	if(!Transition_IsActive(playerid))
		return 0;

	KillTimer(GetPVarInt(playerid, !"transition_timer"));
	if(GetPVarType(playerid, !"transition_callback") != PLAYER_VARTYPE_NONE)
	{
		Indirect_Release(GetPVarInt(playerid, !"transition_callback"));
	}

	DeletePVar(playerid, !"transition_timer");
	DeletePVar(playerid, !"transition_callback");
	DeletePVar(playerid, !"transition_in");
	DeletePVar(playerid, !"transition_task_count");
	DeletePVar(playerid, !"transition_task_in");

	PlayerTextDrawHide(playerid, p_tdTransition{playerid});
	return 1;
}

Transition_Pause(playerid)
{
	if(!Transition_IsActive(playerid))
		return 0;

	KillTimer(GetPVarInt(playerid, !"transition_timer"));
	SetPVarInt(playerid, !"transition_timer", -1);
	return 1;
}

Transition_Resume(playerid)
{
	if(!Transition_IsActive(playerid))
		return 0;

	KillTimer(GetPVarInt(playerid, !"transition_timer"));
	SetPVarInt(playerid, !"transition_timer", SetTimerEx(!"TIMER_ProcessTransition", 30, true, "dddd", playerid, GetPVarInt(playerid, !"transition_in"), GetPVarInt(playerid, !"transition_task_count"), GetPVarInt(playerid, !"transition_task_in")));
	return 1;
}