#if defined _TIMERS_FUNCTIONS_
	#endinput
#endif
#define _TIMERS_FUNCTIONS_

PlayerTimer_Start(playerid, time, bool:repeat, Func:cb<>)
{
	// ret_ptr = [FRM + 4] (next CIP after function call)
	new ret_ptr = __emit(load.s.pri 4);
	// unique timers!
	for(new i; i < MAX_PLAYER_TIMERS; ++i)
	{
		if(g_rgPlayerTimers[playerid][i][e_iNextIP] == ret_ptr)
		{
			KillTimer(Indirect_GetMeta(g_rgPlayerTimers[playerid][i][e_iTimerFunction]));
			Indirect_Release(g_rgPlayerTimers[playerid][i][e_iTimerFunction]);
			g_rgPlayerTimers[playerid][i][e_iTimerFunction] = 
			g_rgPlayerTimers[playerid][i][e_iNextIP] = 0;
		}
	}

	new idx = PlayerTimer_GetFreeIndex(playerid);
	assert idx != -1;
	
	Indirect_Claim(cb);

	g_rgPlayerTimers[playerid][idx][e_iNextIP] = ret_ptr;
	g_rgPlayerTimers[playerid][idx][e_iTimerFunction] = _:cb;

	new timer = SetTimerEx(!"InlineTimerDone", time, repeat, !"iii", playerid, idx, repeat);
	Indirect_SetMeta(cb, timer);

	return 1;
}

PlayerTimer_Kill(playerid, timerid = CURRENT_TIMER)
{
	if(timerid == CURRENT_TIMER)
	{
		if(g_rgiRunningTimer == -1)
			return 0;

		timerid = g_rgiRunningTimer;
	}

	if(timerid >= MAX_PLAYER_TIMERS || timerid < 0)
		return 0;

	if(!g_rgPlayerTimers[playerid][timerid][e_iNextIP])
		return 0;

	KillTimer(Indirect_GetMeta(g_rgPlayerTimers[playerid][timerid][e_iTimerFunction]));
	Indirect_Release(g_rgPlayerTimers[playerid][timerid][e_iTimerFunction]);

	g_rgPlayerTimers[playerid][timerid][e_iTimerFunction] =
	g_rgPlayerTimers[playerid][timerid][e_iNextIP] = 0;

	return 1;
}

PlayerTimer_KillAll(playerid)
{
	for(new i; i < MAX_PLAYER_TIMERS; ++i)
	{
		if(g_rgPlayerTimers[playerid][i][e_iNextIP] == 0)
			continue;

		KillTimer(Indirect_GetMeta(g_rgPlayerTimers[playerid][i][e_iTimerFunction]));
		Indirect_Release(g_rgPlayerTimers[playerid][i][e_iTimerFunction]);
	}

	g_rgPlayerTimers[playerid] = g_rgPlayerTimers[MAX_PLAYERS];

	return 0;
}

PlayerTimer_GetFreeIndex(playerid)
{
	for(new i; i < MAX_PLAYER_TIMERS; ++i)
	{
		if(g_rgPlayerTimers[playerid][i][e_iNextIP] == 0)
			return i;
	}

	return -1;
}