#if defined _PATCH_FIRST_HOOKS_
	#endinput
#endif
#define _PATCH_FIRST_HOOKS_

#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid)
{
	if(IsPlayerNPC(playerid))
		return ~1;

	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	if(IsPlayerNPC(playerid))
		return ~1;

	return 1;
}