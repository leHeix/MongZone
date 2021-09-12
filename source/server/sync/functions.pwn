#if defined _SERVER_SYNC_FUNCTIONS_
    #endinput
#endif
#define _SERVER_SYNC_FUNCTIONS_

static get_last_player_sync(playerid, animation, &BitStream:dest)
{
    new BitStream:last_sync = get_last_sync_of(playerid, E_PLAYER_SYNC);
    printf("last_sync: %d - &dest: %d", _:last_sync, _:dest);

    BS_WriteUint8(dest, 207);

    new sync[PR_OnFootSync];
    BS_ReadOnFootSync(last_sync, sync);

    if(get_player_fake_health(playerid) != 0x7FFFFFFF)
    {
        sync[PR_health] = get_player_fake_health(playerid);
    }

    if(get_player_fake_armor(playerid) != 0x7FFFFFFF)
    {
        sync[PR_armour] = get_player_fake_armor(playerid);
    }

    if(g_rgePlayerSyncData[playerid][fake_facing_angle][0] != Float:0x7FFFFFFF)
    {
        sync[PR_quaternion][0] = g_rgePlayerSyncData[playerid][fake_facing_angle][0];
        sync[PR_quaternion][1] = g_rgePlayerSyncData[playerid][fake_facing_angle][1];
        sync[PR_quaternion][2] = g_rgePlayerSyncData[playerid][fake_facing_angle][2];
        sync[PR_quaternion][3] = g_rgePlayerSyncData[playerid][fake_facing_angle][3];
    }

    if(is_player_paused(playerid))
    {
        sync[PR_velocity][0] = 
        sync[PR_velocity][1] = 
        sync[PR_velocity][2] = 0.0;
    }

    if(!animation)
    {
        sync[PR_animationId] = 
        sync[PR_animationFlags] = 0;
    }

    BS_WriteOnFootSync(dest, sync, true);
}

static get_last_aim_sync(playerid, &BitStream:dest)
{
#if defined DEBUG_MODE
    printf("get_last_aim_sync(%d, %d)", playerid, _:dest);
#endif

    new BitStream:last_sync = get_last_sync_of(playerid, E_AIM_SYNC);
    printf("last_sync: %d - &dest: %d", _:last_sync, _:dest);
    
    BS_WriteUint8(dest, 203);
    
    new sync[PR_AimSync];
    BS_ReadAimSync(last_sync, sync);

    if((34 <= g_rgePlayerSyncData[playerid][last_weapon] <= 36) || g_rgePlayerSyncData[playerid][last_weapon] == 43)
    {
        if(sync[PR_camFrontVec][2] > 1.0)
        {
            sync[PR_aimZ] = 1.0;
        }
        else if(sync[PR_camFrontVec][2] < -1.0)
        {
            sync[PR_aimZ] = -1.0;
        }
    }

    if(g_rgePlayerSyncData[playerid][infinite_ammo])
    {
        sync[PR_camZoom] = 0b10;
    }

    BS_WriteAimSync(dest, sync);
}

static get_last_vehicle_sync(playerid, &BitStream:dest)
{
#if defined DEBUG_MODE
    printf("get_last_vehicle_sync(%d, %d)", playerid, _:dest);
#endif

    new BitStream:last_sync = get_last_sync_of(playerid, E_VEHICLE_SYNC);
    printf("last_sync: %d - &dest: %d", _:last_sync, _:dest);
    
    BS_WriteUint8(dest, 200);
    
    new sync[PR_InCarSync];
    BS_ReadInCarSync(last_sync, sync);

    if(g_rgePlayerSyncData[playerid][fake_facing_angle][0] != Float:0x7FFFFFFF)
    {
        sync[PR_quaternion][0] = g_rgePlayerSyncData[playerid][fake_facing_angle][0];
        sync[PR_quaternion][1] = g_rgePlayerSyncData[playerid][fake_facing_angle][1];
        sync[PR_quaternion][2] = g_rgePlayerSyncData[playerid][fake_facing_angle][2];
        sync[PR_quaternion][3] = g_rgePlayerSyncData[playerid][fake_facing_angle][3];
    }

    if(get_player_fake_health(playerid) != 0x7FFFFFFF)
    {
        sync[PR_playerHealth] = get_player_fake_health(playerid);
    }

    if(get_player_fake_armor(playerid) != 0x7FFFFFFF)
    {
        sync[PR_armour] = get_player_fake_armor(playerid);
    }

    BS_WriteInCarSync(dest, sync, true);
}

static get_last_passenger_sync(playerid, &BitStream:dest)
{
#if defined DEBUG_MODE
    printf("get_last_passenger_sync(%d, %d)", playerid, _:dest);
#endif

    new BitStream:last_sync = get_last_sync_of(playerid, E_PASSENGER_SYNC);
    printf("last_sync: %d - &dest: %d", _:last_sync, _:dest);

    new sync[PR_PassengerSync];
    BS_ReadPassengerSync(last_sync, sync);

    if(get_player_fake_health(playerid) != 0x7FFFFFFF)
    {
        sync[PR_playerHealth] = get_player_fake_health(playerid);
    }

    if(get_player_fake_armor(playerid) != 0x7FFFFFFF)
    {
        sync[PR_playerArmour] = get_player_fake_armor(playerid);
    }

    new health_armour;
    BS_PackHealthArmour(sync[PR_playerHealth], sync[PR_playerArmour], health_armour);

    BS_WriteValue(dest,
        PR_UINT8, 211, // packet id
        PR_UINT16, playerid,
        PR_UINT16, sync[PR_vehicleId],
        PR_BITS, sync[PR_driveBy], 2,
        PR_BITS, sync[PR_seatId], 6,
        PR_BITS, sync[PR_additionalKey], 2,
        PR_BITS, sync[PR_weaponId], 6,
        PR_UINT8, health_armour
    );

    if(sync[PR_udKey])
    {
        BS_WriteValue(dest,
            PR_BOOL, true,
            PR_UINT16, sync[PR_udKey]
        );
    }
    else
    {
        BS_WriteBool(dest, false);
    }

    if(sync[PR_lrKey])
    {
        BS_WriteValue(dest,
            PR_BOOL, true,
            PR_UINT16, sync[PR_lrKey]
        );
    }
    else
    {
        BS_WriteBool(dest, false);
    }

    BS_WriteValue(dest,
        PR_UINT16, sync[PR_keys],
        PR_VECTOR, sync[PR_position]
    );
}

static get_last_spectating_sync(playerid, &BitStream:dest)
{
#if defined DEBUG_MODE
    printf("get_last_spectating_sync(%d, %d)", playerid, _:dest);
#endif

    new BitStream:last_sync = get_last_sync_of(playerid, E_SPECTATING_SYNC);
    printf("last_sync: %d - &dest: %d", _:last_sync, _:dest);

    new sync[PR_SpectatingSync];
    BS_ReadSpectatingSync(last_sync, sync);
    
    BS_ReadValue(dest,
        PR_UINT8, 212, // packet id
        PR_UINT16, playerid,
    );

    if(sync[PR_lrKey])
    {
        BS_WriteValue(dest,
            PR_BOOL, true,
            PR_UINT16, sync[PR_lrKey]
        );
    }
    else
    {
        BS_WriteBool(dest, false);
    }

    if(sync[PR_udKey])
    {
        BS_WriteValue(dest,
            PR_BOOL, true,
            PR_UINT16, sync[PR_udKey]
        );
    }
    else
    {
        BS_WriteBool(dest, false);
    }

    BS_WriteValue(dest
        PR_UINT16, sync[PR_keys],
        PR_VECTOR, sync[PR_position]
    );
}

FreezeSyncPacket(playerid, E_SYNC_TYPES:type = E_PLAYER_SYNC, bool:toggle)
{
#if defined DEBUG_MODE
    printf("FreezeSyncPacket(%d, %d, %d)", playerid, _:type, toggle);
#endif

    if(!IsPlayerConnected(playerid))
        return 0;

    if(type == E_LAST_SYNC)
    {
        type = get_last_sync_type(playerid);
    }
    else if(type == E_ALL_SYNC)
    {
        for(new i = 4; i != -1; --i)
        {
            FreezeSyncPacket(playerid, E_SYNC_TYPES:i, toggle);
        }

        return 1;
    }
    
    if(toggle)
    {
        new BitStream:bs = get_last_sync_of(playerid, type);

        switch(type)
        {
            case E_PLAYER_SYNC:
            {
                new sync[PR_OnFootSync];
                BS_ReadOnFootSync(bs, sync);

                /*
                BS_SetWriteOffset(bs, 8);
                BS_WriteUint16(bs, 0);
                BS_WriteUint16(bs, 0);
                BS_SetWriteOffset(bs, 40);
                BS_WriteUint16(bs, 0);
                BS_SetWriteOffset(bs, 144);
                BS_WriteFloat3(bs, {0.0, 0.0, 0.0});
                BS_ResetWritePointer(bs);
                */

                sync[PR_velocity][0] =
                sync[PR_velocity][1] =
                sync[PR_velocity][2] = 0.0;
                sync[PR_specialAction] =
                sync[PR_keys] = 
                sync[PR_lrKey] =
                sync[PR_udKey] = 0;

                BS_Reset(bs);
                BS_WriteOnFootSync(bs, sync);
            }
            case E_VEHICLE_SYNC:
            {
                new sync[PR_InCarSync];
                BS_ReadInCarSync(bs, sync);
                sync[PR_velocity][0] =
                sync[PR_velocity][1] =
                sync[PR_velocity][2] = 0.0;
                sync[PR_keys] =
                sync[PR_lrKey] = 
                sync[PR_udKey] = 0;
                BS_Reset(bs);
                BS_WriteInCarSync(bs, sync);
            }
            case E_PASSENGER_SYNC:
            {
                new sync[PR_PassengerSync];
                BS_ReadPassengerSync(bs, sync);
                sync[PR_keys] = 
                sync[PR_lrKey] = 
                sync[PR_udKey] = 0;
                BS_Reset(bs);
                BS_WritePassengerSync(bs, sync); 
            }
            case E_SPECTATING_SYNC:
            {
                new sync[PR_SpectatingSync];
                BS_ReadSpectatingSync(bs, sync);
                sync[PR_lrKey] =
                sync[PR_udKey] =
                sync[PR_keys] = 0;
                BS_Reset(bs);
                BS_WriteSpectatingSync(bs, sync);
            }
        }

        g_rgePlayerSyncData[playerid][frozen_syncs] |= 1 << _:type;
    }
    else
    {
        g_rgePlayerSyncData[playerid][frozen_syncs] &= ~(1 << _:type);
        if(g_rgePlayerSyncData[playerid][last_sync_bs][type] != BitStream:0)
        {
            BS_Delete(g_rgePlayerSyncData[playerid][last_sync_bs][type]);
            g_rgePlayerSyncData[playerid][last_sync_bs][type] = BitStream:0;
        }
    }

    return 1;
}

SendLastSyncPacket(playerid, toplayerid, E_SYNC_TYPES:type = E_PLAYER_SYNC, animation = 0)
{
#if defined DEBUG_MODE
    printf("SendLastSyncPacket(%d, %d, %d, %d)", playerid, toplayerid, _:type, animation);
    printf("frozen_syncs(%d): %b", playerid, g_rgePlayerSyncData[playerid][frozen_syncs]);
    printf("frozen_syncs(%d): %b", toplayerid, g_rgePlayerSyncData[toplayerid][frozen_syncs]);
    printf("IsPlayerPaused(%d): %d", playerid, IsPlayerPaused(playerid));
    printf("IsPlayerPaused(%d): %d", toplayerid, IsPlayerPaused(toplayerid));
#endif

    if(!IsPlayerConnected(playerid) || !IsPlayerConnected(toplayerid))
        return 0;

    new BitStream:bs = BS_New();

    switch(type)
    {
        case E_PLAYER_SYNC: get_last_player_sync(playerid, animation, bs);
        case E_AIM_SYNC: get_last_aim_sync(playerid, bs);
        case E_VEHICLE_SYNC: get_last_vehicle_sync(playerid, bs);
        case E_PASSENGER_SYNC: get_last_passenger_sync(playerid, bs);
        case E_SPECTATING_SYNC: get_last_spectating_sync(playerid, bs);
        default: return 0;
    }

    PR_SendPacket(bs, toplayerid, PR_HIGH_PRIORITY, PR_UNRELIABLE_SEQUENCED);

    BS_Delete(bs);

    return 1;
}

ClearAnimationsForPlayer(playerid, forplayerid)
{
#if defined DEBUG_MODE
    printf("ClearAnimationsForPlayer(%d, %d)", playerid, forplayerid);
#endif

    if(!IsPlayerConnected(playerid) || !IsPlayerConnected(forplayerid))
        return 0;

    new BitStream:bs = BS_New();
    BS_WriteUint16(bs, playerid);
    PR_SendRPC(bs, forplayerid, 87, PR_HIGH_PRIORITY, PR_RELIABLE_ORDERED);
    BS_Delete(bs);

    return 1;
}

SetFakeHealth(playerid, health)
{
#if defined DEBUG_MODE
    printf("SetFakeHealth(%d, %d)", playerid, health);
#endif

    get_player_fake_health(playerid) = health;
    return 1;
}

SetFakeArmour(playerid, armor)
{
#if defined DEBUG_MODE
    printf("SetFakeArmour(%d, %d)", playerid, armor);
#endif

    get_player_fake_armor(playerid) =  armor;
    return 1;
}

SetFakeFacingAngle(playerid, Float:angle = Float:0x7FFFFFFF)
{
#if defined DEBUG_MODE
    printf("SetFakeFacingAngle(%d, %f)", playerid, angle);
#endif

    if(!IsPlayerConnected(playerid))
        return 0;

    if(angle == Float:0x7FFFFFFF)
    {
        g_rgePlayerSyncData[playerid][fake_facing_angle][0] =
        g_rgePlayerSyncData[playerid][fake_facing_angle][1] =
        g_rgePlayerSyncData[playerid][fake_facing_angle][2] =
        g_rgePlayerSyncData[playerid][fake_facing_angle][3] = Float:0x7FFFFFFF;
        return 1;
    }

    new Float:vec[3] = { 0.0, 0.0 };
    vec[2] = ((360.0 - angle) * 0.17453292519943295769236907684886); // z in radians

    new Float:vec_cos[3];
    vec_cos[0] =
    vec_cos[1] = floatcos(vec[1]);
    vec_cos[2] = floatcos(vec[2] * 0.5);

    new Float:vec_sin[3];
    vec_sin[0] = 
    vec_sin[1] = floatsin(vec[1]);
    vec_sin[2] = floatsin(vec[2] * 0.5);

    g_rgePlayerSyncData[playerid][fake_facing_angle][0] = vec_cos[0] * vec_cos[1] * vec_cos[2] + vec_sin[0] * vec_sin[1] * vec_sin[2]; // w
    g_rgePlayerSyncData[playerid][fake_facing_angle][1] = vec_sin[0] * vec_cos[1] * vec_cos[2] - vec_cos[0] * vec_sin[1] * vec_sin[2]; // x
    g_rgePlayerSyncData[playerid][fake_facing_angle][2] = vec_cos[0] * vec_sin[1] * vec_cos[2] + vec_sin[0] * vec_cos[1] * vec_sin[2]; // y
    g_rgePlayerSyncData[playerid][fake_facing_angle][3] = vec_cos[0] * vec_cos[1] * vec_sin[2] - vec_sin[0] * vec_sin[1] * vec_cos[2]; // z

    return 1;
}

SetKnifeSync(bool:set)
{
#if defined DEBUG_MODE
    printf("SetKnifeSync(%d)", set);
#endif

    g_bKnifeSync = set;
    return 1;
}

SpawnPlayerForWorld(playerid)
{
#if defined DEBUG_MODE
    printf("SpawnPlayerForWorld(%d)", playerid);
#endif

    if(!IsPlayerConnected(playerid))
        return 0;

#if defined _YSF_included
    SpawnForWorld(playerid);
#else
    new BitStream:bs = BS_New();
    
    BS_WriteValue(bs,
        PR_UINT16,  playerid,
        PR_UINT8,   g_rgePlayerSpawnInfo[spawn_team],
        PR_UINT32,  g_rgePlayerSpawnInfo[spawn_skin],
        PR_FLOAT,   g_rgePlayerSpawnInfo[spawn_x],
        PR_FLOAT,   g_rgePlayerSpawnInfo[spawn_y],
        PR_FLOAT,   g_rgePlayerSpawnInfo[spawn_z],
        PR_FLOAT,   g_rgePlayerSpawnInfo[spawn_rot],
        PR_UINT32,  GetPlayerColor(playerid),
        PR_UINT8,   GetPlayerFightingStyle(playerid)
    );

    PR_SendRPC(bs, playerid, 32);

    BS_Delete(bs);
#endif

    return 1;
}

stock SetInfiniteAmmoSync(playerid, bool:toggle)
{
    if(!IsPlayerConnected(playerid))
        return 0;

    g_rgePlayerSyncData[playerid][infinite_ammo] = toggle;
    return 1;
}

#if !defined _YSF_included
    stock MZ_SetSpawnInfo(playerid, team, skin, Float:x, Float:y, Float:z, Float:rotation, weapon1, weapon1_ammo, weapon2, weapon2_ammo, weapon3, weapon3_ammo)
    {
        g_rgePlayerSpawnInfo[playerid][spawn_team] = team;
        g_rgePlayerSpawnInfo[playerid][spawn_skin] = skin;
        g_rgePlayerSpawnInfo[playerid][spawn_x] = x;
        g_rgePlayerSpawnInfo[playerid][spawn_y] = y;
        g_rgePlayerSpawnInfo[playerid][spawn_z] = z;
        g_rgePlayerSpawnInfo[playerid][spawn_rot] = rotation;

        return SetSpawnInfo(playerid, team, skin, x, y, z, rotation, weapon1, weapon1_ammo, weapon2, weapon2_ammo, weapon3, weapon3_ammo);
    }

    #if defined _ALS_SetSpawnInfo
        #undef SetSpawnInfo
    #else
        #define _ALS_SetSpawnInfo
    #endif
    #define SetSpawnInfo MZ_SetSpawnInfo
#endif