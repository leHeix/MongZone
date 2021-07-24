#if defined _H_COMMANDS_
	#endinput
#endif
#define _H_COMMANDS_

#define MZ_MAX_COMMANDS (100)

#define CMD_ADMIN<%0> ((%0) << 16)

enum(<<=1) 
{
	CMD_HIDDEN,
	CMD_NO_COOLDOWN
};

enum eCommandData
{
	e_iCommandNameHash,
	e_szCommandDescription[50]
};

new
	g_rgeCommandData[MZ_MAX_COMMANDS][eCommandData];

/* command <name>(playerid, const params[], <command description>) */
#define command%4\32;%0(%1,%2,%3) \
	forward _cmddesc_%0();\
	public _cmddesc_%0() { new i = Commands_FreeIndex(); if(i != -1) g_rgeCommandData[i][e_iCommandNameHash] = YHash(#%0), strcat(g_rgeCommandData[i][e_szCommandDescription], %3); }\
	CMD:%0(%1,%2)