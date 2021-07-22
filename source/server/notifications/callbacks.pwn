#if defined _NOTIFICATIONS_CALLBACKS_
	#endinput
#endif
#define _NOTIFICATIONS_CALLBACKS_

#include <YSI_Coding\y_hooks>

hook OnPlayerDisconnect(playerid, reason)
{
	for(new i = 2; i != -1; --i)
	{
		if(g_rgiNotifUpdateTimer[playerid][i] != -1)
			KillTimer(g_rgiNotifUpdateTimer[playerid][i]);
	}

	Iter_Clear(g_rgNotifUsed[playerid]);

	if(pool_valid(g_rgpNotificationQueue[playerid]))
		pool_delete_deep(g_rgpNotificationQueue[playerid]);
		
	return 1;
}

public NOTIFICATION_MoveRight(playerid, index, Float:max, delta, wait_after)
{
	g_rgiNotifDeltaCount[playerid][index] += delta;
	new Float:t = floatdiv(g_rgiNotifDeltaCount[playerid][index], max);
	new Float:x = lerp(0.0, 208.0, EaseInOutBack(t));

	PlayerTextDrawSetPos(playerid, p_tdNotifications[playerid][index]{0}, (108.0 - NOT_SUB_VAL) + x, 290.0 - (46.0 * index));
	PlayerTextDrawSetPos(playerid, p_tdNotifications[playerid][index]{1}, (17.0 - NOT_SUB_VAL) + x, 293.0 - (46.0 * index));
	PlayerTextDrawSetPos(playerid, p_tdNotifications[playerid][index]{2}, (20.50 - NOT_SUB_VAL) + x, 293.0 - (46.0 * index));
	PlayerTextDrawSetPos(playerid, p_tdNotifications[playerid][index]{3}, (29.60 - NOT_SUB_VAL) + x, 299.0 - (46.0 * index));
	PlayerTextDrawSetPos(playerid, p_tdNotifications[playerid][index]{4}, (50.0 - NOT_SUB_VAL) + x, 293.0 - (46.0 * index));
	PlayerTextDrawSetPos(playerid, p_tdNotifications[playerid][index]{5}, (198.0 - NOT_SUB_VAL) + x, 289.0 - (46.0 * index));

	_Notification_ShowAll(playerid, index);

	if(t >= 1.0)
	{
		KillTimer(g_rgiNotifUpdateTimer[playerid][index]);
		g_rgiNotifUpdateTimer[playerid][index] = SetTimerEx(!"__NOTIFICATION_Wait", wait_after, false, !"ddfd", playerid, index, max, -delta);
	}

	return 1;
}

forward __NOTIFICATION_Wait(playerid, index, max, delta);
public __NOTIFICATION_Wait(playerid, index, max, delta)
{
	g_rgiNotifUpdateTimer[playerid][index] = SetTimerEx(!"NOTIFICATION_MoveLeft", 8, true, !"ddfd", playerid, index, max, delta);
	return 1;
}

public NOTIFICATION_MoveLeft(playerid, index, Float:max, delta)
{
	g_rgiNotifDeltaCount[playerid][index] += delta;
	new Float:t = floatdiv(g_rgiNotifDeltaCount[playerid][index], max);
	new Float:x = lerp(208.0, 0.0, EaseInOutBack(t));

	if(t <= 0.0)
	{
		Iter_Remove(g_rgNotifUsed[playerid], index);
		
		_Notification_HideAll(playerid, index);
		_Notification_ResetAll(playerid, index);
		KillTimer(g_rgiNotifUpdateTimer[playerid][index]);
		g_rgiNotifUpdateTimer[playerid][index] = -1;

		// process queue
		if(pool_valid(g_rgpNotificationQueue[playerid]))
		{
			while(Iter_Free(g_rgNotifUsed[playerid]) != INVALID_ITERATOR_SLOT && pool_size(g_rgpNotificationQueue[playerid]) != 0)
			{
				new Iter:first = pool_iter(g_rgpNotificationQueue[playerid]);
				if(iter_valid(first))
				{
					new item[eNotificationData];
					iter_get_arr(first, item);
					Notification_Show(playerid, item[e_sNotificationText], item[e_iNotificationTime]);
					str_delete(item[e_sNotificationText]);
					iter_erase_deep(first);
				}
			}
		}

		return 1;
	}

	PlayerTextDrawSetPos(playerid, p_tdNotifications[playerid][index]{0}, 108.0 - x, 290.0 - (46.0 * index));
	PlayerTextDrawSetPos(playerid, p_tdNotifications[playerid][index]{1}, 17.0 - x, 293.0 - (46.0 * index));
	PlayerTextDrawSetPos(playerid, p_tdNotifications[playerid][index]{2}, 20.50 - x, 293.0 - (46.0 * index));
	PlayerTextDrawSetPos(playerid, p_tdNotifications[playerid][index]{3}, 29.60 - x, 299.0 - (46.0 * index));
	PlayerTextDrawSetPos(playerid, p_tdNotifications[playerid][index]{4}, 50.0 - x, 293.0 - (46.0 * index));
	PlayerTextDrawSetPos(playerid, p_tdNotifications[playerid][index]{5}, 198.0 - x, 289.0 - (46.0 * index));
	_Notification_ShowAll(playerid, index);

	return 1;
}