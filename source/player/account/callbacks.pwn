#if defined _ACCOUNT_CALLBACKS_
	#endinput
#endif
#define _ACCOUNT_CALLBACKS_

#include <YSI_Coding\y_hooks>

public OnPlayerDataFetched(playerid)
{
	new exists;
	cache_get_row_count(exists);

	if(exists)
	{
		Bit_Set(Player_Flags(playerid), PFLAG_REGISTERED, true);

		cache_get_value_name_int(0, !"ID", Player_AccountID(playerid));
		cache_get_value_name(0, !"PASSWORD", p_szPasswordHash[playerid]);
		cache_get_value_name_int(0, !"SEX", Player_Sex(playerid));
		cache_get_value_name_int(0, !"AGE", Player_Age(playerid));
		cache_get_value_name_int(0, !"MONEY", Player_Money(playerid));
		cache_get_value_name_float(0, !"HEALTH", Player_Health(playerid));
		cache_get_value_name_float(0, !"ARMOR", Player_Armour(playerid));
		cache_get_value_name_float(0, !"POS_X", g_rgePlayerData[playerid][e_fSpawnPosX]);
		cache_get_value_name_float(0, !"POS_Y", g_rgePlayerData[playerid][e_fSpawnPosY]);
		cache_get_value_name_float(0, !"POS_Z", g_rgePlayerData[playerid][e_fSpawnPosZ]);
		cache_get_value_name_float(0, !"POS_ANGLE", g_rgePlayerData[playerid][e_fSpawnPosAngle]);
		cache_get_value_name_int(0, !"VIRTUALWORLD", Player_VirtualWorld(playerid));
		cache_get_value_name_int(0, !"INTERIOR", Player_Interior(playerid));
		cache_get_value_name(0, !"LAST_CONNECTION", Player_GetLastConnection(playerid));
		cache_get_value_name_int(0, !"LEVEL", Player_Level(playerid));
		cache_get_value_name_int(0, !"XP", Player_XP(playerid));
		cache_get_value_name_int(0, !"SKIN", Player_Skin(playerid));
		cache_get_value_name_float(0, !"HUNGER", Player_Hunger(playerid));
		cache_get_value_name_float(0, !"THIRST", Player_Thirst(playerid));
		cache_get_value_name_int(0, !"ADMIN", Player_Rank(playerid));
		cache_get_value_name_int(0, !"PLAYED_TIME", Player_PlayedTime(playerid));
		g_rgePlayerData[playerid][e_iCurrentConnectionTime] = gettime();

		mysql_tquery_s(g_hDatabase, @f("UPDATE `USERS` SET `CURRENT_CONNECTION` = %i WHERE `ID` = %i;", g_rgePlayerData[playerid][e_iCurrentConnectionTime], Player_AccountID(playerid)));
		Account_RegisterConnection(playerid);
	}

	CallLocalFunction(!"OnPlayerDataLoaded", !"i", playerid);

	return 1;
}

hook OnPlayerConnect(playerid)
{
	EnablePlayerCameraTarget(playerid, true);

	GetPlayerName(playerid, Player_GetName(playerid), MAX_PLAYER_NAME);
	GetPlayerIp(playerid, Player_GetIp(playerid));

	Bit_Set(Player_Flags(playerid), PFLAG_AUTHENTICATING, true);

	new query[65];
	mysql_format(g_hDatabase, query, sizeof(query), "SELECT * FROM USERS WHERE `NAME` = '%e';", Player_GetName(playerid));
	mysql_tquery(g_hDatabase, query, !"OnPlayerDataFetched", !"i", playerid);

	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	Iter_Remove(Admins, playerid);
	Iter_Remove(LoggedIn, playerid);
	
	Account_Save(playerid);

	g_rgePlayerData[playerid] = g_rgePlayerData[MAX_PLAYERS];
	FillMemory(_:Player_Flags(playerid), 0);

	return 1;
}

hook OPPauseStateChange(playerid, pausestate)
{
	if(pausestate)
	{
		g_rgePlayerData[playerid][e_iPlayerPausedBegin] = gettime();
	}
	else if(g_rgePlayerData[playerid][e_iPlayerPausedBegin] != 0)
	{
		g_rgePlayerData[playerid][e_iPlayerPausedTime] = (gettime() - g_rgePlayerData[playerid][e_iPlayerPausedBegin]);
		g_rgePlayerData[playerid][e_iPlayerPausedBegin] = 0;
	}

	return 1;
}