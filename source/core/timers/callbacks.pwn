#if defined _TIMERS_CALLBACKS_
	#endinput
#endif
#define _TIMERS_CALLBACKS_

#include <YSI_Coding\y_hooks>

hook OnPlayerDisconnect(playerid, reason)
{
	PlayerTimer_KillAll(playerid);
	return 1;
}

public InlineTimerDone(playerid, timer_idx, bool:repeat)
{
	new previous_timer = g_rgiRunningTimer;
	g_rgiRunningTimer = timer_idx;

	new fun = g_rgPlayerTimers[playerid][timer_idx][e_iTimerFunction];
	new handle = @.fun();

	g_rgiRunningTimer = previous_timer;

	if(!repeat && handle)
	{
		PlayerTimer_Kill(playerid, timer_idx);
	}

	return 1;
}