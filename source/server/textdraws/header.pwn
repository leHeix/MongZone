#if defined _H_TEXTDRAWS_
	#endinput
#endif
#define _H_TEXTDRAWS_

new
	Text:g_tdRegisterAcc[25],
	Text:g_tdPlayerCustomization[20];

new
	PlayerText:p_tdTransition[MAX_PLAYERS char],
	PlayerText:p_tdRegisterAcc[MAX_PLAYERS][5 char],
	PlayerText:p_tdPlayerCustomization[MAX_PLAYERS char];