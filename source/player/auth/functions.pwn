#if defined _AUTH_FUNCTIONS_
	#endinput
#endif
#define _AUTH_FUNCTIONS_

Intro_SetUpVehicles(playerid)
{
	new airplane = CreateVehicle(577, 0.0, 0.0, 1000.0 + (playerid * 2), 0.0, -1, -1, -1, 0);
	SetVehicleVirtualWorld(airplane, (VW_PLAYER + playerid));
	LinkVehicleToInterior(airplane, 0);
	SetPVarInt(playerid, !"introduction_airplane", airplane);

	new taxi = CreateVehicle(420, 0.0, 0.0, 1000.0 + (playerid * 2), 0.0, 6, 6, -1, 0);
	SetVehicleVirtualWorld(taxi, (VW_PLAYER + playerid));
	LinkVehicleToInterior(taxi, 0);
	SetPVarInt(playerid, !"introduction_taxi", taxi);

	return 0;
}

Intro_End(playerid)
{
	if(GetPVarType(playerid, !"introduction_airplane") != PLAYER_VARTYPE_NONE)
		DestroyVehicle(GetPVarInt(playerid, !"introduction_airplane"));

	if(GetPVarType(playerid, !"introduction_taxi") != PLAYER_VARTYPE_NONE)
		DestroyVehicle(GetPVarInt(playerid, !"introduction_taxi"));
	
	if(GetPVarType(playerid, !"introduction_timer") == PLAYER_VARTYPE_NONE)
		return 0;

	if(GetPVarType(playerid, !"introduction_callback") != PLAYER_VARTYPE_NONE)
		Indirect_Release(GetPVarInt(playerid, !"introduction_callback"));

	DeletePVar(playerid, !"introduction_callback");
	KillTimer(GetPVarInt(playerid, !"introduction_timer"));
	DeletePVar(playerid, !"introduction_timer");
	DeletePVar(playerid, !"introduction_case");
	DeletePVar(playerid, !"introduction_airplane");
	DeletePVar(playerid, !"introduction_taxi");

	FCNPC_StopPlayingPlayback(g_rgeIntroData[playerid][e_iIntroPilot]);
	FCNPC_Kill(g_rgeIntroData[playerid][e_iIntroPilot]);
	FCNPC_StopPlayingPlayback(g_rgeIntroData[playerid][e_iIntroPlayer]);
	FCNPC_Kill(g_rgeIntroData[playerid][e_iIntroPlayer]);
	FCNPC_StopPlayingPlayback(g_rgeIntroData[playerid][e_iTaxiDriver]);
	FCNPC_Kill(g_rgeIntroData[playerid][e_iTaxiDriver]);

	return 0;
}

Intro_ToggleTextdraws(playerid, bool:show)
{
	if(show)
	{
		for (new i = (sizeof(g_tdRegisterAcc) - 2); i != -1; --i)
		{
			TextDrawShowForPlayer(playerid, g_tdRegisterAcc[i]);
		}

		PlayerTextDrawSetString(playerid, p_tdRegisterAcc[playerid]{0}, Str_FixEncoding(Player_GetName(playerid)));
		PlayerTextDrawShow(playerid, p_tdRegisterAcc[playerid]{0});
		PlayerTextDrawShow(playerid, p_tdRegisterAcc[playerid]{1});
		PlayerTextDrawShow(playerid, p_tdRegisterAcc[playerid]{2});
		PlayerTextDrawShow(playerid, p_tdRegisterAcc[playerid]{3});
		PlayerTextDrawShow(playerid, p_tdRegisterAcc[playerid]{4});

		SelectTextDraw(playerid, 0xD2B567FF);
	}
	else
	{
		for (new i = (sizeof(g_tdRegisterAcc) - 1); i != -1; --i)
		{
			TextDrawHideForPlayer(playerid, g_tdRegisterAcc[i]);
		}

		PlayerTextDrawHide(playerid, p_tdRegisterAcc[playerid]{0});
		PlayerTextDrawHide(playerid, p_tdRegisterAcc[playerid]{1});
		PlayerTextDrawHide(playerid, p_tdRegisterAcc[playerid]{2});
		PlayerTextDrawHide(playerid, p_tdRegisterAcc[playerid]{3});
		PlayerTextDrawHide(playerid, p_tdRegisterAcc[playerid]{4});

		CancelSelectTextDraw(playerid);
	}

	return 1;
}

Intro_AdjustSkinToRange(playerid, skin)
{
	assert skin >= 1 && skin <= 18;

	new age = Player_GetAge(playerid);

	if(IS_IN_RANGE(age, 35, 60))
	{
		skin += 18;
	}
	else if(IS_IN_RANGE(age, 61, 100))
	{
		skin += 36;
	}

	return g_rgiIntroSkins[skin];
}