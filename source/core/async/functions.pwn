#if defined _ASYNC_FUNCTIONS_
	#endinput
#endif
#define _ASYNC_FUNCTIONS_

FCNPC_OnVehicleEntryInline(npcid, {F@_@, F@_@i, F@_@ii}:func, func_tag = tagof(func))
{
	if(!pool_valid(g_rgpTasks[npcid]))
		g_rgpTasks[npcid] = pool_new();

	Indirect_Claim(func);
	Indirect_SetMeta(func, func_tag);
	pool_set(g_rgpTasks[npcid], NPC_TASK_VEHICLE_ENTRY, _:func);

	return 1;
}

FCNPC_OnPlaybackEndInline(npcid, Func:onend<>)
{
	if(!pool_valid(g_rgpTasks[npcid]))
		g_rgpTasks[npcid] = pool_new();

	Indirect_Claim(onend);
	pool_set(g_rgpTasks[npcid], NPC_TASK_PLAYBACK_END, _:onend);

	return 1;
}