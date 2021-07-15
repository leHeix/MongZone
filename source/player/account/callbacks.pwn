#if defined _PLAYER_ACCOUNT_CALLBACKS_
	#endinput
#endif
#define _PLAYER_ACCOUNT_CALLBACKS_

#include <YSI_Coding\y_hooks>

hook OnPlayerDisconnect(playerid, reason)
{
	if(Bit_Get(Player_GetFlags(playerid), PFLAG_REGISTERED))
	{
		new Float:x, Float:y, Float:z, Float:angle;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, angle);

		new String:query = @f("\
				UPDATE `USERS` SET \
					`PLAYED_TIME` = `PLAYED_TIME` + (UNIX_TIMESTAMP() - `CURRENT_CONNECION`), \
					`LAST_CONNECTION` = CURRENT_TIMESTAMP(), \
					`LEVEL` = %i, \
					`XP` = %i, \
					`POS_X` = %.2f, \
					`POS_Y` = %.2f, \
					`POS_Z` = %.2f, \
					`POS_ANGLE` = %.2f, \
					`VIRTUALWORLD` = %i, \
					`INTERIOR` = %i, \
					`HUNGER` = %.2f, \
					`THIRST` = %.2f, \
					`SKIN` = %i, \
					`CURRENT_CONNECTION` = 0, \
				WHERE `ID` = %i;\
			", 
			Player_GetLevel(playerid), Player_GetXP(playerid),
			x, y, z, angle, Player_GetVirtualWorld(playerid), Player_GetInterior(playerid),
			Player_GetHunger(playerid), Player_GetThirst(playerid),
			Player_GetSkin(playerid),
			Player_GetAccountId(playerid)
		);

		mysql_tquery_s(g_sqlDatabase, query);
	}

	g_rgePlayerData[playerid] = g_rgePlayerData[MAX_PLAYERS];
	FillMemory(_:(Player_GetFlags(playerid)), 0);
	
	return 1;
}