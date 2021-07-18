#if defined _H_TRANSITIONS_
	#endinput
#endif
#define _H_TRANSITIONS_

const bool:TRANSITION_IN = true;
const bool:TRANSITION_OUT = false;

#define Transition_IsActive(%0) (IsPlayerTextDrawVisible(%0, p_tdTransition{%0}))

forward TRANSITION_Process(playerid, bool:in, task_count, bool:task_in);