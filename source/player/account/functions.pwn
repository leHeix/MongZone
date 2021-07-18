#if defined _PLAYER_ACCOUNT_FUNCTIONS_
	#endinput
#endif
#define _PLAYER_ACCOUNT_FUNCTIONS_

Account_RegisterConnection(playerid)
{
	return mysql_tquery_s(g_hDatabase, @f("INSERT INTO `CONNECTION_LOGS` VALUES (%i, '%e');", Player_AccountID(playerid), Player_GetIp(playerid)));
}

Account_Register(playerid, Func:cb<> = F@_@:0)
{
	assert Bit_Get(Player_Flags(playerid), PFLAG_REGISTERED) == false;
	assert Player_AccountID(playerid) == 0;
	assert !isnull(p_szPassword[playerid]);

	if(_:cb != 0)
		Indirect_Claim(cb);

	inline const HashDone(string:hash[])
	{
		FillMemory(p_szPassword[playerid], '\0');
		strcpy(p_szPasswordHash[playerid], hash);

		inline const QueryDone()
		{
			Player_AccountID(playerid) = cache_insert_id();
			Account_RegisterConnection(playerid);

			if(_:cb != 0)
			{
				@.cb();
				Indirect_Release(cb);
			}
		}
		MySQL_TQueryInline(g_hDatabase, using inline QueryDone, "\
			INSERT INTO USERS \
				(NAME, PASSWORD, SEX, AGE, POS_X, POS_Y, POS_Z, POS_ANGLE, VIRTUALWORLD, INTERIOR, SKIN, CURRENT_CONNECTION) \
			VALUES \
				('%e', '%e', %i, %i, %.2f, %.2f, %.2f, %.2f, %i, %i, %i, UNIX_TIMESTAMP());\
		",
			Player_GetName(playerid), p_szPasswordHash[playerid],
			Player_Sex(playerid), Player_Age(playerid),
			1483.0563, -1738.4750, 13.5469, 358.7972,
			VW_GENERAL, 0, 
			Player_Skin(playerid)
		);
	}
	BCrypt_HashInline(p_szPassword[playerid], 12, using inline HashDone);

	return 1;
}

Player_GetSpawnPos(playerid, &Float:x, &Float:y, &Float:z, &Float:angle)
{
	x = g_rgePlayerData[playerid][e_fPlayerSpawnX];
	y = g_rgePlayerData[playerid][e_fPlayerSpawnY];
	z = g_rgePlayerData[playerid][e_fPlayerSpawnZ];
	angle = g_rgePlayerData[playerid][e_fPlayerSpawnAngle];
	return 1;
}