#if defined _SERVER_SYNC_CALLBACKS_
    #endinput
#endif
#define _SERVER_SYNC_CALLBACKS_

#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid)
{
    g_rgePlayerSyncData[playerid][fake_health] =
    g_rgePlayerSyncData[playerid][fake_armor] = 
    _:(g_rgePlayerSyncData[playerid][fake_facing_angle][0] = Float:0x7FFFFFFF);
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    g_rgePlayerSyncData[playerid][frozen_syncs] =
    _:(g_rgePlayerSyncData[playerid][last_sync_type] = E_SYNC_TYPES:0);

    for(new i = 4; i != -1; --i)
    {
        if(get_last_sync_of(playerid, E_SYNC_TYPES:i) != BitStream:0)
            BS_Delete(get_last_sync_of(playerid, E_SYNC_TYPES:i));
    }

    return 1;
}

IPacket:207(playerid, BitStream:bs)
{
    BS_IgnoreBits(bs, 8);

    new sync[PR_OnFootSync];

    if(is_sync_frozen(playerid, E_PLAYER_SYNC))
    {
        BS_ReadOnFootSync(get_last_sync_of(playerid, E_PLAYER_SYNC), sync);
        BS_ResetWritePointer(bs);
        BS_Reset(bs);
        BS_WriteUint8(bs, 207);
        BS_WriteOnFootSync(bs, sync);
    }
    else
    {
        if(get_last_sync_of(playerid, E_PLAYER_SYNC) == BitStream:0)
            get_last_sync_of(playerid, E_PLAYER_SYNC) = BS_New();
        else
            BS_Reset(get_last_sync_of(playerid, E_PLAYER_SYNC));

        BS_ReadOnFootSync(bs, sync);

        if(!g_bKnifeSync && sync[PR_weaponId] == 4)
            sync[PR_keys] &= ~128;

        BS_WriteOnFootSync(get_last_sync_of(playerid, E_PLAYER_SYNC), sync);
    }

    g_rgePlayerSyncData[playerid][last_sync_type] = E_PLAYER_SYNC;

    return 1;
}

PR_Handler<PR_INCOMING_PACKET,aim_ssync_ip>:203(playerid, BitStream:bs)
{
    BS_IgnoreBits(bs, 8);

    new sync[PR_AimSync];

    if(is_sync_frozen(playerid, E_AIM_SYNC))
    {
        BS_ReadAimSync(get_last_sync_of(playerid, E_AIM_SYNC), sync);
        BS_ResetWritePointer(bs);
        BS_Reset(bs);
        BS_WriteUint8(bs, 203);
        BS_WriteAimSync(bs, sync);
    }
    else
    {
        if(get_last_sync_of(playerid, E_AIM_SYNC) == BitStream:0)
            get_last_sync_of(playerid, E_AIM_SYNC) = BS_New();
        else
            BS_Reset(get_last_sync_of(playerid, E_AIM_SYNC));

        BS_ReadAimSync(bs, sync);
        BS_WriteAimSync(get_last_sync_of(playerid, E_AIM_SYNC), sync);
    }

    g_rgePlayerSyncData[playerid][last_sync_type] = E_AIM_SYNC;

    return 1;
}

PR_Handler<PR_INCOMING_PACKET,veh_ssync_ip>:200(playerid, BitStream:bs)
{
    BS_IgnoreBits(bs, 8);

    new sync[PR_InCarSync];

    if(is_sync_frozen(playerid, E_VEHICLE_SYNC))
    {
        BS_ReadInCarSync(get_last_sync_of(playerid, E_VEHICLE_SYNC), sync);
        BS_ResetWritePointer(bs);
        BS_Reset(bs);
        BS_WriteUint8(bs, 200);
        BS_WriteInCarSync(bs, sync);
    }
    else
    {
        if(get_last_sync_of(playerid, E_VEHICLE_SYNC) == BitStream:0)
            get_last_sync_of(playerid, E_VEHICLE_SYNC) = BS_New();
        else
            BS_Reset(get_last_sync_of(playerid, E_VEHICLE_SYNC));

        BS_ReadInCarSync(bs, sync);
        BS_WriteInCarSync(get_last_sync_of(playerid, E_VEHICLE_SYNC), sync);
    }

    g_rgePlayerSyncData[playerid][last_sync_type] = E_VEHICLE_SYNC;

    return 1;
}

PR_Handler<PR_INCOMING_PACKET,passenger_ssync_ip>:211(playerid, BitStream:bs)
{
    BS_IgnoreBits(bs, 8);

    new sync[PR_PassengerSync];

    if(is_sync_frozen(playerid, E_PASSENGER_SYNC))
    {
        BS_ReadPassengerSync(get_last_sync_of(playerid, E_PASSENGER_SYNC), sync);
        BS_ResetWritePointer(bs);
        BS_Reset(bs);
        BS_WriteUint8(bs, 211);
        BS_WritePassengerSync(bs, sync);
    }
    else
    {
        if(get_last_sync_of(playerid, E_PASSENGER_SYNC) == BitStream:0)
            get_last_sync_of(playerid, E_PASSENGER_SYNC) = BS_New();
        else
            BS_Reset(get_last_sync_of(playerid, E_PASSENGER_SYNC));

        BS_ReadPassengerSync(bs, sync);
        BS_WritePassengerSync(get_last_sync_of(playerid, E_PASSENGER_SYNC), sync);
    }

    g_rgePlayerSyncData[playerid][last_sync_type] = E_PASSENGER_SYNC;

    return 1;
}

PR_Handler<PR_INCOMING_PACKET,spec_ssync_ip>:212(playerid, BitStream:bs)
{
    BS_IgnoreBits(bs, 8);

    new sync[PR_SpectatingSync];

    if(is_sync_frozen(playerid, E_SPECTATING_SYNC))
    {
        BS_ReadSpectatingSync(get_last_sync_of(playerid, E_SPECTATING_SYNC), sync);
        BS_ResetWritePointer(bs);
        BS_Reset(bs);
        BS_WriteUint8(bs, 212);
        BS_WriteSpectatingSync(bs, sync);
    }
    else
    {
        if(get_last_sync_of(playerid, E_SPECTATING_SYNC) == BitStream:0)
            get_last_sync_of(playerid, E_SPECTATING_SYNC) = BS_New();
        else
            BS_Reset(get_last_sync_of(playerid, E_SPECTATING_SYNC));

        BS_ReadSpectatingSync(bs, sync);
        BS_WriteSpectatingSync(get_last_sync_of(playerid, E_SPECTATING_SYNC), sync);
    }

    g_rgePlayerSyncData[playerid][last_sync_type] = E_SPECTATING_SYNC;

    return 1;
}
