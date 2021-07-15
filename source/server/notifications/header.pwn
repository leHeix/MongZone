#if defined _H_NOTIFICATIONS_
	#endinput
#endif
#define _H_NOTIFICATIONS_

/* 
	animar textdraws es tan simple como sumar y restar
	- xylospeed
*/

const NOTIFICATION_DELTA = 1;
const Float:NOT_LAST_POS_X = 108.0;
const Float:NOT_INITIAL_POS_X = -100.0;
const Float:NOT_SUB_VAL = 208.0;
const Float:NOT_DISTANCE = 46.0;

enum _:eNotificationQueueItem
{
	e_iNotificationTime,
	e_szNotificationText[256]
};

new
	g_rgiNotifUpdateTimer[MAX_PLAYERS][3],
	g_rgiNotifDeltaCount[MAX_PLAYERS][3 char],
	Pool:g_rgpNotificationQueue[MAX_PLAYERS],
	Iterator:g_rgNotifUsed[MAX_PLAYERS]<3>; // [0, 2] - ITERATOR NOT NEEDED, PERHAPS A BITSET?

forward NOTIFICATION_MoveRight(playerid, index, Float:max, delta, wait_after);
forward NOTIFICATION_MoveLeft(playerid, index, Float:max, delta);