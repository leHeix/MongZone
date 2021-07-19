#if defined _CONFIG_CALLBACKS_
	#endinput
#endif
#define _CONFIG_CALLBACKS_

#include <YSI_Coding\y_hooks>

hook OnScriptInit()
{
	FCNPC_UseCrashLog(false);

	SetMaxPlayers(MAX_PLAYERS * 4);
	SetMaxNPCs((MAX_PLAYERS * 4) - MAX_PLAYERS);

	for (new i = (sizeof(g_rgcAllowedNameChars) - 1); i != -1; i -= 1)
	{
		AllowNickNameCharacter(g_rgcAllowedNameChars[i], true);
	}

	SetNameTagDrawDistance(20.0);

	SendRconCommand(!"hostname 	     .•°   MongZone (Español - 0.3.7)   °•.");
	SendRconCommand(!"language Español");
	SendRconCommand(!"gamemodetext Roleplay");

	SetServerRule(!"lagcomp", "lagshot");

	SetServerRuleFlags(!"weather", CON_VARFLAG_READONLY);
	SetServerRuleFlags(!"worldtime", CON_VARFLAG_READONLY);
	SetServerRuleFlags(!"version", CON_VARFLAG_READONLY);
	SetServerRuleFlags(!"mapname", CON_VARFLAG_READONLY);

	AddServerRule(!"versión de sa-mp", !"0.3.7");
	AddServerRule(!"discord", !"rakmong.com/servers/mongzone");
	AddServerRule(!"última actualización", __date);

	SetModeRestartTime(1.0);
	YSF_EnableNightVisionFix(true);
	ToggleCloseConnectionFix(true);

	if(!fexist(!"Config.bin"))
	{
		if(Config_Save())
		{
			print("[!] Se creo el archivo de configuración por defecto.");
		}
	}
	else
	{
		Config_Load();
	}

	print("~ Configuración del servidor cargada.");
	return 1;
}

hook OnScriptExit()
{
	print("~ Guardando configuración...");
	Config_Save();
	return 1;
}

hook OnPlayerConnect(playerid)
{
	new playercount = Iter_Count(Player);
	if(playercount > g_rgeServerData[e_iPlayerRecord])
	{
		g_rgeServerData[e_iPlayerRecord] = playercount;
		printf("[!!!] Nuevo record de jugadores: %d jugador(es) conectado(s)", g_rgeServerData[e_iPlayerRecord]);
		Config_Save();
	}

	return 1;
}