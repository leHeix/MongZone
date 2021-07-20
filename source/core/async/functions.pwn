#if defined _ASYNC_FUNCTIONS_
	#endinput
#endif
#define _ASYNC_FUNCTIONS_

FCNPC_AwaitVehicleEntry(npcid, {F@_@, F@_@ii}:func, fun_tag = tagof(func))
{
	Indirect_Claim(func);
	Indirect_SetMeta(func, fun_tag);
	g_rgiTasks[npcid][NPC_TASK_VEHICLE_ENTRY] = _:func;

	return 1;
}

FCNPC_AwaitPlaybackEnd(npcid, Func:cb<>)
{
	Indirect_Claim(cb);
	g_rgiTasks[npcid][NPC_TASK_VEHICLE_ENTRY] = _:cb;

	return 1;
}