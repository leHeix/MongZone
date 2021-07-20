#if defined _AUTH_CALLBACKS_
	#endinput
#endif
#define _AUTH_CALLBACKS_

#include <YSI_Coding\y_hooks>

hook OnScriptInit()
{
	for(new i = (MAX_PLAYERS - 1); i != -1; i -= 1)
	{
		// g_rgeIntroData[i][e_iIntroPlayer] = FCNPC_Create(Str_Random(24));
		// g_rgeIntroData[i][e_iIntroPilot] = FCNPC_Create(Str_Random(24));
		// g_rgeIntroData[i][e_iTaxiDriver] = FCNPC_Create(Str_Random(24));
	}

	return 1;
}

hook OnScriptExit()
{
	for (new i = (MAX_PLAYERS - 1); i != -1; i -= 1)
	{
		FCNPC_Destroy(g_rgeIntroData[i][e_iIntroPlayer]);
		FCNPC_Destroy(g_rgeIntroData[i][e_iIntroPilot]);
		FCNPC_Destroy(g_rgeIntroData[i][e_iTaxiDriver]);
	}

	return 1;
}

hook OnPlayerConnect(playerid)
{
	Chat_Clear(playerid);
	KillFeed_Clear(playerid);

	SetPlayerWeather(playerid, 0);
	SetPlayerTime(playerid, 23, 00);

	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	Intro_End(playerid);
	return 1;
}

public OnPlayerDataLoaded(playerid)
{
	SetSpawnInfo(playerid, NO_TEAM, 0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0);
	SpawnPlayer(playerid);
	TogglePlayerSpectating(playerid, true);
	SetPlayerVirtualWorld(playerid, VW_PLAYER + playerid);

	if(!Bit_Get(Player_Flags(playerid), PFLAG_REGISTERED))
		Intro_SetUpVehicles(playerid);

	inline const ScreenBlacked()
	{
		Transition_Pause(playerid);

		if(Bit_Get(Player_Flags(playerid), PFLAG_REGISTERED))
		{
			for(new i; i <= 13; ++i)
			{
				TextDrawShowForPlayer(playerid, g_tdRegisterAcc[i]);
			}

			for(new i = 18; i < sizeof(g_tdRegisterAcc); ++i)
			{
				TextDrawShowForPlayer(playerid, g_tdRegisterAcc[i]);
			}

			PlayerTextDrawSetString(playerid, p_tdRegisterAcc[playerid]{0}, Str_FixEncoding(Player_GetName(playerid)));
			PlayerTextDrawShow(playerid, p_tdRegisterAcc[playerid]{0});
			PlayerTextDrawShow(playerid, p_tdRegisterAcc[playerid]{1});
			PlayerTextDrawShow(playerid, p_tdRegisterAcc[playerid]{2});
			PlayerTextDrawShow(playerid, p_tdRegisterAcc[playerid]{3});

			TextDrawSetStringForPlayer(g_tdRegisterAcc[7], playerid, "Cuenta registrada");
			TextDrawSetStringForPlayer(g_tdRegisterAcc[19], playerid, Str_FixEncoding("Iniciar sesión"));
			TextDrawSetStringForPlayer(g_tdRegisterAcc[24], playerid, Str_FixEncoding("Último inicio de sesión: ~y~%s"), Player_GetLastConnection(playerid));

			SelectTextDraw(playerid, 0xD2B567FF);
		}
		else
		{
			SetPlayerCameraPos(playerid, 1585.296142, -2566.993652, 13.769470);
			SetPlayerCameraLookAt(playerid, 1580.729736, -2568.970458, 14.259890);

			Intro_ToggleTextdraws(playerid, true);
		}

		Transition_Resume(playerid);
	}
	Transition_StartInline(using inline ScreenBlacked, playerid, TRANSITION_IN, 255);

	return 1;
}

/* Textdraw Interactions */
hook OnPlayerPressEsc(playerid)
{
	if(Bit_Get(Player_Flags(playerid), PFLAG_AUTHENTICATING) && IsTextDrawVisibleForPlayer(playerid, g_tdRegisterAcc[0]))
	{
		TextDraw_DelayedSelect(playerid, 0xD2B567FF);
		return ~1;
	}

	return 1;
}