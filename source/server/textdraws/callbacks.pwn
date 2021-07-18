#if defined _TEXTDRAWS_CALLBACKS_
	#endinput
#endif
#define _TEXTDRAWS_CALLBACKS_

#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid)
{
	p_tdTransition{playerid} = CreatePlayerTextDraw(playerid, 317.000000, -56.000000, !"_");
	PlayerTextDrawFont(playerid, p_tdTransition{playerid}, 1);
	PlayerTextDrawLetterSize(playerid, p_tdTransition{playerid}, 0.600000, 124.850006);
	PlayerTextDrawTextSize(playerid, p_tdTransition{playerid}, 298.500000, 1236.000000);
	PlayerTextDrawSetOutline(playerid, p_tdTransition{playerid}, 1);
	PlayerTextDrawSetShadow(playerid, p_tdTransition{playerid}, 0);
	PlayerTextDrawAlignment(playerid, p_tdTransition{playerid}, 2);
	PlayerTextDrawColor(playerid, p_tdTransition{playerid}, -1);
	PlayerTextDrawBackgroundColor(playerid, p_tdTransition{playerid}, 255);
	PlayerTextDrawBoxColor(playerid, p_tdTransition{playerid}, 195);
	PlayerTextDrawUseBox(playerid, p_tdTransition{playerid}, 1);
	PlayerTextDrawSetProportional(playerid, p_tdTransition{playerid}, 1);
	PlayerTextDrawSetSelectable(playerid, p_tdTransition{playerid}, 0);

	return 1;
}