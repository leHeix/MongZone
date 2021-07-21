#if defined _TRANSITIONS_CALLBACKS_
	#endinput
#endif
#define _TRANSITIONS_CALLBACKS_

static RunTransitionCallback(playerid, count, bool:in, task_count, bool:task_in)
{
	if(GetPVarType(playerid, !"transition_callback") != PLAYER_VARTYPE_NONE && in == task_in && count == task_count)
	{
		new fun = GetPVarInt(playerid, !"transition_callback");
		DeletePVar(playerid, !"transition_callback");

		@.fun();

		Indirect_Release(fun);
	}

	return 0;
}

public TRANSITION_Process(playerid, bool:in, task_count, bool:task_in)
{	
	new count = PlayerTextDrawGetBoxColor(playerid, p_tdTransition{playerid});

	if(in)
	{
		count += 5;
		PlayerTextDrawBoxColor(playerid, p_tdTransition{playerid}, count);

		if(count >= 260)
		{
			KillTimer(GetPVarInt(playerid, !"transition_timer"));
			SetPVarInt(playerid, !"transition_in", false);
			SetPVarInt(playerid, !"transition_timer", SetTimerEx(!"TRANSITION_Process", 30, true, "iiii", playerid, false, task_count, task_in));
		}
	}
	else
	{
		count -= 5;
		PlayerTextDrawBoxColor(playerid, p_tdTransition{playerid}, count);

		if(count <= 0)
		{
			RunTransitionCallback(playerid, count, in, task_count, task_in);
			Transition_Stop(playerid);
			return 0;
		}
	}

	PlayerTextDrawShow(playerid, p_tdTransition{playerid});
	RunTransitionCallback(playerid, count, in, task_count, task_in);

	return 1;
}