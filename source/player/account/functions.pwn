#if defined _PLAYER_ACCOUNT_FUNCTIONS_
	#endinput
#endif
#define _PLAYER_ACCOUNT_FUNCTIONS_

Account_RegisterConnection(playerid)
{
	return mysql_tquery_s(g_hDatabase, @f("INSERT INTO `CONNECTION_LOGS` (ACCOUNT_ID, IP_ADDRESS) VALUES (%i, '%e');", Player_AccountID(playerid), Player_GetIp(playerid)));
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
				(NAME, PASSWORD, SEX, AGE, POS_X, POS_Y, POS_Z, POS_ANGLE, VIRTUALWORLD, INTERIOR, SKIN, CURRENT_CONNECTION, MONEY) \
			VALUES \
				('%e', '%e', %i, %i, %.2f, %.2f, %.2f, %.2f, %i, %i, %i, UNIX_TIMESTAMP(), %i);\
		",
			Player_GetName(playerid), p_szPasswordHash[playerid],
			Player_Sex(playerid), Player_Age(playerid),
			1483.0563, -1738.4750, 13.5469, 358.7972,
			VW_GENERAL, 0, 
			Player_Skin(playerid),
			5000
		);
	}
	BCrypt_HashInline(p_szPassword[playerid], 12, using inline HashDone);

	return 1;
}

Account_Save(playerid)
{
	if(!Player_AccountID(playerid))
		return 0;

	if(IsPlayerSpawned(playerid))
	{
		GetPlayerPos(playerid, g_rgePlayerData[playerid][e_fSpawnPosX], g_rgePlayerData[playerid][e_fSpawnPosY], g_rgePlayerData[playerid][e_fSpawnPosZ]);
		GetPlayerFacingAngle(playerid, g_rgePlayerData[playerid][e_fSpawnPosAngle]);
	}

	mysql_tquery_s(g_hDatabase, @f("\
			UPDATE `USERS` SET \
				`PLAYED_TIME` = `PLAYED_TIME` + (UNIX_TIMESTAMP() - `CURRENT_CONNECTION`), \
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
				`CURRENT_CONNECTION` = 0 \
			WHERE `ID` = %i;\
		", 
		Player_Level(playerid), Player_XP(playerid),
		g_rgePlayerData[playerid][e_fSpawnPosX], g_rgePlayerData[playerid][e_fSpawnPosY], g_rgePlayerData[playerid][e_fSpawnPosZ], g_rgePlayerData[playerid][e_fSpawnPosAngle], Player_VirtualWorld(playerid), Player_Interior(playerid),
		Player_Hunger(playerid), Player_Thirst(playerid),
		Player_Skin(playerid),
		Player_AccountID(playerid)
	));

	return 1;
}

Player_GetSpawnPos(playerid, &Float:x, &Float:y, &Float:z, &Float:angle)
{
	x = g_rgePlayerData[playerid][e_fSpawnPosX];
	y = g_rgePlayerData[playerid][e_fSpawnPosY];
	z = g_rgePlayerData[playerid][e_fSpawnPosZ];
	angle = g_rgePlayerData[playerid][e_fSpawnPosAngle];
	return 1;
}

Player_SetMoney(playerid, money, bool:give = false, bool:update = false)
{
	Player_Money(playerid) += (give ? money : -Player_Money(playerid) + money);
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, money);

	if(update)
	{
		mysql_tquery_s(g_hDatabase, @f("UPDATE `USERS` SET `MONEY` = %i WHERE `ID` = %i;", Player_Money(playerid), Player_AccountID(playerid));
	}

	return 1;
}