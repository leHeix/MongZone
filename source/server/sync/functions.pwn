#if defined _SERVER_SYNC_FUNCTIONS_
    #endinput
#endif
#define _SERVER_SYNC_FUNCTIONS_

static get_last_player_sync(playerid, animation, &BitStream:dest)
{
    new BitStream:last_sync = get_last_sync_of(playerid, E_PLAYER_SYNC);
    
    BS_WriteUint8(dest, 207);

    new sync[PR_OnFootSync];
    BS_ReadOnFootSync(last_sync, sync);

    if(IsPlayerPaused(playerid))
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

FreezeSyncPacket(playerid, E_SYNC_TYPES:type = E_PLAYER_SYNC, bool:toggle)
{
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
        BS_Delete(g_rgePlayerSyncData[playerid][last_sync_bs][type]);
        g_rgePlayerSyncData[playerid][last_sync_bs][type] = BitStream:0;
    }

    return 1;
}

SendLastSyncData(playerid, toplayerid, E_SYNC_TYPES:type = E_PLAYER_SYNC, animation = 0)
{
    new BitStream:bs = BS_New();

    switch(type)
    {
        case E_PLAYER_SYNC: get_last_player_sync(playerid, animation, bs);
    }

    PR_SendPacket(bs, toplayerid, PR_HIGH_PRIORITY, PR_RELIABLE_SEQUENCED);

    BS_Delete(bs);

    return 1;
}

ClearAnimationsForPlayer(playerid, forplayerid)
{
    if(!IsPlayerConnected(playerid) || !IsPlayerConnected(forplayerid))
        return 0;

    new BitStream:bs = BS_New();
    BS_WriteUint16(bs, playerid);
    PR_SendRPC(bs, forplayerid, 87, PR_HIGH_PRIORITY, PR_RELIABLE_ORDERED);
    BS_Delete(bs);

    return 1;
}