#if defined _PLAYER_ACCOUNT_CALLBACKS_
	#endinput
#endif
#define _PLAYER_ACCOUNT_CALLBACKS_

#include <YSI_Coding\y_hooks>

hook OnPlayerDisconnect(playerid, reason)
{
	g_rgePlayerData[playerid] = g_rgePlayerData[MAX_PLAYERS];
	Bit_SetAll(Player_GetFlags(playerid), false);
	
	return 1;
}