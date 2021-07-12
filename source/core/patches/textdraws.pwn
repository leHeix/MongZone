#include <YSI_Coding\y_hooks>

static s_rgiCancelTick[MAX_PLAYERS];

hook native CancelSelectTextDraw(playerid)
{
	s_rgiCancelTick[playerid] = GetTickCount();
	return continue(playerid);
}

hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(clickedid == Text:INVALID_TEXT_DRAW && s_rgiCancelTick[playerid] != 0)
	{
		if(s_rgiCancelTick[playerid] < GetTickCount() + 100)
		{
			s_rgiCancelTick[playerid] = 0;
			return ~1;
		}
	}

	return 1;
}