#if defined _H_ACCOUNT_
	#endinput
#endif
#define _H_ACCOUNT_

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
	e_iPlayerInterior
};

enum {
	PFLAG_AUTHENTICATING = 0,
	PFLAG_REGISTERED,
	PFLAG_CUSTOMIZING_PLAYER,
	PFLAG_INTRODUCTION_RUNNING,

	MAX_PLAYER_FLAGS
}

new 
	g_rgePlayerData[MAX_PLAYERS + 1][ePlayerData],
	BitArray:g_rgiPlayerFlags[MAX_PLAYERS]<MAX_PLAYER_FLAGS>,
	Iterator:Admins<MAX_PLAYERS>;