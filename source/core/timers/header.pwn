#if defined _H_TIMERS_
	#endinput
#endif
#define _H_TIMERS_

const CURRENT_TIMER = cellmin;
const MAX_PLAYER_TIMERS = 100; // a hunnid

enum _:eTimerData {
	e_iTimerFunction, // The meta for this function holds the timer ID
	e_iNextIP // as in Next Instruction Pointer
}

new
	g_rgiRunningTimer = -1,
	g_rgPlayerTimers[MAX_PLAYERS + 1][MAX_PLAYER_TIMERS][eTimerData];

forward InlineTimerDone(playerid, timer_idx, bool:repeat);

#define GetRunningTimerID() (g_rgiRunningTimer)
#define Player_Timers(%0) (g_rgPlayerTimers[(%0)])