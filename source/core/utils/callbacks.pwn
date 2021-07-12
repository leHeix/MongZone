#if defined _UTILS_CALLBACKS_
	#endinput
#endif
#define _UTILS_CALLBACKS_

#include <YSI_Coding\y_hooks>

hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(clickedid == Text:INVALID_TEXT_DRAW)
		CallLocalFunction("OnPlayerPressEsc", "d", playerid);

	return 1;
}