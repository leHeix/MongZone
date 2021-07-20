#if defined _TIMERS_FUNCTIONS_
	#endinput
#endif
#define _TIMERS_FUNCTIONS_

PlayerTimer_Start(playerid, time, bool:repeat, Func:cb<>)
{
	if(!g_rgPlayerTimers[playerid])
		g_rgPlayerTimers[playerid] = calloc(eTimerData);

	// ret_ptr = [FRM + 4] (next CIP after function call)
	new ret_ptr = __emit(load.s.pri 4);
	new data[eTimerData];

	// unique timers!
	for(new i, j = Malloc_GetSlotSize(g_rgPlayerTimers[playerid]); i < j; i += eTimerData)
	{
		if(mget(g_rgPlayerTimers[playerid], i) == 0)
			continue;
	
		mgeta(data, sizeof(data), g_rgPlayerTimers[playerid], i);
		if(data[e_iNextIP] == ret_ptr)
		{
			KillTimer(Indirect_GetMeta(data[e_iTimerFunction]));
			Indirect_Release(data[e_iTimerFunction]);
			for(new x; x < eTimerData; ++x)
				mset(g_rgPlayerTimers[playerid], i + x, 0);
		}
	}

	new idx = PlayerTimer_GetFreeIndex(playerid);
	if(idx == -1)
		idx = PlayerTimer_AllocateNew(playerid);

	Indirect_Claim(cb);

	data[e_iNextIP] = ret_ptr;
	data[e_iTimerFunction] = _:cb;
	mseta(g_rgPlayerTimers[playerid], idx, data, sizeof(data));

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

	if(timerid >= Malloc_GetSlotSize(g_rgPlayerTimers[playerid]))
		return 0;

	if(mget(g_rgPlayerTimers[playerid], timerid) == 0)
		return 0;

	new data[eTimerData];
	mgeta(data, sizeof(data), g_rgPlayerTimers[playerid], timerid);

	KillTimer(Indirect_GetMeta(data[e_iTimerFunction]));
	Indirect_Release(data[e_iTimerFunction]);

	for(new x; x < eTimerData; ++x)
		mset(g_rgPlayerTimers[playerid], timerid + x, 0);

	return 1;
}

PlayerTimer_KillAll(playerid)
{
	for(new i, j = Malloc_GetSlotSize(g_rgPlayerTimers[playerid]); i < j; i += eTimerData)
	{
		if(mget(g_rgPlayerTimers[playerid], i) == 0)
			continue;

		new data[eTimerData];
		mgeta(data, sizeof(data), g_rgPlayerTimers[playerid], i);
		KillTimer(Indirect_GetMeta(data[e_iTimerFunction]));
		Indirect_Release(data[e_iTimerFunction]);
	}

	FillMemory(Malloc_GetData(g_rgPlayerTimers[playerid], 0), 0, Malloc_GetSlotSize(g_rgPlayerTimers[playerid]));

	return 0;
}

PlayerTimer_GetFreeIndex(playerid)
{
	for(new i, j = Malloc_GetSlotSize(g_rgPlayerTimers[playerid]); i < j; i += eTimerData)
	{
		if(mget(g_rgPlayerTimers[playerid], i) == 0)
			return i;
	}

	return -1;
}

static PlayerTimer_AllocateNew(playerid)
{
	g_rgPlayerTimers[playerid] = realloc(g_rgPlayerTimers[playerid], Malloc_GetSlotSize(g_rgPlayerTimers[playerid]) + eTimerData, true);
	return PlayerTimer_GetFreeIndex(playerid);
}