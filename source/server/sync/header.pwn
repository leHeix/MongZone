#if defined _H_SERVER_SYNC_
    #endinput
#endif
#define _H_SERVER_SYNC_

enum E_SYNC_TYPES {
    E_PLAYER_SYNC = 0,
    E_AIM_SYNC,
    E_VEHICLE_SYNC,
    E_PASSENGER_SYNC,
    E_SPECTATING_SYNC,
    E_LAST_SYNC,
    E_ALL_SYNC
};

enum player_sync_data {
    E_SYNC_TYPES:last_sync_type,
    BitStream:last_sync_bs[E_SYNC_TYPES],
    frozen_syncs
};

new 
    g_rgePlayerSyncData[MAX_PLAYERS][player_sync_data];

#define is_sync_frozen(%0,%1) ((g_rgePlayerSyncData[(%0)][frozen_syncs] >> (_:(%1))) & 1)
#define get_last_sync_of(%0,%1) (BitStream:g_rgePlayerSyncData[(%0)][last_sync_bs][(%1)])
#define get_last_sync_type(%0) (E_SYNC_TYPES:g_rgePlayerSyncData[(%0)][last_sync_type])
