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
const MAX_NOTIFICATIONS = 3;

enum _:eNotificationData {
	String:e_sNotificationText,
	e_iNotificationTime
};

new
	g_rgiNotifUpdateTimer[MAX_PLAYERS][MAX_NOTIFICATIONS],
	g_rgiNotifDeltaCount[MAX_PLAYERS][MAX_NOTIFICATIONS char],
	Pool:g_rgpNotificationQueue[MAX_PLAYERS],
	Iterator:g_rgNotifUsed[MAX_PLAYERS]<MAX_NOTIFICATIONS>; // [0, 3) - ITERATOR NOT NEEDED, PERHAPS A BITSET?

forward NOTIFICATION_MoveRight(playerid, index, Float:max, delta, wait_after);
forward NOTIFICATION_MoveLeft(playerid, index, Float:max, delta);