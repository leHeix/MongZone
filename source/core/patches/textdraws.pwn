#if defined _PATCH_TEXTDRAWS_
	#endinput
#endif
#define _PATCH_TEXTDRAWS_

#include <YSI_Coding\y_hooks>

static s_rgiCancelTick[MAX_PLAYERS];

stock tdpatch_CancelSelectTextDraw(playerid)
{
	s_rgiCancelTick[playerid] = GetTickCount() + 100;
	return CancelSelectTextDraw(playerid);
}

#if defined _ALS_CancelSelectTextDraw
	#undef CancelSelectTextDraw
#else
	#define _ALS_CancelSelectTextDraw
#endif
#define CancelSelectTextDraw tdpatch_CancelSelectTextDraw

hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{	
	if(clickedid == Text:INVALID_TEXT_DRAW)
	{
		if(s_rgiCancelTick[playerid] > GetTickCount())
		{
			s_rgiCancelTick[playerid] = 0;
			return ~1;
		}
		else
		{
			CallLocalFunction("OnPlayerPressEsc", "i", playerid);
		}
	}

	return 1;
}