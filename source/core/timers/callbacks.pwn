#if defined _TIMERS_CALLBACKS_
	#endinput
#endif
#define _TIMERS_CALLBACKS_

#include <YSI_Coding\y_hooks>

hook OnPlayerDisconnect(playerid, reason)
{
	if(g_rgPlayerTimers[playerid] != Alloc:0)
	{
		for(new i, j = Malloc_GetSlotSize(g_rgPlayerTimers[playerid]); i < j; i += eTimerData)
			PlayerTimer_Kill(playerid, i);

		free(g_rgPlayerTimers[playerid]);
		g_rgPlayerTimers[playerid] = Alloc:0;
	}

	return 1;
}

public InlineTimerDone(playerid, timer_idx, bool:repeat)
{
	new previous_timer = g_rgiRunningTimer;

	new data[eTimerData];
	mgeta(data, sizeof(data), g_rgPlayerTimers[playerid], timer_idx);
	g_rgiRunningTimer = timer_idx;

	new fun = data[e_iTimerFunction];
	new do_not_handle = @.fun();

	g_rgiRunningTimer = previous_timer;

	if(!repeat && !do_not_handle)
	{
		PlayerTimer_Kill(playerid, timer_idx);
	}

	return 1;
}