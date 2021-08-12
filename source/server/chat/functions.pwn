#if defined _CHAT_FUNCTIONS_
	#endinput
#endif
#define _CHAT_FUNCTIONS_

#define Color_RGBToHex(%0,%1,%2) (0xFF | ((%2) << 8) | ((%1) << 16) | ((%0) << 24))
#define Color_Darken(%0,%1) ((%0) & Color_RGBToHex((%1), (%1), (%1)))

Player_SendLocalMessage(playerid, const text[], Float:range = 15.0, color = -1)
{
	new Float:x, Float:y, Float:z, vw = GetPlayerVirtualWorld(playerid), int = GetPlayerInterior(playerid);
	GetPlayerPos(playerid, x, y, z);

	foreach(new i : StreamedPlayer[playerid])
	{
		if(GetPlayerVirtualWorld(i) != vw || GetPlayerInterior(i) != int)
			continue;

		new Float:distance = GetPlayerDistanceFromPoint(i, x, y, z);
		if(distance > range)
			continue;

		new color_relative = (255 - floatround(distance * 3.0))
		SendClientMessage(i, Color_Darken(color, color_relative), text);
	}

	SendClientMessage(playerid, color, text);

	return 1;
}

Player_SendLocalMessages(playerid, text_lines[][], line_count, Float:range = 15.0, color = -1)
{    
	new Float:x, Float:y, Float:z, vw = GetPlayerVirtualWorld(playerid), int = GetPlayerInterior(playerid);
	GetPlayerPos(playerid, x, y, z);

	foreach(new i : StreamedPlayer[playerid])
	{
		if(GetPlayerVirtualWorld(i) != vw || GetPlayerInterior(i) != int)
			continue;

		new Float:distance = GetPlayerDistanceFromPoint(i, x, y, z);
		if(distance > range)
			continue;

		new color_relative = (255 - floatround(distance * 3.0));
		new color_darkened = Color_Darken(color, color_relative);

		for(new j; j != line_count && !isnull(text_lines[j]); ++j)
			SendClientMessage(i, color_darkened, text_lines[j]);
	}

	for(new j; j != line_count && !isnull(text_lines[j]); ++j)
		SendClientMessage(playerid, color, text_lines[j]);

	return 1;
}

stock Player_SendLocalMessage_s(playerid, ConstStringTag:text, Float:range = 15.0, color = -1)
{
	new Float:x, Float:y, Float:z, vw = GetPlayerVirtualWorld(playerid), int = GetPlayerInterior(playerid);
	GetPlayerPos(playerid, x, y, z);

	foreach(new i : StreamedPlayer[playerid])
	{
		if(GetPlayerVirtualWorld(i) != vw || GetPlayerInterior(i) != int)
			continue;

		new Float:distance = GetPlayerDistanceFromPoint(i, x, y, z);
		if(distance > range)
			continue;

		new color_relative = 255 - floatround(distance);
		SendClientMessage_s(i, Color_Darken(color, color_relative), text);
	}

	SendClientMessage_s(i, color, text);

	return 1;
}