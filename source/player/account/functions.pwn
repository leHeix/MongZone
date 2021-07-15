#if defined _PLAYER_ACCOUNT_FUNCTIONS_
	#endinput
#endif
#define _PLAYER_ACCOUNT_FUNCTIONS_

Account_Register(playerid, Func:on_register<>)
{
	Indirect_Claim(on_register);

	inline const OnHash(string:hash[])
	{
		FillMemory(p_szPassword[playerid], '\0');
		strcpy(p_szPasswordHash[playerid], hash);

		inline const QueryResult()
		{
			Player_SetAccountId(playerid, cache_insert_id());
			Account_InsertConnectionLog(playerid);

			@.on_register();
			Indirect_Release(on_register);
		}
		MySQL_TQueryInline(g_sqlDatabase, using inline QueryResult, 
			"INSERT INTO USERS \
				(NAME, PASSWORD, SEX, AGE, SKIN, VIRTUALWORLD, INTERIOR, POS_X, POS_Y, POS_Z, POS_ANGLE, CURRENT_CONNECTION) \
			VALUES \
				('%e', '%e', %i, %i, %i, %i, 0, %.2f, %.2f, %.2f, %.2f, UNIX_TIMESTAMP()); \
			\
			INSERT INTO `CONNECTION_LOGS` VALUES (LAST_INSERT_ID(), %s);\
			",
		Player_GetName(playerid), p_szPasswordHash[playerid], Player_GetSex(playerid), Player_GetAge(playerid), Player_GetSkin(playerid), VW_GENERAL, 1483.0563, -1738.4750, 13.5469, 358.7972, Player_GetIp(playerid));
		
		// set some data fields
		g_rgePlayerData[playerid][e_fPlayerSpawnX] = 1483.0563;
		g_rgePlayerData[playerid][e_fPlayerSpawnY] = -1738.4750;
		g_rgePlayerData[playerid][e_fPlayerSpawnZ] = 13.5469;
		g_rgePlayerData[playerid][e_fPlayerSpawnAngle] = 358.7972;
		g_rgePlayerData[playerid][e_iPlayerVirtualWorld] = VW_GENERAL;
	}
	BCrypt_HashInline(p_szPassword[playerid], 12, using inline OnHash);
}

Account_InsertConnectionLog(playerid)
{
	return mysql_tquery_s(g_sqlDatabase, @f("INSERT INTO `CONNECTION_LOGS` VALUES (%i, %s);", Player_GetAccountId(playerid), Player_GetIp(playerid)));
}