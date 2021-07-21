#if defined _AUTH_FUNCTIONS_
	#endinput
#endif
#define _AUTH_FUNCTIONS_

forward __Intro_FirstWait(playerid);
public __Intro_FirstWait(playerid)
{
	InterpolateCameraPos(playerid, 1585.296142, -2566.993652, 13.769470, 1631.829467, -2568.340820, 13.502227, 10000);
	InterpolateCameraLookAt(playerid, 1580.729736, -2568.970458, 14.259890, 1636.329833, -2570.498779, 13.801852, 10000);

	SetPVarInt(playerid, !"introduction_timer", SetTimerEx("__Intro_SecondWait", 10000, false, "dd", playerid));

	return 1;
}

forward __Intro_SecondWait(playerid);
public __Intro_SecondWait(playerid)
{
	inline const ScreenBlacked()
	{
		Transition_Pause(playerid);

		// transition is paused, start pre-loading everything asap
		FCNPC_StopPlayingPlayback(g_rgeIntroData[playerid][e_iIntroPilot]);
		FCNPC_Kill(g_rgeIntroData[playerid][e_iIntroPilot]);
		DestroyVehicle(GetPVarInt(playerid, !"introduction_airplane"));

		if(!FCNPC_IsSpawned(g_rgeIntroData[playerid][e_iIntroPlayer]))
			FCNPC_Spawn(g_rgeIntroData[playerid][e_iIntroPlayer], 0, 0.0, 0.0, 0.0);

		FCNPC_ResetAnimation(g_rgeIntroData[playerid][e_iIntroPilot]);
		FCNPC_ClearAnimations(g_rgeIntroData[playerid][e_iIntroPilot]);

		FCNPC_SetPosition(g_rgeIntroData[playerid][e_iIntroPlayer], 1701.3771, -2209.7749, 1039.3802);
		FCNPC_SetVirtualWorld(g_rgeIntroData[playerid][e_iIntroPlayer], (VW_PLAYER + playerid));
		FCNPC_SetInterior(g_rgeIntroData[playerid][e_iIntroPlayer], 0);
		FCNPC_SetSkin(g_rgeIntroData[playerid][e_iIntroPlayer], Intro_AdjustSkinToRange(playerid, g_rgiSelectedSkin{playerid}));
		FCNPC_ClearAnimations(g_rgeIntroData[playerid][e_iIntroPlayer]);

		SetPlayerCameraPos(playerid, 1704.426269, -2209.828369, 1041.235351);
		SetPlayerCameraLookAt(playerid, 1699.817260, -2210.559570, 1039.440429);
	
		inline const ScreenDim()
		{
			print("screendim");
			FCNPC_StartPlayingPlayback(g_rgeIntroData[playerid][e_iIntroPlayer], "walk-into-baggage");

			InterpolateCameraPos(playerid, 1704.426269, -2209.828369, 1041.235351, 1699.402343, -2225.497314, 1039.668945, 12500);
			InterpolateCameraLookAt(playerid, 1699.817260, -2210.559570, 1039.440429, 1694.927978, -2227.583251, 1038.875488, 12500);

			inline const OnEnd()
			{
				print("onend called");
				__Intro_ThirdWait(playerid);
			}
			FCNPC_AwaitPlaybackEnd(g_rgeIntroData[playerid][e_iIntroPlayer], using inline OnEnd);
		}
		Transition_StartInline(using inline ScreenDim, playerid, 185, TRANSITION_OUT);
	}
	Transition_StartInline(using inline ScreenBlacked, playerid, 255, TRANSITION_IN);
	

	return 1;
}

forward __Intro_ThirdWait(playerid);
public __Intro_ThirdWait(playerid)
{
	new object = CreateObject(19624, 1690.1805, -2227.0757, 1039.0792, 87.7799, -0.6600, 0.0000, 200.0);
	MoveObject(object, 1696.1682,-2227.0432, 1039.0792, 0.7, 87.7799, -0.6600, 0.0000);

	SetPVarInt(playerid, !"introduction_case", object);

	InterpolateCameraPos(playerid, 1689.976440, -2225.817382, 1039.196289, 1694.091918, -2226.038330, 1039.196289, 6500);
	InterpolateCameraLookAt(playerid, 1690.045654, -2230.803955, 1038.837280, 1698.355957, -2228.624511, 1038.837280, 6500);

	SetPVarInt(playerid, !"introduction_timer", SetTimerEx("__Intro_FourthWait", 6500, false, "d", playerid));

	return 1;
}

forward __Intro_FourthWait(playerid);
public __Intro_FourthWait(playerid)
{
	FCNPC_SetAnimationByName(g_rgeIntroData[playerid][e_iIntroPlayer], "MISC:CASE_PICKUP", 2.0);

	SetPVarInt(playerid, !"introduction_timer", SetTimerEx("__Intro_FifthWait", 1000, false, "d", playerid));

	return 1;
}

forward __Intro_FifthWait(playerid);
public __Intro_FifthWait(playerid)
{
	FCNPC_ResetAnimation(g_rgeIntroData[playerid][e_iIntroPlayer]);
	FCNPC_ClearAnimations(g_rgeIntroData[playerid][e_iIntroPlayer]);

	AttachObjectToPlayer(GetPVarInt(playerid, !"introduction_case"), playerid, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);

	SetPVarInt(playerid, !"introduction_timer", SetTimerEx("__Intro_SixthWait", 1000, false, "d", playerid));
	return 1;
}

forward __Intro_SixthWait(playerid);
public __Intro_SixthWait(playerid)
{
	FCNPC_StartPlayingPlayback(g_rgeIntroData[playerid][e_iIntroPlayer], "walk-out-of-airport");

	InterpolateCameraPos(playerid, 1693.195312, -2230.917236, 1041.953613, 1705.496093, -2241.193115, 1041.461914, 12500);
	InterpolateCameraLookAt(playerid, 1696.139770, -2227.418701, 1039.931274, 1708.856933, -2237.616455, 1040.506835, 12500);

	SetPVarInt(playerid, !"introduction_timer", SetTimerEx("__Intro_SeventhWait", 9650, false, "d", playerid));

	return 1;
}

forward __Intro_SeventhWait(playerid);
public __Intro_SeventhWait(playerid)
{
	inline const ScreenBlacked()
	{
		FCNPC_StopPlayingPlayback(g_rgeIntroData[playerid][e_iIntroPlayer]);
		
		FCNPC_StartPlayingPlayback(g_rgeIntroData[playerid][e_iIntroPlayer], "walk-airport");

		InterpolateCameraPos(playerid, 1692.725097, -2332.482421, 15.741683, 1690.942016, -2325.254638, 14.613532, 7500);
		InterpolateCameraLookAt(playerid, 1688.456298, -2334.681396, 14.348384, 1686.107543, -2324.123779, 14.023233, 7500);

		SetPVarInt(playerid, !"introduction_timer", SetTimerEx("__Intro_EighthWait", 5500, false, "d", playerid));
	}
	Transition_StartInline(using inline ScreenBlacked, playerid, 255, TRANSITION_IN);

	return 1;
}

forward __Intro_EighthWait(playerid);
public __Intro_EighthWait(playerid)
{
	FCNPC_Spawn(g_rgeIntroData[playerid][e_iTaxiDriver], 221, 0.0, 0.0, 0.0);
	FCNPC_SetVirtualWorld(g_rgeIntroData[playerid][e_iTaxiDriver], VW_PLAYER + playerid);

	FCNPC_PutInVehicle(g_rgeIntroData[playerid][e_iTaxiDriver], GetPVarInt(playerid, !"introduction_taxi"), 0);
	FCNPC_StartPlayingPlayback(g_rgeIntroData[playerid][e_iTaxiDriver], "drive-in-taxi");

	SetPVarInt(playerid, !"introduction_timer", SetTimerEx("__Intro_NinethWait", 7500, false, "d", playerid));

	return 1;
}

forward __Intro_NinethWait(playerid);
public __Intro_NinethWait(playerid)
{
	FCNPC_ApplyAnimation(g_rgeIntroData[playerid][e_iIntroPlayer], "PED", "IDLE_TAXI", 2.0, false);
	FCNPC_SetAnimationByName(g_rgeIntroData[playerid][e_iIntroPlayer], "PED:IDLE_TAXI", 2.0, false);

	SetPVarInt(playerid, !"introduction_timer", SetTimerEx("__Intro_TenthWait", 1000, false, "d", playerid));

	return 1;
}

forward __Intro_TenthWait(playerid);
public __Intro_TenthWait(playerid)
{
	FCNPC_ClearAnimations(g_rgeIntroData[playerid][e_iIntroPlayer]);

	inline const PlaybackEnd()
	{
		SetPlayerCameraPos(playerid, 1677.123779, -2324.788330, 13.009157);
		SetPlayerCameraLookAt(playerid, 1681.670410, -2322.726562, 12.731955);

		FCNPC_EnterVehicle(g_rgeIntroData[playerid][e_iIntroPlayer], GetPVarInt(playerid, !"introduction_taxi"), 1, FCNPC_MOVE_TYPE_WALK);

		inline const VehicleEntry()
		{
			SetPVarInt(playerid, !"introduction_timer", SetTimerEx("__Intro_EleventhWait", 500, false, "d", playerid));
		}
		FCNPC_AwaitVehicleEntry(g_rgeIntroData[playerid][e_iIntroPlayer], using inline VehicleEntry);
	}
	FCNPC_AwaitPlaybackEnd(g_rgeIntroData[playerid][e_iTaxiDriver], using inline PlaybackEnd);

	return 1;
}

forward __Intro_EleventhWait(playerid);
public __Intro_EleventhWait(playerid)
{
	SetPlayerCameraPos(playerid, 1674.848144, -2319.061279, 14.110863);
	SetPlayerCameraLookAt(playerid, 1679.837036, -2319.092773, 13.779075);

	FCNPC_StartPlayingPlayback(g_rgeIntroData[playerid][e_iTaxiDriver], "drive-out-taxi");

	SetPVarInt(playerid, !"introduction_timer", SetTimerEx("__Intro_TwelfthWait", 5000, false, "d", playerid));

	return 1;
}

forward __Intro_TwelfthWait(playerid);
public __Intro_TwelfthWait(playerid)
{
	InterpolateCameraPos(playerid, 1674.848144, -2319.061279, 14.110863, 1671.073608, -2319.453369, 31.946434, 5000);
	InterpolateCameraLookAt(playerid, 1679.837036, -2319.092773, 13.779075, 1675.593994, -2319.407714, 34.082782, 5000);

	SetPVarInt(playerid, !"introduction_timer", SetTimerEx("__Intro_ThirteenthWait", 5000, false, "d", playerid));

	return 1;
}

forward __Intro_ThirteenthWait(playerid);
public __Intro_ThirteenthWait(playerid)
{	
	FCNPC_StopPlayingPlayback(g_rgeIntroData[playerid][e_iTaxiDriver]);
	FCNPC_StopPlayingPlayback(g_rgeIntroData[playerid][e_iIntroPlayer]);
	FCNPC_Kill(g_rgeIntroData[playerid][e_iIntroPlayer]);

	inline const ScreenBlacked()
	{
		Transition_Pause(playerid);
		SetPVarInt(playerid, !"introduction_timer", SetTimerEx("__Intro_FourteenthWait", 2500, false, "d", playerid));
	}
	Transition_StartInline(using inline ScreenBlacked, playerid, 255, TRANSITION_IN);

	return 1;
}

forward __Intro_FourteenthWait(playerid);
public __Intro_FourteenthWait(playerid)
{
	SetSpawnInfo(playerid, NO_TEAM, Player_Skin(playerid), 1483.0563, -1738.4750, 13.5469, 358.7972, 0, 0, 0, 0, 0, 0);
	TogglePlayerSpectating(playerid, false);

	new object = GetPVarInt(playerid, !"introduction_case");
	if(IsValidObject(object))
		DestroyObject(object);
	DeletePVar(playerid, !"introduction_case");

	TogglePlayerControllable(playerid, false);

	SetPlayerVirtualWorld(playerid, VW_PLAYER + playerid);
	SetPlayerInterior(playerid, 0);

	SetPlayerCameraPos(playerid, 1471.012817, -1744.991333, 17.595380);
	SetPlayerCameraLookAt(playerid, 1475.369384, -1742.709228, 16.694084);

	Transition_Resume(playerid);

	FCNPC_StartPlayingPlayback(g_rgeIntroData[playerid][e_iTaxiDriver], "taxi-go-out");

	inline const PlaybackEnd()
	{		
		FCNPC_StopPlayingPlayback(g_rgeIntroData[playerid][e_iTaxiDriver]);
		FCNPC_Kill(g_rgeIntroData[playerid][e_iTaxiDriver]);
		DestroyVehicle(GetPVarInt(playerid, !"introduction_taxi"));

		InterpolateCameraPos(playerid, 1471.012817, -1744.991333, 17.595380, 1483.190063, -1741.976318, 14.566541, 5000);
		InterpolateCameraLookAt(playerid, 1475.369384, -1742.709228, 16.694084, 1483.244384, -1737.013183, 13.962552, 5000);

		SetPVarInt(playerid, !"introduction_timer", SetTimerEx("__Intro_FifteenthWait", 5000, false, "d", playerid));
	}
	FCNPC_AwaitPlaybackEnd(g_rgeIntroData[playerid][e_iTaxiDriver], using inline PlaybackEnd);

	return 1;
}

forward __Intro_FifteenthWait(playerid);
public __Intro_FifteenthWait(playerid)
{
	SetPlayerVirtualWorld(playerid, VW_GENERAL);
	SetPlayerInterior(playerid, 0);

	SetCameraBehindPlayer(playerid);

	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);

	Streamer_UpdateEx(playerid, x, y, z, VW_GENERAL, 0, .freezeplayer = true);

	TogglePlayerControllable(playerid, true);

	DeletePVar(playerid, !"introduction_timer");
	DeletePVar(playerid, !"introduction_taxi");
	DeletePVar(playerid, !"introduction_airplane");

	new fun = GetPVarInt(playerid, !"introduction_callback");
	@.fun();
	Indirect_Release(fun);
	DeletePVar(playerid, !"itnroduction_callback");

	Bit_Set(Player_Flags(playerid), PFLAG_INTRODUCTION_RUNNING, false);

	return 1;
}

Intro_Play(playerid, Func:onend<>)
{
	Bit_Set(Player_Flags(playerid), PFLAG_INTRODUCTION_RUNNING, true);

	Indirect_Claim(onend);
	SetPVarInt(playerid, !"introduction_callback", _:onend);

	SetPlayerCameraPos(playerid, 1585.296142, -2566.993652, 13.769470);
	SetPlayerCameraLookAt(playerid, 1580.729736, -2568.970458, 14.259890);

	FCNPC_Spawn(g_rgeIntroData[playerid][e_iIntroPilot], 255, 0.0, 0.0, 1000.0 + (playerid * 2));
	FCNPC_SetVirtualWorld(g_rgeIntroData[playerid][e_iIntroPilot], (VW_PLAYER + playerid));
	FCNPC_SetInterior(g_rgeIntroData[playerid][e_iIntroPilot], 0);
	FCNPC_PutInVehicle(g_rgeIntroData[playerid][e_iIntroPilot], GetPVarInt(playerid, !"introduction_airplane"), 0);
	FCNPC_StartPlayingPlayback(g_rgeIntroData[playerid][e_iIntroPilot], "intro-airplane");

	SetPVarInt(playerid, !"introduction_timer", SetTimerEx("__Intro_FirstWait", 5000, false, "d", playerid));

	return 1;
}

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

	new age = Player_Age(playerid);

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