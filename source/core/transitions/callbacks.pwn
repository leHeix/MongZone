#if defined _TRANSITIONS_CALLBACKS_
	#endinput
#endif
#define _TRANSITIONS_CALLBACKS_

static RunTransitionCallback(playerid, count, bool:in, task_count, bool:task_in)
{
	if(count == task_count && in == task_in && GetPVarType(playerid, !"transition_callback") != PLAYER_VARTYPE_NONE)
	{
		new fun = GetPVarInt(playerid, !"transition_callback");
		new func_tag = Indirect_GetMeta(fun);

		switch(func_tag)
		{
			case (tagof(F@_@iii:)): @.fun(playerid, count, in);
			case (tagof(F@_@i:)): @.fun(playerid);
			case (tagof(F@_@:)): @.fun();
		}

		Indirect_Release(fun);
		// DeletePVar(playerid, !"transition_callback");
	}

	return 1;
}

public TIMER_ProcessTransition(playerid, bool:in, task_count, bool:task_in)
{
	new count = PlayerTextDrawGetBoxColor(playerid, p_tdTransition{playerid});

	if(in)
	{
		count += 5;
		PlayerTextDrawBoxColor(playerid, p_tdTransition{playerid}, count);

		if(count == 260)
		{
			KillTimer(GetPVarInt(playerid, !"transition_timer"));
			SetPVarInt(playerid, !"transition_in", false);
			SetPVarInt(playerid, !"transition_timer", SetTimerEx(!"TIMER_ProcessTransition", 30, true, !"dddd", playerid, false, task_count, task_in));
		}
	}
	else
	{
		count -= 5;
		PlayerTextDrawBoxColor(playerid, p_tdTransition{playerid}, count);

		if(count == 0)
		{
			RunTransitionCallback(playerid, count, in, task_count, task_in);
			Transition_Stop(playerid);
			return 1;
		}
	}

	PlayerTextDrawShow(playerid, p_tdTransition{playerid});
	RunTransitionCallback(playerid, count, in, task_count, task_in);

	return 1;
}