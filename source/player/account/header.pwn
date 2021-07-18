#if defined _H_ACCOUNT_
	#endinput
#endif
#define _H_ACCOUNT_

enum {
	PLAYER_SEX_MALE = 0,
	PLAYER_SEX_FEMALE = 1
};

enum ePlayerData {
	e_iAccountId,
	e_szPlayerName[MAX_PLAYER_NAME],
	e_szPlayerIp[16],
	e_szPlayerLastConnection[20],
	Float:e_fPlayerHealth,
	Float:e_fPlayerArmour,
	e_iPlayerMoney,
	Float:e_fSpawnPosX,
	Float:e_fSpawnPosY,
	Float:e_fSpawnPosZ,
	Float:e_fSpawnPosAngle,
	e_iPlayerVirtualWorld,
	e_iPlayerInterior,
	e_iPlayerSex,
	e_iPlayerAge,
	e_iPlayerSkin,
};

enum {
	PFLAG_AUTHENTICATING = 0,
	PFLAG_REGISTERED,
	PFLAG_CUSTOMIZING_PLAYER,
	PFLAG_INTRODUCTION_RUNNING,

	MAX_PLAYER_FLAGS
};

new
	p_szPassword[MAX_PLAYERS][32],
	p_szPasswordHash[MAX_PLAYERS][61],
	g_rgePlayerData[MAX_PLAYERS + 1][ePlayerData],
	BitArray:g_rgiPlayerFlags[MAX_PLAYERS]<MAX_PLAYER_FLAGS>,
	Iterator:Admins<MAX_PLAYERS>,
	Iterator:LoggedIn<MAX_PLAYERS>;

// "functions"
#define Player_Flags(%0) Bit:(g_rgiPlayerFlags[(%0)])
#define Player_AccountID(%0) (g_rgePlayerData[(%0)][e_iAccountId])
#define Player_GetName(%0) (g_rgePlayerData[(%0)][e_szPlayerName])
#define Player_GetIp(%0) (g_rgePlayerData[(%0)][e_szPlayerIp])
#define Player_GetLastConnection(%0) (g_rgePlayerData[(%0)][e_szPlayerLastConnection])
#define Player_Health(%0) (g_rgePlayerData[(%0)][e_fPlayerHealth])
#define Player_Armour(%0) (g_rgePlayerData[(%0)][e_fPlayerArmour])
#define Player_Armor Player_Armour
#define Player_Money(%0) (g_rgePlayerData[(%0)][e_iPlayerMoney])
/*#define Player_GetSpawnPos(%0,%1,%2,%3,%4); {\
	(%1) = (g_rgePlayerData[(%0)][e_fSpawnPosX]);\
	(%2) = (g_rgePlayerData[(%0)][e_fSpawnPosY]);\
	(%3) = (g_rgePlayerData[(%0)][e_fSpawnPosZ]);\
	(%4) = (g_rgePlayerData[(%0)][e_fSpawnPosAngle]);\
}*/
#define Player_VirtualWorld(%0) (g_rgePlayerData[(%0)][e_iPlayerVirtualWorld])
#define Player_Interior(%0) (g_rgePlayerData[(%0)][e_iPlayerInterior])
#define Player_Sex(%0) (g_rgePlayerData[(%0)][e_iPlayerSex])
#define Player_Age(%0) (g_rgePlayerData[(%0)][e_iPlayerAge])
#define Player_Skin(%0) (g_rgePlayerData[(%0)][e_iPlayerSkin])