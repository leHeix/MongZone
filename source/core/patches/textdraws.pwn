/*
**
** 	Prevents the "CancelSelectTextdDraw" native function from calling OnPlayerClickTextDraw
**								with INVALID_TEXT_DRAW.
**
*/

#if defined _PATCH_textdraws_
	#endinput
#endif
#define _PATCH_textdraws_

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