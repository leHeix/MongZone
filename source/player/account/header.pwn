#if defined _H_PLAYER_ACCOUNT_
	#endinput
#endif
#define _H_PLAYER_ACCOUNT_

enum {
	PLAYER_SEX_MALE = 0,
	PLAYER_SEX_FEMALE = 1
};

enum ePlayerData {
	e_iAccountId,
	e_szPlayerName[MAX_PLAYER_NAME],
	e_szIpAddress[16],
	e_szLastConnection[20],
	e_iPlayerSex,
	e_iPlayerAge,
	e_iPlayerVirtualWorld,
	e_iPlayerInterior,
	e_iPlayerSkin,
	e_iPlayerLevel,
	e_iPlayerXP,
	Float:e_fPlayerSpawnX,
	Float:e_fPlayerSpawnY,
	Float:e_fPlayerSpawnZ,
	Float:e_fPlayerSpawnAngle,
	Float:e_fPlayerHunger,
	Float:e_fPlayerThirst,
};

new g_rgePlayerData[MAX_PLAYERS + 1][ePlayerData];

enum {
	PFLAG_AUTHENTICATING,
	PFLAG_REGISTERED,
	PFLAG_CUSTOMIZING_PLAYER,
	PFLAG_INTRODUCTION_RUNNING,

	PF_MAX_FLAGS,
};

new BitArray:g_rgPlayerFlags[MAX_PLAYERS]<PF_MAX_FLAGS>;
new 
	p_szPassword[MAX_PLAYERS][32],
	p_szPasswordHash[MAX_PLAYERS][61];

#define Player_GetAccountId(%0) (g_rgePlayerData[(%0)][e_iAccountId])
#define Player_SetAccountId(%0,%1) (g_rgePlayerData[(%0)][e_iAccountId] = (%1))
#define Player_GetName(%0) (g_rgePlayerData[(%0)][e_szPlayerName])
#define Player_GetIp(%0) (g_rgePlayerData[(%0)][e_szIpAddress])
#define Player_GetSex(%0) (g_rgePlayerData[(%0)][e_iPlayerSex])
#define Player_SetSex(%0,%1) (g_rgePlayerData[(%0)][e_iPlayerSex] = (%1))
#define Player_GetAge(%0) (g_rgePlayerData[(%0)][e_iPlayerAge])
#define Player_SetAge(%0,%1) (g_rgePlayerData[(%0)][e_iPlayerAge] = (%1))
#define Player_GetSkin(%0) (g_rgePlayerData[(%0)][e_iPlayerSkin])
#define Player_SetSkin(%0,%1) (g_rgePlayerData[(%0)][e_iPlayerSkin] = (%1))
#define Player_GetSpawnPos(%0,%1,%2,%3,%4); {\
		(%1) = (g_rgePlayerData[(%0)][e_fPlayerSpawnX]);\
		(%2) = (g_rgePlayerData[(%0)][e_fPlayerSpawnY]);\
		(%3) = (g_rgePlayerData[(%0)][e_fPlayerSpawnZ]);\
		(%4) = (g_rgePlayerData[(%0)][e_fPlayerSpawnAngle]);\
	}
#define Player_GetInterior(%0) (g_rgePlayerData[(%0)][e_iPlayerInterior])
#define Player_GetVirtualWorld(%0) (g_rgePlayerData[(%0)][e_iPlayerVirtualWorld])
#define Player_GetHunger(%0) (g_rgePlayerData[(%0)][e_fPlayerHunger])
#define Player_SetHunger(%0,%1) (g_rgePlayerData[(%0)][e_fPlayerHunger] = (%1))
#define Player_GetThirst(%0) (g_rgePlayerData[(%0)][e_fPlayerThirst])
#define Player_SetThirst(%0,%1) (g_rgePlayerData[(%0)][e_fPlayerThirst] = (%1))
#define Player_GetFlags(%0) Bit:(g_rgPlayerFlags[(%0)])
#define Player_GetLastConnection(%0) (g_rgePlayerData[(%0)][e_szLastConnection])
#define Player_GetLevel(%0) (g_rgePlayerData[(%0)][e_iPlayerLevel])
#define Player_SetLevel(%0,%1) (g_rgePlayerData[(%0)][e_iPlayerLevel] = (%1))
#define Player_GetXP(%0) (g_rgePlayerData[(%0)][e_iPlayerXP])
#define Player_SetXP(%0,%1) (g_rgePlayerData[(%0)][e_iPlayerXP] = (%1))