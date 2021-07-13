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

			@.on_register();
			Indirect_Release(on_register);
		}
		MySQL_TQueryInline(g_sqlDatabase, using inline QueryResult, 
			"INSERT INTO USERS \
				(NAME, PASSWORD, SEX, AGE, SKIN) \
			VALUES \
				('%e', '%e', %i, %i, %i);\
			",
		Player_GetName(playerid), p_szPasswordHash[playerid], Player_GetSex(playerid), Player_GetAge(playerid), Player_GetSkin(playerid));
	}
	BCrypt_HashInline(p_szPassword[playerid], 12, using inline OnHash);
}