/*
**
** 	Ensures that no NPC gets to call any player-related public function.
**
*/

#if defined _PATCH_first_hooks_
	#endinput
#endif
#define _PATCH_first_hooks_

#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid)
{
	if(IsPlayerNPC(playerid))
		return ~1;

	return 1;
}

hook OnPlayerDisconnect(playerid)
{
	if(IsPlayerNPC(playerid))
		return ~1;

	return 1;
}