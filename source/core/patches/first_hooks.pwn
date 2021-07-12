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