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
    frozen_syncs,
    last_update_tick,

    fake_health,
    fake_armor,
    Float:fake_facing_angle[4]
};

#if !defined _YSF_included
enum spawn_info_data {
    spawn_team,
    spawn_skin,
    Float:spawn_x,
    Float:spawn_y,
    Float:spawn_z,
    Float:spawn_rot
};

new 
    g_rgePlayerSpawnInfo[MAX_PLAYERS + 1][spawn_info_data];
#endif

new 
    g_rgePlayerSyncData[MAX_PLAYERS][player_sync_data],
    bool:g_bKnifeSync = true;

#define is_sync_frozen(%0,%1) ((g_rgePlayerSyncData[(%0)][frozen_syncs] >> (_:(%1))) & 1)
#define get_last_sync_of(%0,%1) (BitStream:g_rgePlayerSyncData[(%0)][last_sync_bs][(%1)])
#define get_last_sync_type(%0) (E_SYNC_TYPES:g_rgePlayerSyncData[(%0)][last_sync_type])
#define get_last_update_tick(%0) (g_rgePlayerSyncData[(%0)][last_update_tick])
#define get_player_fake_health(%0) (g_rgePlayerSyncData[(%0)][fake_health])
#define get_player_fake_armor(%0) (g_rgePlayerSyncData[(%0)][fake_armor])

#if defined _YSF_included
    #define is_player_paused IsPlayerPaused
#else
    #define is_player_paused(%0) (GetTickCount() - get_last_update_tick(%0) <= 2000)
#endif