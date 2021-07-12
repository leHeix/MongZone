#if defined _H_SERVER_TEXTDRAWS_
	#endinput
#endif

#define _H_SERVER_TEXTDRAWS_

new
	Text:g_tdRegisterAcc[24],
	Text:g_tdPlayerCustomization[20],
	Text:g_tdLastConnection;

new
	PlayerText:p_tdTransition[MAX_PLAYERS char],
	PlayerText:p_tdRegisterAcc[MAX_PLAYERS char][5 char],
	PlayerText:p_tdPlayerCustomization[MAX_PLAYERS char],
	PlayerText:p_tdSkinSelector[MAX_PLAYERS char];