#if defined _NOTIFICATIONS_FUNCTIONS_
	#endinput
#endif
#define _NOTIFICATIONS_FUNCTIONS_

Float:EaseInOutBack(Float:x)
{
	const Float:c2 = 2.5949095;

	return x < 0.5
	? (floatpower(2.0 * x, 2.0) * ((c2 + 1.0) * 2.0 * x - c2)) / 2.0
	: (floatpower(2.0 * x - 2.0, 2.0) * ((c2 + 1.0) * (x * 2.0 - 2.0) + c2) + 2.0) / 2.0;
}

Float:lerp(Float:p1, Float:p2, Float:t)
	return p1 + (p2 - p1) * t;

Notification_Show(playerid, String:text, time = 2000)
{
	new String:fixed_string = Str_FixEncoding_s(text);

	new td_idx = Iter_Free(g_rgNotifUsed[playerid]);
	if(td_idx == INVALID_ITERATOR_SLOT)
	{
		if(!pool_valid(g_rgpNotificationQueue[playerid]))
			g_rgpNotificationQueue[playerid] = pool_new(1);

		new item[eNotificationData];
		item[e_iNotificationTime] = time;
		item[e_sNotificationText] = str_acquire(fixed_string);

		pool_add_arr(g_rgpNotificationQueue[playerid], item);
		return 1;
	}

	Iter_Add(g_rgNotifUsed[playerid], td_idx);

	for(new i = 5; i != -1; i -= 1)
	{
		new Float:x, Float:y;
		PlayerTextDrawGetPos(playerid, p_tdNotifications[playerid][td_idx]{i}, x, y);
		PlayerTextDrawSetPos(playerid, p_tdNotifications[playerid][td_idx]{i}, x - NOT_SUB_VAL, y + (46.0 * td_idx));
	}

	new Float:size = 0.208333;
	for(new i = 0, j = str_len(fixed_string); i <= j; i += 45)
		size -= 0.015;

	new str[512];
	str_get(fixed_string, str);
	SplitTextDrawString(str, 127.5, size, 1, 1, true);
	str_set_format(fixed_string, str);
	PlayerTextDrawSetString_s(playerid, p_tdNotifications[playerid][td_idx]{4}, fixed_string);
	PlayerTextDrawLetterSize(playerid, p_tdNotifications[playerid][td_idx]{4}, size, 1.000000);

	g_rgiNotifDeltaCount[playerid][td_idx] = 0;
	g_rgiNotifUpdateTimer[playerid][td_idx] = SetTimerEx("NOTIFICATION_MoveRight", 8, true, "ddfdd", playerid, td_idx, 150.0, 1, time);

	return td_idx;
}

_Notification_ResetAll(playerid, index)
{
	PlayerTextDrawSetPos(playerid, p_tdNotifications[playerid][index]{0}, 108.0, 290.0);
	PlayerTextDrawSetPos(playerid, p_tdNotifications[playerid][index]{1}, 17.0, 293.0);
	PlayerTextDrawSetPos(playerid, p_tdNotifications[playerid][index]{2}, 20.50, 293.0);
	PlayerTextDrawSetPos(playerid, p_tdNotifications[playerid][index]{3}, 29.60, 299.0);
	PlayerTextDrawSetPos(playerid, p_tdNotifications[playerid][index]{4}, 50.0, 293.0);
	PlayerTextDrawSetPos(playerid, p_tdNotifications[playerid][index]{5}, 198.0, 289.0);
}

_Notification_ShowAll(playerid, index)
{
	PlayerTextDrawShow(playerid, p_tdNotifications[playerid][index]{0});
	PlayerTextDrawShow(playerid, p_tdNotifications[playerid][index]{1});
	PlayerTextDrawShow(playerid, p_tdNotifications[playerid][index]{2});
	PlayerTextDrawShow(playerid, p_tdNotifications[playerid][index]{3});
	PlayerTextDrawShow(playerid, p_tdNotifications[playerid][index]{4});
	PlayerTextDrawShow(playerid, p_tdNotifications[playerid][index]{5});
}

_Notification_HideAll(playerid, index)
{
	PlayerTextDrawHide(playerid, p_tdNotifications[playerid][index]{0});
	PlayerTextDrawHide(playerid, p_tdNotifications[playerid][index]{1});
	PlayerTextDrawHide(playerid, p_tdNotifications[playerid][index]{2});
	PlayerTextDrawHide(playerid, p_tdNotifications[playerid][index]{3});
	PlayerTextDrawHide(playerid, p_tdNotifications[playerid][index]{4});
	PlayerTextDrawHide(playerid, p_tdNotifications[playerid][index]{5});
}