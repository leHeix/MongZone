#if defined _H_ASYNC_
	#endinput
#endif
#define _H_ASYNC_

enum {
	NPC_TASK_VEHICLE_ENTRY = 1,
	NPC_TASK_PLAYBACK_END,

	MAX_TASKS
};

new
	Pool:g_rgpTasks[MAX_PLAYERS * 4];