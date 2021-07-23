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

	TogglePlayerSpectating(playerid, true);
	SetPlayerVirtualWorld(playerid, VW_PLAYER + playerid);

	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	Intro_End(playerid);
	return 1;
}

public OnPlayerDataLoaded(playerid)
{
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

		SetPlayerWeather(playerid, 0);
		SetPlayerTime(playerid, 23, 00);

		Transition_Resume(playerid);
	}
	Transition_StartInline(using inline ScreenBlacked, playerid, 255, TRANSITION_IN);

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
	else if(Bit_Get(Player_Flags(playerid), PFLAG_CUSTOMIZING_PLAYER) && IsTextDrawVisibleForPlayer(playerid, g_tdPlayerCustomization[0]))
	{
		Bit_Set(Player_Flags(playerid), PFLAG_CUSTOMIZING_PLAYER, false);

		for(new i = (sizeof(g_tdPlayerCustomization) - 1); i != -1; i -= 1)
		{
			TextDrawHideForPlayer(playerid, g_tdPlayerCustomization[i]);
		}
		PlayerTextDrawHide(playerid, p_tdPlayerCustomization{playerid});
		CancelSelectTextDraw(playerid);

		Player_Skin(playerid) = FCNPC_GetSkin(g_rgeIntroData[playerid][e_iIntroPlayer]);

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
				Bit_Set(Player_Flags(playerid), PFLAG_REGISTERED, true);
				Bit_Set(Player_Flags(playerid), PFLAG_AUTHENTICATING, false);

				inline const OnIntroEnd()
				{
					Notification_Show(playerid, @("Se te ha habilitado el acceso al canal ~y~/n~w~. ¡Pregunta lo que quieras!"), 10000);
					Notification_Show(playerid, @f("Bienvenido a MongZone, %s. Tu cuenta fue registrada correctamente.", Player_GetName(playerid)), 10000);
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
		if(!isnull(p_szPassword[playerid]))
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
		if(Bit_Get(Player_Flags(playerid), PFLAG_CUSTOMIZING_PLAYER))
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

				Player_Age(playerid) = age;
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
		CancelSelectTextDraw(playerid);

		if(!Bit_Get(Player_Flags(playerid), PFLAG_REGISTERED))
		{
			if(isnull(p_szPassword[playerid]))
			{
				SelectTextDraw(playerid, 0xD2B567FF);
				return Dialog_Show(playerid, DIALOG_STYLE_MSGBOX, "{D2B567}Error", "{3E3D53}- {FFFFFF}Introduce una {D2B567}contraseña válida {FFFFFF}para continuar.", "Entendido", "");
			}

			Bit_Set(Player_Flags(playerid), PFLAG_CUSTOMIZING_PLAYER, true);

			inline const ScreenBlacked()
			{
				Transition_Pause(playerid);
				Intro_ToggleTextdraws(playerid, false);

				Player_Sex(playerid) = random(1);
				Player_Age(playerid) = Random(18, 100);

				g_rgiSelectedSkin{playerid} = (random(8) + 1) + (9 * Player_Sex(playerid));

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
				valstr(age, Player_Age(playerid), true);

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
			{
				SelectTextDraw(playerid, 0xD2B567FF);
				return Dialog_Show(playerid, DIALOG_STYLE_MSGBOX, "{D2B567}Error", "{3E3D53}- {FFFFFF}Introduce la {D2B567}contraseña {FFFFFF}de tu cuenta para continuar.", "Entendido", "");
			}

			inline const CheckResult(bool:result)
			{
				if(!result)
				{
					SelectTextDraw(playerid, 0xD2B567FF);
					return Dialog_Show(playerid, DIALOG_STYLE_MSGBOX, "{D2B567}Error", "{3E3D53}- {FFFFFF}La {D2B567}contraseña {FFFFFF}es incorrecta.", "Entendido", "");
				}

				Bit_Set(Player_Flags(playerid), PFLAG_AUTHENTICATING, false);
				FillMemory(p_szPassword[playerid], '\0');

				inline const ScreenBlacked()
				{
					Transition_Pause(playerid);

					Intro_ToggleTextdraws(playerid, false);

					new Float:x, Float:y, Float:z, Float:angle;
					Player_GetSpawnPos(playerid, x, y, z, angle);

					SetSpawnInfo(playerid, NO_TEAM, Player_Skin(playerid), x, y, z, angle, 0, 0, 0, 0, 0, 0);
					TogglePlayerSpectating(playerid, false);

					SetPlayerVirtualWorld(playerid, Player_VirtualWorld(playerid));
					SetPlayerInterior(playerid, Player_Interior(playerid));
					SetPlayerHealth(playerid, Player_Health(playerid));
					SetPlayerArmour(playerid, Player_Armour(playerid));
					GivePlayerMoney(playerid, Player_Money(playerid));

					SetCameraBehindPlayer(playerid);
					
					Transition_Resume(playerid);

					Iter_Add(LoggedIn, playerid);

					if(Player_Rank(playerid))
						Iter_Add(Admins, playerid);

					Notification_Show(playerid, @f("Bienvenido a MongZone, %s. Tu última conexión fue el ~y~%s~w~.", Player_GetName(playerid), Player_GetLastConnection(playerid)));
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
		if(Bit_Get(Player_Flags(playerid), PFLAG_CUSTOMIZING_PLAYER))
		{
			if(Player_Sex(playerid) == PLAYER_SEX_MALE)
				return 1;

			Player_Sex(playerid) = PLAYER_SEX_MALE;
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
		if(Bit_Get(Player_Flags(playerid), PFLAG_CUSTOMIZING_PLAYER))
		{
			if(Player_Sex(playerid) == PLAYER_SEX_FEMALE)
				return 1;

			Player_Sex(playerid) = PLAYER_SEX_FEMALE;
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
		new skin = g_rgiSelectedSkin{playerid} - (9 * Player_Sex(playerid));

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
		new skin = g_rgiSelectedSkin{playerid} - (9 * Player_Sex(playerid));

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