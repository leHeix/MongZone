#if defined _TRANSITIONS_FUNCTIONS_
	#endinput
#endif
#define _TRANSITIONS_FUNCTIONS_

Transition_Start(playerid, bool:in = TRANSITION_IN, task_count = -1, task_in = -1)
{
	PlayerTextDrawBoxColor(playerid, p_tdTransition{playerid}, (in ? 0 : 255));

	SetPVarInt(playerid, !"transition_in", in);
	SetPVarInt(playerid, !"transition_task_count", task_count);
	SetPVarInt(playerid, !"transition_task_in", task_in);
	SetPVarInt(playerid, !"transition_timer", SetTimerEx(!"TRANSITION_Process", 30, true, !"iiii", playerid, in, task_count, task_in));

	return 1;
}

Transition_Stop(playerid)
{
	if(!Transition_IsActive(playerid))
		return 0;

	if(GetPVarType(playerid, !"transition_callback") != PLAYER_VARTYPE_NONE)
		Indirect_Release(GetPVarInt(playerid, !"transition_callback"));

	KillTimer(GetPVarInt(playerid, !"transition_timer"));

	DeletePVar(playerid, !"transition_timer");
	DeletePVar(playerid, !"transition_callback");
	DeletePVar(playerid, !"transition_task_count");
	DeletePVar(playerid, !"transition_task_in");
	DeletePVar(playerid, !"transition_in");

	PlayerTextDrawHide(playerid, p_tdTransition{playerid});

	return 1;
}

Transition_StartInline(Func:cb<>, playerid, bool:in, count)
{
	Indirect_Claim(cb);

	SetPVarInt(playerid, !"transition_callback", _:cb);

	if(Transition_IsActive(playerid))
	{
		SetPVarInt(playerid, !"transition_task_count", count);
		SetPVarInt(playerid, !"transition_task_in", in);
		Transition_Resume(playerid);
	}
	else
	{
		Transition_Start(playerid, true, count, in);
	}

	return 1;
}

Transition_Resume(playerid)
{
	if(!Transition_IsActive(playerid))
		return 0;

	KillTimer(GetPVarInt(playerid, !"transition_timer"));
	SetPVarInt(playerid, !"transition_timer", SetTimerEx(!"TRANSITION_Process", 30, true, !"iiii", playerid, GetPVarInt(playerid, !"transition_in"), GetPVarInt(playerid, !"transition_task_count"),GetPVarInt(playerid, !"transition_task_in")));

	return 1;
}