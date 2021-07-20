#if defined _ASYNC_CALLBACKS_
	#endinput
#endif
#define _ASYNC_CALLBACKS_

#include <YSI_Coding\y_hooks>

hook FCNPC_OVEntryComplete(npcid, vehicleid, seatid)
{
	if(g_rgiTasks[npcid][NPC_TASK_VEHICLE_ENTRY] != cellmin)
	{
		new fun = g_rgiTasks[npcid][NPC_TASK_VEHICLE_ENTRY];
		new tag = Indirect_GetMeta(fun);

		g_rgiTasks[npcid][NPC_TASK_VEHICLE_ENTRY] = cellmin;

		if(tag == tagof(F@_@ii:))
			@.fun(vehicleid, seatid);
		else
			@.fun();

		Indirect_Release(fun);
	}

	return 1;
}

hook FCNPC_OnFinishPlayback(npcid)
{
	if(g_rgiTasks[npcid][NPC_TASK_PLAYBACK_END] != cellmin)
	{
		new fun = g_rgiTasks[npcid][NPC_TASK_PLAYBACK_END];
		g_rgiTasks[npcid][NPC_TASK_PLAYBACK_END] = cellmin;

		@.fun();

		Indirect_Release(fun);
	}

	return 1;
}