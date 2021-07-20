#if defined _H_ASYNC_
	#endinput
#endif
#define _H_ASYNC_

enum {
	NPC_TASK_VEHICLE_ENTRY,
	NPC_TASK_PLAYBACK_END,

	MAX_ASYNC_TASKS
};

new
	g_rgiTasks[MAX_PLAYERS * 4][MAX_ASYNC_TASKS] = { { cellmin, ... }, ... };