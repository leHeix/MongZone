#if defined _ASYNC_CALLBACKS_
	#endinput
#endif
#define _ASYNC_CALLBACKS_

#include <YSI_Coding\y_hooks>

hook FCNPC_OnFinishPlayback(npcid)
{	
	if(pool_valid(g_rgpTasks[npcid]))
	{
		if(pool_has(g_rgpTasks[npcid], NPC_TASK_PLAYBACK_END))
		{
			new fun = pool_get(g_rgpTasks[npcid], NPC_TASK_PLAYBACK_END);
			@.fun();

			Indirect_Release(fun);
			pool_remove(g_rgpTasks[npcid], NPC_TASK_PLAYBACK_END);
		}
	}
}

hook FCNPC_OVEntryComplete(npcid, vehicleid, seatid)
{
	if(pool_valid(g_rgpTasks[npcid]))
	{
		if(pool_has(g_rgpTasks[npcid], NPC_TASK_VEHICLE_ENTRY))
		{
			new fun = pool_get(g_rgpTasks[npcid], NPC_TASK_VEHICLE_ENTRY);
			new fun_tag = Indirect_GetMeta(fun);

			switch(fun_tag)
			{
				case (tagof(F@_@ii:)): @.fun(vehicleid, seatid);
				case (tagof(F@_@i:)): @.fun(vehicleid);
				case (tagof(F@_@:)): @.fun();
			}

			Indirect_Release(fun);
			pool_remove(g_rgpTasks[npcid], NPC_TASK_VEHICLE_ENTRY);
		}
	}
}