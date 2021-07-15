#if defined _PLAYER_INTRODUCTION_CALLBACKS_
	#endinput
#endif
#define _PLAYER_INTRODUCTION_CALLBACKS_

#include <YSI_Coding\y_hooks>

hook OnScriptInit()
{
	for(new i = (MAX_PLAYERS - 1); i != -1; i -= 1)
	{
		g_rgeIntroData[i][e_iIntroPlayer] = FCNPC_Create(Str_Random(24));
		g_rgeIntroData[i][e_iIntroPilot] = FCNPC_Create(Str_Random(24));
		g_rgeIntroData[i][e_iTaxiDriver] = FCNPC_Create(Str_Random(24));
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

hook OnPlayerDisconnect(playerid, reason)
{
	Intro_End(playerid);
	return 1;
}

hook OnPlayerConnect(playerid)
{
	GetPlayerName(playerid, Player_GetName(playerid));
	GetPlayerIp(playerid, Player_GetIp(playerid));

	Bit_Set(Player_GetFlags(playerid), PFLAG_AUTHENTICATING, true);

	EnablePlayerCameraTarget(playerid, true);

	SetSpawnInfo(playerid, NO_TEAM, 0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0);
	SpawnPlayer(playerid);
	SetPlayerVirtualWorld(playerid, VW_PLAYER + playerid);
	TogglePlayerSpectating(playerid, true);

	return 1;
}

hook OnPlayerSpawn(playerid)
{
	if(Bit_Get(Player_GetFlags(playerid), PFLAG_AUTHENTICATING))
	{
		TogglePlayerSpectating(playerid, true);

		SetPlayerWeather(playerid, 0);
		SetPlayerTime(playerid, 23, 00);
		
		Chat_Clear(playerid);
		KillFeed_Clear(playerid);

		inline const TransitionToBlack()
		{
			Transition_Pause(playerid);

			inline const QueryResult()
			{
				new exists;
				cache_get_row_count(exists);

				if(!exists)
				{
					Intro_SetUpVehicles(playerid);
					
					SetPlayerCameraPos(playerid, 1585.296142, -2566.993652, 13.769470);
					SetPlayerCameraLookAt(playerid, 1580.729736, -2568.970458, 14.259890);

					Intro_ToggleTextdraws(playerid, true);
				}
				else
				{
					Bit_Set(Player_GetFlags(playerid), PFLAG_REGISTERED, true);

					cache_get_value_name_int(0, !"ID", Player_GetAccountId(playerid));
					cache_get_value_name(0, !"PASSWORD", p_szPasswordHash[playerid]);
					cache_get_value_name_int(0, !"SEX", Player_GetSex(playerid));
					cache_get_value_name_int(0, !"AGE", Player_GetAge(playerid));
					cache_get_value_name_int(0, !"VIRTUALWORLD", Player_GetVirtualWorld(playerid));
					cache_get_value_name_int(0, !"INTERIOR", Player_GetInterior(playerid));
					cache_get_value_name_int(0, !"MONEY", Player_GetMoney(playerid));
					cache_get_value_name_float(0, !"HEALTH", Player_GetHealth(playerid));
					cache_get_value_name_float(0, !"ARMOR", Player_GetArmor(playerid));
					cache_get_value_name_float(0, !"POS_X", g_rgePlayerData[playerid][e_fPlayerSpawnX]);
					cache_get_value_name_float(0, !"POS_Y", g_rgePlayerData[playerid][e_fPlayerSpawnY]);
					cache_get_value_name_float(0, !"POS_Z", g_rgePlayerData[playerid][e_fPlayerSpawnZ]);
					cache_get_value_name_float(0, !"POS_ANGLE", g_rgePlayerData[playerid][e_fPlayerSpawnAngle]);
					cache_get_value_name(0, !"LAST_CONNECTION", Player_GetLastConnection(playerid));
					cache_get_value_name_int(0, !"LEVEL", Player_GetLevel(playerid));
					cache_get_value_name_int(0, !"XP", Player_GetXP(playerid));
					cache_get_value_name_int(0, !"SKIN", Player_GetSkin(playerid));
					cache_get_value_name_float(0, !"HUNGER", Player_GetHunger(playerid));
					cache_get_value_name_float(0, !"THIRST", Player_GetThirst(playerid));

					mysql_tquery_s(g_sqlDatabase, @f("UPDATE `USERS` SET `CURRENT_CONNECTION` = UNIX_TIMESTAMP() WHERE `ID` = %i;", Player_GetAccountId(playerid)));
					Account_InsertConnectionLog(playerid);

					for (new i; i <= 13; i += 1)
					{
						TextDrawShowForPlayer(playerid, g_tdRegisterAcc[i]);
					}

					for(new i = 18; i < sizeof(g_tdRegisterAcc); i += 1)
					{
						TextDrawShowForPlayer(playerid, g_tdRegisterAcc[i]);
					}

					TextDrawShowForPlayer(playerid, g_tdLastConnection);

					PlayerTextDrawSetString(playerid, p_tdRegisterAcc[playerid]{0}, Str_FixEncoding(Player_GetName(playerid)));
					PlayerTextDrawShow(playerid, p_tdRegisterAcc[playerid]{0});
					PlayerTextDrawShow(playerid, p_tdRegisterAcc[playerid]{1});
					PlayerTextDrawShow(playerid, p_tdRegisterAcc[playerid]{2});
					PlayerTextDrawShow(playerid, p_tdRegisterAcc[playerid]{3});

					SelectTextDraw(playerid, 0xD2B567FF);

					TextDrawSetStringForPlayer(g_tdRegisterAcc[7], playerid, "Cuenta registrada");
					TextDrawSetStringForPlayer(g_tdRegisterAcc[19], playerid, Str_FixEncoding("Iniciar sesión"));
					TextDrawSetStringForPlayer(g_tdLastConnection, playerid, Str_FixEncoding("Último inicio de sesión: ~y~%s"), Player_GetLastConnection(playerid));
				}

				Transition_Resume(playerid);
			}
			MySQL_TQueryInline(g_sqlDatabase, using inline QueryResult, "SELECT * FROM `USERS` WHERE `NAME` = '%e';", Player_GetName(playerid));
		}
		Transition_StartInline(using inline TransitionToBlack, playerid, 255, TRANSITION_IN);
	}

	return 1;
}

hook OnPlayerPressEsc(playerid)
{
	if(Bit_Get(Player_GetFlags(playerid), PFLAG_AUTHENTICATING) && IsTextDrawVisibleForPlayer(playerid, g_tdRegisterAcc[0]))
	{
		TextDraw_DelayedSelect(playerid, 0xD2B567FF);
	}
	else if(Bit_Get(Player_GetFlags(playerid), PFLAG_CUSTOMIZING_PLAYER) && IsTextDrawVisibleForPlayer(playerid, g_tdPlayerCustomization[0]))
	{
		Bit_Set(Player_GetFlags(playerid), PFLAG_CUSTOMIZING_PLAYER, false);

		for(new i = (sizeof(g_tdPlayerCustomization) - 1); i != -1; i -= 1)
		{
			TextDrawHideForPlayer(playerid, g_tdPlayerCustomization[i]);
		}
		PlayerTextDrawHide(playerid, p_tdPlayerCustomization{playerid});
		CancelSelectTextDraw(playerid);

		Player_SetSkin(playerid, FCNPC_GetSkin(g_rgeIntroData[playerid][e_iIntroPlayer]));

		inline const ScreenBlacked()
		{
			Transition_Pause(playerid);

			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, VW_PLAYER + playerid);

			SetPlayerCameraPos(playerid, 1585.296142, -2566.993652, 13.769470);
			SetPlayerCameraLookAt(playerid, 1580.729736, -2568.970458, 14.259890);

			Transition_Resume(playerid);

			inline const OnRegister()
			{
				print("register done");

				inline const OnIntroEnd()
				{
					//SendClientMessagef(playerid, )
				}
				Intro_Play(playerid, using inline OnIntroEnd);
			}
			Account_Register(playerid, using inline OnRegister);
		}
		Transition_StartInline(using inline ScreenBlacked, playerid, 255, TRANSITION_IN);
	}

	return 1;
}

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
	if(playertextid == p_tdRegisterAcc[playerid]{1})
	{
		inline Response(response, listitem, string:inputtext[])
		{
			#pragma unused response, listitem

			if(!isnull(inputtext))
			{
				new len = strlen(inputtext);
				if(len >= 32)
					return Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_INPUT, "Introduce tu {D2B567}contraseña", "{FFFFFF}Introduce tu contraseña. Debe medir {D2B567}menos de 32 caracteres{FFFFFF}.", "Listo", "");
			
				strcpy(p_szPassword[playerid], inputtext);

				new tdstring[32];
				if(!g_rgbPasswordShown{playerid})
					FillMemory(tdstring, 'X', len);
				else
					strcpy(tdstring, inputtext);

				PlayerTextDrawSetString(playerid, p_tdRegisterAcc[playerid]{1}, tdstring);
				PlayerTextDrawShow(playerid, p_tdRegisterAcc[playerid]{1});
			}
			else
			{
				p_szPassword[playerid][0] = '\0';

				PlayerTextDrawSetString(playerid, p_tdRegisterAcc[playerid]{2}, Str_FixEncoding("Mostrar contraseña"));
				PlayerTextDrawSetString(playerid, p_tdRegisterAcc[playerid]{1}, Str_FixEncoding("Tu contraseña"));
				PlayerTextDrawShow(playerid, p_tdRegisterAcc[playerid]{2});
				PlayerTextDrawShow(playerid, p_tdRegisterAcc[playerid]{1});

				g_rgbPasswordShown{playerid} = false;
			}
		}
		Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_INPUT, "Introduce tu {D2B567}contraseña", "{FFFFFF}Introduce tu contraseña. Debe medir {D2B567}menos de 32 caracteres{FFFFFF}.", "Listo", "");
	}
	else if(playertextid == p_tdRegisterAcc[playerid]{2})
	{
		if(p_szPassword[playerid][0] != '\0')
		{
			if(!g_rgbPasswordShown{playerid})
			{
				PlayerTextDrawSetString(playerid, p_tdRegisterAcc[playerid]{2}, Str_FixEncoding("Ocultar contraseña"));
				PlayerTextDrawSetString(playerid, p_tdRegisterAcc[playerid]{1}, p_szPassword[playerid]);
				PlayerTextDrawShow(playerid, p_tdRegisterAcc[playerid]{2});
				PlayerTextDrawShow(playerid, p_tdRegisterAcc[playerid]{1});

				g_rgbPasswordShown{playerid} = true;
			}
			else
			{
				PlayerTextDrawSetString(playerid, p_tdRegisterAcc[playerid]{2}, Str_FixEncoding("Mostrar contraseña"));

				new pwd[32];
				FillMemory(pwd, 'X', strlen(p_szPassword[playerid]));

				PlayerTextDrawSetString(playerid, p_tdRegisterAcc[playerid]{1}, pwd);
				PlayerTextDrawShow(playerid, p_tdRegisterAcc[playerid]{2});
				PlayerTextDrawShow(playerid, p_tdRegisterAcc[playerid]{1});

				g_rgbPasswordShown{playerid} = false;
			}
		}
	}
	else if(playertextid == p_tdPlayerCustomization{playerid})
	{
		if(Bit_Get(Player_GetFlags(playerid), PFLAG_CUSTOMIZING_PLAYER))
		{
			inline Response(response, listitem, string:inputtext[])
			{
				#pragma unused response, listitem

				if(isnull(inputtext))
					return Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_INPUT, "Introduce tu {D2B567}edad", "{FFFFFF}Introduce tu edad. Debe ser {D2B567}mayor a 18{FFFFFF} y {D2B567}menor a 100{FFFFFF}.", "Listo", "");

				new age = strval(inputtext);
				if(NOT_IN_RANGE(age, 18, 100))
				{
					return Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_INPUT, "Introduce tu {D2B567}edad", "{FFFFFF}Introduce tu edad. Debe ser {D2B567}mayor a 18{FFFFFF} y {D2B567}menor a 100{FFFFFF}.", "Listo", "");
				}

				Player_SetAge(playerid, age);
				FCNPC_SetSkin(g_rgeIntroData[playerid][e_iIntroPlayer], Intro_AdjustSkinToRange(playerid, g_rgiSelectedSkin{playerid}));
				FCNPC_ApplyAnimation(g_rgeIntroData[playerid][e_iIntroPlayer], "PED", "SEAT_IDLE", 4.1, false, false, false, true, 0);
				FCNPC_SetAnimationByName(g_rgeIntroData[playerid][e_iIntroPlayer], "PED:SEAT_IDLE", 4.1, false, false, false, true, 0);

				new agestr[4 char];
				valstr(agestr, age, true);

				PlayerTextDrawSetString(playerid, p_tdPlayerCustomization{playerid}, agestr);
				PlayerTextDrawShow(playerid, p_tdPlayerCustomization{playerid});
			}
			Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_INPUT, "Introduce tu edad", "{FFFFFF}Introduce tu edad. Debe ser {D2B567}mayor a 18{FFFFFF} y {D2B567}menor a 100{FFFFFF}.", "Listo", "");
		}
	}

	return 1;
}

hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	// continue button
	if(clickedid == g_tdRegisterAcc[19])
	{
		if(!Bit_Get(Player_GetFlags(playerid), PFLAG_REGISTERED))
		{
			if(!p_szPassword[playerid][0])
				return Dialog_Show(playerid, DIALOG_STYLE_MSGBOX, "{D2B567}Error", "{3E3D53}- {FFFFFF}Introduce una {D2B567}contraseña válida {FFFFFF}para continuar.", "Entendido", "");

			Bit_Set(Player_GetFlags(playerid), PFLAG_CUSTOMIZING_PLAYER, true);

			inline const ScreenBlacked()
			{
				Transition_Pause(playerid);
				Intro_ToggleTextdraws(playerid, false);

				Player_SetSex(playerid, random(1));
				Player_SetAge(playerid, Random(18, 100));

				g_rgiSelectedSkin{playerid} = (random(8) + 1) + (9 * Player_GetSex(playerid));

				new skin = Intro_AdjustSkinToRange(playerid, g_rgiSelectedSkin{playerid});

				SetPlayerInterior(playerid, 1);
				SetPlayerCameraPos(playerid, 2.285412, 28.473848, 1199.728149);
				SetPlayerCameraLookAt(playerid, -1.571664, 25.374759, 1199.008056);

				FCNPC_Spawn(g_rgeIntroData[playerid][e_iIntroPlayer], skin, 0.6050, 27.6095, 1199.5938);
				FCNPC_SetAngle(g_rgeIntroData[playerid][e_iIntroPlayer], 359.3733);
				FCNPC_SetInterior(g_rgeIntroData[playerid][e_iIntroPlayer], 1);
				FCNPC_SetVirtualWorld(g_rgeIntroData[playerid][e_iIntroPlayer], VW_PLAYER + playerid);
				FCNPC_ApplyAnimation(g_rgeIntroData[playerid][e_iIntroPlayer], "PED", "SEAT_IDLE", 4.1, false, false, false, true, 0);
				FCNPC_SetAnimationByName(g_rgeIntroData[playerid][e_iIntroPlayer], "PED:SEAT_IDLE", 4.1, false, false, false, true, 0);

				for(new i = (sizeof(g_tdPlayerCustomization) - 1); i != -1; i -= 1)
				{
					TextDrawShowForPlayer(playerid, g_tdPlayerCustomization[i]);
				}

				new age[4 char];
				valstr(age, Player_GetAge(playerid), true);

				PlayerTextDrawSetString(playerid, p_tdPlayerCustomization{playerid}, age);
				PlayerTextDrawShow(playerid, p_tdPlayerCustomization{playerid});

				Transition_Resume(playerid);

				SelectTextDraw(playerid, 0xD2B567FF);
			}
			Transition_StartInline(using inline ScreenBlacked, playerid, 255, TRANSITION_IN);
		}
		else
		{
			if(isnull(p_szPassword[playerid]))
				return Dialog_Show(playerid, DIALOG_STYLE_MSGBOX, "{D2B567}Error", "{3E3D53}- {FFFFFF}Introduce la {D2B567}contraseña {FFFFFF}de tu cuenta para continuar.", "Entendido", "");

			inline const CheckResult(bool:result)
			{
				if(!result)
					return Dialog_Show(playerid, DIALOG_STYLE_MSGBOX, "{D2B567}Error", "{3E3D53}- {FFFFFF}La {D2B567}contraseña {FFFFFF}es incorrecta.", "Entendido", "");

				Bit_Set(Player_GetFlags(playerid), PFLAG_AUTHENTICATING, false);
				FillMemory(p_szPassword[playerid], '\0');

				inline const ScreenBlacked()
				{
					Transition_Pause(playerid);

					Intro_ToggleTextdraws(playerid, false);
					TextDrawHideForPlayer(playerid, g_tdLastConnection);
					
					new Float:x, Float:y, Float:z, Float:angle;
					Player_GetSpawnPos(playerid, x, y, z, angle);

					SetSpawnInfo(playerid, NO_TEAM, Player_GetSkin(playerid), x, y, z, angle, 0, 0, 0, 0, 0, 0);
					TogglePlayerSpectating(playerid, false);

					SetPlayerVirtualWorld(playerid, Player_GetVirtualWorld(playerid));
					SetPlayerInterior(playerid, Player_GetInterior(playerid));

					SetCameraBehindPlayer(playerid);
					
					Transition_Resume(playerid);
				}
				Transition_StartInline(using inline ScreenBlacked, playerid, 255, TRANSITION_IN);
			}
			BCrypt_CheckInline(p_szPassword[playerid], p_szPasswordHash[playerid], using inline CheckResult);
		}
		
		return 1;
	}
	// MALE BUTTON
	else if(clickedid == g_tdPlayerCustomization[11])
	{
		if(Bit_Get(Player_GetFlags(playerid), PFLAG_CUSTOMIZING_PLAYER))
		{
			if(Player_GetSex(playerid) == PLAYER_SEX_MALE)
				return 1;

			Player_SetSex(playerid, PLAYER_SEX_MALE);
			g_rgiSelectedSkin{playerid} -= 9;

			FCNPC_SetSkin(g_rgeIntroData[playerid][e_iIntroPlayer], Intro_AdjustSkinToRange(playerid, g_rgiSelectedSkin{playerid}));
			FCNPC_ApplyAnimation(g_rgeIntroData[playerid][e_iIntroPlayer], "PED", "SEAT_IDLE", 4.1, false, false, false, true, 0);
			FCNPC_SetAnimationByName(g_rgeIntroData[playerid][e_iIntroPlayer], "PED:SEAT_IDLE", 4.1, false, false, false, true, 0);
		}

		return 1;
	}
	// FEMALE BUTTON
	else if(clickedid == g_tdPlayerCustomization[12])
	{
		if(Bit_Get(Player_GetFlags(playerid), PFLAG_CUSTOMIZING_PLAYER))
		{
			if(Player_GetSex(playerid) == PLAYER_SEX_FEMALE)
				return 1;

			Player_SetSex(playerid, PLAYER_SEX_FEMALE);
			g_rgiSelectedSkin{playerid} += 9;

			FCNPC_SetSkin(g_rgeIntroData[playerid][e_iIntroPlayer], Intro_AdjustSkinToRange(playerid, g_rgiSelectedSkin{playerid}));
			FCNPC_ApplyAnimation(g_rgeIntroData[playerid][e_iIntroPlayer], "PED", "SEAT_IDLE", 4.1, false, false, false, true, 0);
			FCNPC_SetAnimationByName(g_rgeIntroData[playerid][e_iIntroPlayer], "PED:SEAT_IDLE", 4.1, false, false, false, true, 0);
		}

		return 1;
	}
	// LEFT BUTTON
	else if(clickedid == g_tdPlayerCustomization[18])
	{
		new skin = g_rgiSelectedSkin{playerid} - (9 * Player_GetSex(playerid));

		if(skin != 1)
		{
			g_rgiSelectedSkin{playerid} -= 1;
		}

		FCNPC_SetSkin(g_rgeIntroData[playerid][e_iIntroPlayer], Intro_AdjustSkinToRange(playerid, g_rgiSelectedSkin{playerid}));
		FCNPC_ApplyAnimation(g_rgeIntroData[playerid][e_iIntroPlayer], "PED", "SEAT_IDLE", 4.1, false, false, false, true, 0);
		FCNPC_SetAnimationByName(g_rgeIntroData[playerid][e_iIntroPlayer], "PED:SEAT_IDLE", 4.1, false, false, false, true, 0);
	}
	// RIGHT BUTTON
	else if(clickedid == g_tdPlayerCustomization[19])
	{
		new skin = g_rgiSelectedSkin{playerid} - (9 * Player_GetSex(playerid));

		if(skin != 9)
		{
			g_rgiSelectedSkin{playerid} += 1;
		}

		FCNPC_SetSkin(g_rgeIntroData[playerid][e_iIntroPlayer], Intro_AdjustSkinToRange(playerid, g_rgiSelectedSkin{playerid}));
		FCNPC_ApplyAnimation(g_rgeIntroData[playerid][e_iIntroPlayer], "PED", "SEAT_IDLE", 4.1, false, false, false, true, 0);
		FCNPC_SetAnimationByName(g_rgeIntroData[playerid][e_iIntroPlayer], "PED:SEAT_IDLE", 4.1, false, false, false, true, 0);
	}

	return 1;
}