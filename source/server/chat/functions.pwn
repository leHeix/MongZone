#if defined _CHAT_FUNCTIONS_
	#endinput
#endif
#define _CHAT_FUNCTIONS_

Player_SendLocalMessage(playerid, const text[], Float:range = 15.0, color = -1, bool:require_streamed = true)
{
	new Float:x, Float:y, Float:z, vw = GetPlayerVirtualWorld(playerid), int = GetPlayerInterior(playerid);
	GetPlayerPos(playerid, x, y, z);

	foreach(new i : LoggedIn)
	{
		if(GetPlayerVirtualWorld(i) != vw || GetPlayerInterior(i) != int)
			continue;

		if(require_streamed && i != playerid)
		{
			if(IsPlayerStreamedIn(i, playerid))
				continue;
		}

		new Float:distance = GetPlayerDistanceFromPoint(i, x, y, z);
		if(distance > range)
			continue;

		new color_relative = 255 - floatround(distance);
		SendClientMessage(i, Color_Darken(color, color_relative), text);
	}

	return 1;
}

Player_SendLocalMessages(playerid, text_lines[][], line_count, Float:range = 15.0, color = -1, bool:require_streamed = true)
{
	new Float:x, Float:y, Float:z, vw = GetPlayerVirtualWorld(playerid), int = GetPlayerInterior(playerid);
	GetPlayerPos(playerid, x, y, z);

	foreach(new i : LoggedIn)
	{
		if(GetPlayerVirtualWorld(i) != vw || GetPlayerInterior(i) != int)
			continue;

		if(require_streamed && i != playerid)
		{
			if(IsPlayerStreamedIn(i, playerid))
				continue;
		}

		new Float:distance = GetPlayerDistanceFromPoint(i, x, y, z);
		if(distance > range)
			continue;

		new color_relative = 255 - floatround(distance);
		new color_darkened = Color_Darken(color, color_relative);

		for(new j; j != line_count && !isnull(text_lines[j]); ++j)
			SendClientMessage(i, color_darkened, text_lines[j]);
	}

	return 1;
}

stock Player_SendLocalMessage_s(playerid, ConstAmxString:text, Float:range = 15.0, color = -1, bool:require_streamed = true)
{
	new Float:x, Float:y, Float:z, vw = GetPlayerVirtualWorld(playerid), int = GetPlayerInterior(playerid);
	GetPlayerPos(playerid, x, y, z);

	foreach(new i : LoggedIn)
	{
		if(GetPlayerVirtualWorld(i) != vw || GetPlayerInterior(i) != int)
			continue;

		if(require_streamed && i != playerid)
		{
			if(IsPlayerStreamedIn(i, playerid))
				continue;
		}

		new Float:distance = GetPlayerDistanceFromPoint(i, x, y, z);
		if(distance > range)
			continue;

		new color_relative = 255 - floatround(distance);
		SendClientMessage_s(i, Color_Darken(color, color_relative), text);
	}

	return 1;
}