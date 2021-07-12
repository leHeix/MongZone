#if defined _SERVER_TEXTDRAWS_CALLBACKS_
	#endinput
#endif

#define _SERVER_TEXTDRAWS_CALLBACKS_

#include <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
	g_tdRegisterAcc[0] = TextDrawCreate(53.000000, -21.000000, !"_");
	TextDrawFont(g_tdRegisterAcc[0], 1);
	TextDrawLetterSize(g_tdRegisterAcc[0], -0.233333, 69.850006);
	TextDrawTextSize(g_tdRegisterAcc[0], 298.500000, 441.500000);
	TextDrawSetOutline(g_tdRegisterAcc[0], 1);
	TextDrawSetShadow(g_tdRegisterAcc[0], 0);
	TextDrawAlignment(g_tdRegisterAcc[0], 2);
	TextDrawColor(g_tdRegisterAcc[0], -1);
	TextDrawBackgroundColor(g_tdRegisterAcc[0], 255);
	TextDrawBoxColor(g_tdRegisterAcc[0], 336860240);
	TextDrawUseBox(g_tdRegisterAcc[0], 1);
	TextDrawSetProportional(g_tdRegisterAcc[0], 1);
	TextDrawSetSelectable(g_tdRegisterAcc[0], 0);

	g_tdRegisterAcc[1] = TextDrawCreate(139.000000, 26.000000, !"Zone");
	TextDrawFont(g_tdRegisterAcc[1], 2);
	TextDrawLetterSize(g_tdRegisterAcc[1], 0.237498, 1.300001);
	TextDrawTextSize(g_tdRegisterAcc[1], 400.000000, 272.500000);
	TextDrawSetOutline(g_tdRegisterAcc[1], 0);
	TextDrawSetShadow(g_tdRegisterAcc[1], 1);
	TextDrawAlignment(g_tdRegisterAcc[1], 2);
	TextDrawColor(g_tdRegisterAcc[1], -1685896705);
	TextDrawBackgroundColor(g_tdRegisterAcc[1], 336860200);
	TextDrawBoxColor(g_tdRegisterAcc[1], -16777166);
	TextDrawUseBox(g_tdRegisterAcc[1], 0);
	TextDrawSetProportional(g_tdRegisterAcc[1], 1);
	TextDrawSetSelectable(g_tdRegisterAcc[1], 0);

	g_tdRegisterAcc[2] = TextDrawCreate(138.000000, 14.000000, !"MONG");
	TextDrawFont(g_tdRegisterAcc[2], 3);
	TextDrawLetterSize(g_tdRegisterAcc[2], 0.362500, 1.350002);
	TextDrawTextSize(g_tdRegisterAcc[2], 400.000000, 272.500000);
	TextDrawSetOutline(g_tdRegisterAcc[2], 0);
	TextDrawSetShadow(g_tdRegisterAcc[2], 1);
	TextDrawAlignment(g_tdRegisterAcc[2], 2);
	TextDrawColor(g_tdRegisterAcc[2], -741092353);
	TextDrawBackgroundColor(g_tdRegisterAcc[2], 336860200);
	TextDrawBoxColor(g_tdRegisterAcc[2], -16777166);
	TextDrawUseBox(g_tdRegisterAcc[2], 0);
	TextDrawSetProportional(g_tdRegisterAcc[2], 1);
	TextDrawSetSelectable(g_tdRegisterAcc[2], 0);

	g_tdRegisterAcc[3] = TextDrawCreate(137.000000, 51.000000, !"_");
	TextDrawFont(g_tdRegisterAcc[3], 1);
	TextDrawLetterSize(g_tdRegisterAcc[3], 0.600000, -0.399996);
	TextDrawTextSize(g_tdRegisterAcc[3], 298.500000, 260.000000);
	TextDrawSetOutline(g_tdRegisterAcc[3], 1);
	TextDrawSetShadow(g_tdRegisterAcc[3], 0);
	TextDrawAlignment(g_tdRegisterAcc[3], 2);
	TextDrawColor(g_tdRegisterAcc[3], -1);
	TextDrawBackgroundColor(g_tdRegisterAcc[3], 255);
	TextDrawBoxColor(g_tdRegisterAcc[3], -741092473);
	TextDrawUseBox(g_tdRegisterAcc[3], 1);
	TextDrawSetProportional(g_tdRegisterAcc[3], 1);
	TextDrawSetSelectable(g_tdRegisterAcc[3], 0);

	g_tdRegisterAcc[4] = TextDrawCreate(138.000000, 95.000000, !"Usuario");
	TextDrawFont(g_tdRegisterAcc[4], 2);
	TextDrawLetterSize(g_tdRegisterAcc[4], 0.183329, 1.050001);
	TextDrawTextSize(g_tdRegisterAcc[4], 400.000000, 272.500000);
	TextDrawSetOutline(g_tdRegisterAcc[4], 0);
	TextDrawSetShadow(g_tdRegisterAcc[4], 0);
	TextDrawAlignment(g_tdRegisterAcc[4], 2);
	TextDrawColor(g_tdRegisterAcc[4], -1094795521);
	TextDrawBackgroundColor(g_tdRegisterAcc[4], 336860200);
	TextDrawBoxColor(g_tdRegisterAcc[4], -16777166);
	TextDrawUseBox(g_tdRegisterAcc[4], 0);
	TextDrawSetProportional(g_tdRegisterAcc[4], 1);
	TextDrawSetSelectable(g_tdRegisterAcc[4], 0);

	g_tdRegisterAcc[5] = TextDrawCreate(137.000000, 109.000000, !"_");
	TextDrawFont(g_tdRegisterAcc[5], 1);
	TextDrawLetterSize(g_tdRegisterAcc[5], 0.600000, 1.750002);
	TextDrawTextSize(g_tdRegisterAcc[5], 298.500000, 260.000000);
	TextDrawSetOutline(g_tdRegisterAcc[5], 1);
	TextDrawSetShadow(g_tdRegisterAcc[5], 0);
	TextDrawAlignment(g_tdRegisterAcc[5], 2);
	TextDrawColor(g_tdRegisterAcc[5], -1);
	TextDrawBackgroundColor(g_tdRegisterAcc[5], 255);
	TextDrawBoxColor(g_tdRegisterAcc[5], -741092533);
	TextDrawUseBox(g_tdRegisterAcc[5], 1);
	TextDrawSetProportional(g_tdRegisterAcc[5], 1);
	TextDrawSetSelectable(g_tdRegisterAcc[5], 0);

	g_tdRegisterAcc[6] = TextDrawCreate(138.000000, 145.000000, Str_FixEncoding("Contraseña"));
	TextDrawFont(g_tdRegisterAcc[6], 2);
	TextDrawLetterSize(g_tdRegisterAcc[6], 0.183329, 1.050001);
	TextDrawTextSize(g_tdRegisterAcc[6], 400.000000, 272.500000);
	TextDrawSetOutline(g_tdRegisterAcc[6], 0);
	TextDrawSetShadow(g_tdRegisterAcc[6], 0);
	TextDrawAlignment(g_tdRegisterAcc[6], 2);
	TextDrawColor(g_tdRegisterAcc[6], -1094795521);
	TextDrawBackgroundColor(g_tdRegisterAcc[6], 336860200);
	TextDrawBoxColor(g_tdRegisterAcc[6], -16777166);
	TextDrawUseBox(g_tdRegisterAcc[6], 0);
	TextDrawSetProportional(g_tdRegisterAcc[6], 1);
	TextDrawSetSelectable(g_tdRegisterAcc[6], 0);

	/* UPPER TEXT */
	g_tdRegisterAcc[7] = TextDrawCreate(138.000000, 62.000000, !"Cuenta no registrada");
	TextDrawFont(g_tdRegisterAcc[7], 2);
	TextDrawLetterSize(g_tdRegisterAcc[7], 0.183329, 1.050001);
	TextDrawTextSize(g_tdRegisterAcc[7], 400.000000, 272.500000);
	TextDrawSetOutline(g_tdRegisterAcc[7], 0);
	TextDrawSetShadow(g_tdRegisterAcc[7], 0);
	TextDrawAlignment(g_tdRegisterAcc[7], 2);
	TextDrawColor(g_tdRegisterAcc[7], -1094795521);
	TextDrawBackgroundColor(g_tdRegisterAcc[7], 336860200);
	TextDrawBoxColor(g_tdRegisterAcc[7], -16777166);
	TextDrawUseBox(g_tdRegisterAcc[7], 0);
	TextDrawSetProportional(g_tdRegisterAcc[7], 1);
	TextDrawSetSelectable(g_tdRegisterAcc[7], 0);

	g_tdRegisterAcc[8] = TextDrawCreate(137.000000, 159.000000, !"_");
	TextDrawFont(g_tdRegisterAcc[8], 1);
	TextDrawLetterSize(g_tdRegisterAcc[8], 0.600000, 1.750002);
	TextDrawTextSize(g_tdRegisterAcc[8], 298.500000, 260.000000);
	TextDrawSetOutline(g_tdRegisterAcc[8], 1);
	TextDrawSetShadow(g_tdRegisterAcc[8], 0);
	TextDrawAlignment(g_tdRegisterAcc[8], 2);
	TextDrawColor(g_tdRegisterAcc[8], -1);
	TextDrawBackgroundColor(g_tdRegisterAcc[8], 255);
	TextDrawBoxColor(g_tdRegisterAcc[8], -741092533);
	TextDrawUseBox(g_tdRegisterAcc[8], 1);
	TextDrawSetProportional(g_tdRegisterAcc[8], 1);
	TextDrawSetSelectable(g_tdRegisterAcc[8], 0);

	g_tdRegisterAcc[9] = TextDrawCreate(7.000000, 110.000000, !"HUD:radar_gangn");
	TextDrawFont(g_tdRegisterAcc[9], 4);
	TextDrawLetterSize(g_tdRegisterAcc[9], 0.600000, 2.000000);
	TextDrawTextSize(g_tdRegisterAcc[9], 13.500000, 13.500000);
	TextDrawSetOutline(g_tdRegisterAcc[9], 1);
	TextDrawSetShadow(g_tdRegisterAcc[9], 0);
	TextDrawAlignment(g_tdRegisterAcc[9], 1);
	TextDrawColor(g_tdRegisterAcc[9], 109);
	TextDrawBackgroundColor(g_tdRegisterAcc[9], 255);
	TextDrawBoxColor(g_tdRegisterAcc[9], 50);
	TextDrawUseBox(g_tdRegisterAcc[9], 1);
	TextDrawSetProportional(g_tdRegisterAcc[9], 1);
	TextDrawSetSelectable(g_tdRegisterAcc[9], 0);

	g_tdRegisterAcc[10] = TextDrawCreate(14.000000, 157.500000, !"?");
	TextDrawFont(g_tdRegisterAcc[10], 3);
	TextDrawLetterSize(g_tdRegisterAcc[10], 0.349999, 1.900001);
	TextDrawTextSize(g_tdRegisterAcc[10], 400.000000, 272.500000);
	TextDrawSetOutline(g_tdRegisterAcc[10], 0);
	TextDrawSetShadow(g_tdRegisterAcc[10], 0);
	TextDrawAlignment(g_tdRegisterAcc[10], 2);
	TextDrawColor(g_tdRegisterAcc[10], 116);
	TextDrawBackgroundColor(g_tdRegisterAcc[10], 336860200);
	TextDrawBoxColor(g_tdRegisterAcc[10], -16777166);
	TextDrawUseBox(g_tdRegisterAcc[10], 0);
	TextDrawSetProportional(g_tdRegisterAcc[10], 1);
	TextDrawSetSelectable(g_tdRegisterAcc[10], 0);

	g_tdRegisterAcc[11] = TextDrawCreate(138.000000, 198.000000, !"Pregunta de seguridad");
	TextDrawFont(g_tdRegisterAcc[11], 2);
	TextDrawLetterSize(g_tdRegisterAcc[11], 0.183329, 1.050001);
	TextDrawTextSize(g_tdRegisterAcc[11], 400.000000, 272.500000);
	TextDrawSetOutline(g_tdRegisterAcc[11], 0);
	TextDrawSetShadow(g_tdRegisterAcc[11], 0);
	TextDrawAlignment(g_tdRegisterAcc[11], 2);
	TextDrawColor(g_tdRegisterAcc[11], -1094795521);
	TextDrawBackgroundColor(g_tdRegisterAcc[11], 336860200);
	TextDrawBoxColor(g_tdRegisterAcc[11], -16777166);
	TextDrawUseBox(g_tdRegisterAcc[11], 0);
	TextDrawSetProportional(g_tdRegisterAcc[11], 1);
	TextDrawSetSelectable(g_tdRegisterAcc[11], 0);

	g_tdRegisterAcc[12] = TextDrawCreate(137.000000, 212.000000, !"_");
	TextDrawFont(g_tdRegisterAcc[12], 1);
	TextDrawLetterSize(g_tdRegisterAcc[12], 0.600000, 1.750002);
	TextDrawTextSize(g_tdRegisterAcc[12], 298.500000, 260.000000);
	TextDrawSetOutline(g_tdRegisterAcc[12], 1);
	TextDrawSetShadow(g_tdRegisterAcc[12], 0);
	TextDrawAlignment(g_tdRegisterAcc[12], 2);
	TextDrawColor(g_tdRegisterAcc[12], -1);
	TextDrawBackgroundColor(g_tdRegisterAcc[12], 255);
	TextDrawBoxColor(g_tdRegisterAcc[12], -741092533);
	TextDrawUseBox(g_tdRegisterAcc[12], 1);
	TextDrawSetProportional(g_tdRegisterAcc[12], 1);
	TextDrawSetSelectable(g_tdRegisterAcc[12], 0);

	g_tdRegisterAcc[13] = TextDrawCreate(15.000000, 213.500000, !"!");
	TextDrawFont(g_tdRegisterAcc[13], 2);
	TextDrawLetterSize(g_tdRegisterAcc[13], 0.333332, 1.450001);
	TextDrawTextSize(g_tdRegisterAcc[13], 400.000000, 272.500000);
	TextDrawSetOutline(g_tdRegisterAcc[13], 0);
	TextDrawSetShadow(g_tdRegisterAcc[13], 0);
	TextDrawAlignment(g_tdRegisterAcc[13], 2);
	TextDrawColor(g_tdRegisterAcc[13], 76);
	TextDrawBackgroundColor(g_tdRegisterAcc[13], 336860200);
	TextDrawBoxColor(g_tdRegisterAcc[13], -16777166);
	TextDrawUseBox(g_tdRegisterAcc[13], 0);
	TextDrawSetProportional(g_tdRegisterAcc[13], 1);
	TextDrawSetSelectable(g_tdRegisterAcc[13], 0);

	g_tdRegisterAcc[14] = TextDrawCreate(137.000000, 262.000000, !"_");
	TextDrawFont(g_tdRegisterAcc[14], 1);
	TextDrawLetterSize(g_tdRegisterAcc[14], 0.600000, 1.750002);
	TextDrawTextSize(g_tdRegisterAcc[14], 298.500000, 260.000000);
	TextDrawSetOutline(g_tdRegisterAcc[14], 1);
	TextDrawSetShadow(g_tdRegisterAcc[14], 0);
	TextDrawAlignment(g_tdRegisterAcc[14], 2);
	TextDrawColor(g_tdRegisterAcc[14], -1);
	TextDrawBackgroundColor(g_tdRegisterAcc[14], 255);
	TextDrawBoxColor(g_tdRegisterAcc[14], -741092533);
	TextDrawUseBox(g_tdRegisterAcc[14], 1);
	TextDrawSetProportional(g_tdRegisterAcc[14], 1);
	TextDrawSetSelectable(g_tdRegisterAcc[14], 0);

	g_tdRegisterAcc[15] = TextDrawCreate(14.500000, 260.500000, !"$");
	TextDrawFont(g_tdRegisterAcc[15], 3);
	TextDrawLetterSize(g_tdRegisterAcc[15], 0.349999, 1.900001);
	TextDrawTextSize(g_tdRegisterAcc[15], 400.000000, 272.500000);
	TextDrawSetOutline(g_tdRegisterAcc[15], 0);
	TextDrawSetShadow(g_tdRegisterAcc[15], 0);
	TextDrawAlignment(g_tdRegisterAcc[15], 2);
	TextDrawColor(g_tdRegisterAcc[15], 116);
	TextDrawBackgroundColor(g_tdRegisterAcc[15], 336860200);
	TextDrawBoxColor(g_tdRegisterAcc[15], -16777166);
	TextDrawUseBox(g_tdRegisterAcc[15], 0);
	TextDrawSetProportional(g_tdRegisterAcc[15], 1);
	TextDrawSetSelectable(g_tdRegisterAcc[15], 0);

	g_tdRegisterAcc[16] = TextDrawCreate(138.000000, 249.000000, Str_FixEncoding("Código de referido"));
	TextDrawFont(g_tdRegisterAcc[16], 2);
	TextDrawLetterSize(g_tdRegisterAcc[16], 0.183329, 1.050001);
	TextDrawTextSize(g_tdRegisterAcc[16], 400.000000, 272.500000);
	TextDrawSetOutline(g_tdRegisterAcc[16], 0);
	TextDrawSetShadow(g_tdRegisterAcc[16], 0);
	TextDrawAlignment(g_tdRegisterAcc[16], 2);
	TextDrawColor(g_tdRegisterAcc[16], -1094795521);
	TextDrawBackgroundColor(g_tdRegisterAcc[16], 336860200);
	TextDrawBoxColor(g_tdRegisterAcc[16], -16777166);
	TextDrawUseBox(g_tdRegisterAcc[16], 0);
	TextDrawSetProportional(g_tdRegisterAcc[16], 1);
	TextDrawSetSelectable(g_tdRegisterAcc[16], 0);

	g_tdRegisterAcc[17] = TextDrawCreate(174.000000, 215.000000, !"_");
	TextDrawFont(g_tdRegisterAcc[17], 3);
	TextDrawLetterSize(g_tdRegisterAcc[17], 0.224996, 1.000000);
	TextDrawTextSize(g_tdRegisterAcc[17], 265.500000, 11.000000);
	TextDrawSetOutline(g_tdRegisterAcc[17], 1);
	TextDrawSetShadow(g_tdRegisterAcc[17], 0);
	TextDrawAlignment(g_tdRegisterAcc[17], 1);
	TextDrawColor(g_tdRegisterAcc[17], 135);
	TextDrawBackgroundColor(g_tdRegisterAcc[17], 336860160);
	TextDrawBoxColor(g_tdRegisterAcc[17], -16777166);
	TextDrawUseBox(g_tdRegisterAcc[17], 0);
	TextDrawSetProportional(g_tdRegisterAcc[17], 1);
	TextDrawSetSelectable(g_tdRegisterAcc[17], 0);

	g_tdRegisterAcc[18] = TextDrawCreate(88.000000, 312.000000, !"ld_bum:blkdot");
	TextDrawFont(g_tdRegisterAcc[18], 4);
	TextDrawLetterSize(g_tdRegisterAcc[18], 0.600000, 2.000000);
	TextDrawTextSize(g_tdRegisterAcc[18], 100.000000, 24.000000);
	TextDrawSetOutline(g_tdRegisterAcc[18], 1);
	TextDrawSetShadow(g_tdRegisterAcc[18], 0);
	TextDrawAlignment(g_tdRegisterAcc[18], 1);
	TextDrawColor(g_tdRegisterAcc[18], -1685896824);
	TextDrawBackgroundColor(g_tdRegisterAcc[18], 255);
	TextDrawBoxColor(g_tdRegisterAcc[18], 50);
	TextDrawUseBox(g_tdRegisterAcc[18], 1);
	TextDrawSetProportional(g_tdRegisterAcc[18], 1);
	TextDrawSetSelectable(g_tdRegisterAcc[18], 0);

	g_tdRegisterAcc[19] = TextDrawCreate(137.500000, 318.000000, !"Continuar");
	TextDrawFont(g_tdRegisterAcc[19], 3);
	TextDrawLetterSize(g_tdRegisterAcc[19], 0.249999, 1.100000);
	TextDrawTextSize(g_tdRegisterAcc[19], 10.500000, 97.000000);
	TextDrawSetOutline(g_tdRegisterAcc[19], 2);
	TextDrawSetShadow(g_tdRegisterAcc[19], 0);
	TextDrawAlignment(g_tdRegisterAcc[19], 2);
	TextDrawColor(g_tdRegisterAcc[19], 185);
	TextDrawBackgroundColor(g_tdRegisterAcc[19], 336860160);
	TextDrawBoxColor(g_tdRegisterAcc[19], -16777166);
	TextDrawUseBox(g_tdRegisterAcc[19], 0);
	TextDrawSetProportional(g_tdRegisterAcc[19], 1);
	TextDrawSetSelectable(g_tdRegisterAcc[19], 1);

	g_tdRegisterAcc[20] = TextDrawCreate(137.000000, 365.000000, !"_");
	TextDrawFont(g_tdRegisterAcc[20], 1);
	TextDrawLetterSize(g_tdRegisterAcc[20], 0.600000, -0.399996);
	TextDrawTextSize(g_tdRegisterAcc[20], 298.500000, 260.000000);
	TextDrawSetOutline(g_tdRegisterAcc[20], 1);
	TextDrawSetShadow(g_tdRegisterAcc[20], 0);
	TextDrawAlignment(g_tdRegisterAcc[20], 2);
	TextDrawColor(g_tdRegisterAcc[20], -1);
	TextDrawBackgroundColor(g_tdRegisterAcc[20], 255);
	TextDrawBoxColor(g_tdRegisterAcc[20], -741092473);
	TextDrawUseBox(g_tdRegisterAcc[20], 1);
	TextDrawSetProportional(g_tdRegisterAcc[20], 1);
	TextDrawSetSelectable(g_tdRegisterAcc[20], 0);

	g_tdRegisterAcc[21] = TextDrawCreate(270.000000, 417.000000, !"Jugadores conectados: 100_~n~Record de jugadores: 422_~n~Ultima actualizacion: 12/02/2021");
	TextDrawFont(g_tdRegisterAcc[21], 2);
	TextDrawLetterSize(g_tdRegisterAcc[21], 0.154161, 0.949998);
	TextDrawTextSize(g_tdRegisterAcc[21], 400.000000, 272.500000);
	TextDrawSetOutline(g_tdRegisterAcc[21], 0);
	TextDrawSetShadow(g_tdRegisterAcc[21], 1);
	TextDrawAlignment(g_tdRegisterAcc[21], 3);
	TextDrawColor(g_tdRegisterAcc[21], 76);
	TextDrawBackgroundColor(g_tdRegisterAcc[21], 336860200);
	TextDrawBoxColor(g_tdRegisterAcc[21], -16777166);
	TextDrawUseBox(g_tdRegisterAcc[21], 0);
	TextDrawSetProportional(g_tdRegisterAcc[21], 1);
	TextDrawSetSelectable(g_tdRegisterAcc[21], 0);

	g_tdRegisterAcc[22] = TextDrawCreate(5.500000, 370.500000, !"~w~Discord de Mong Servers: ~y~rakmong.com/mong-servers~n~~w~Discord de RakMong: ~y~rakmong.com/discord~n~~w~Foro de RakMong: ~y~forum.rakmong.com");
	TextDrawFont(g_tdRegisterAcc[22], 2);
	TextDrawLetterSize(g_tdRegisterAcc[22], 0.149990, 0.949996);
	TextDrawTextSize(g_tdRegisterAcc[22], 400.000000, 272.500000);
	TextDrawSetOutline(g_tdRegisterAcc[22], 0);
	TextDrawSetShadow(g_tdRegisterAcc[22], 1);
	TextDrawAlignment(g_tdRegisterAcc[22], 1);
	TextDrawColor(g_tdRegisterAcc[22], -1094795668);
	TextDrawBackgroundColor(g_tdRegisterAcc[22], 336860200);
	TextDrawBoxColor(g_tdRegisterAcc[22], -16777166);
	TextDrawUseBox(g_tdRegisterAcc[22], 0);
	TextDrawSetProportional(g_tdRegisterAcc[22], 1);
	TextDrawSetSelectable(g_tdRegisterAcc[22], 0);

	g_tdRegisterAcc[23] = TextDrawCreate(-2.000000, 208.000000, !"Preview_Model");
	TextDrawFont(g_tdRegisterAcc[23], 5);
	TextDrawLetterSize(g_tdRegisterAcc[23], 0.600000, 2.000000);
	TextDrawTextSize(g_tdRegisterAcc[23], 35.500000, 44.000000);
	TextDrawSetOutline(g_tdRegisterAcc[23], 0);
	TextDrawSetShadow(g_tdRegisterAcc[23], 0);
	TextDrawAlignment(g_tdRegisterAcc[23], 1);
	TextDrawColor(g_tdRegisterAcc[23], 76);
	TextDrawBackgroundColor(g_tdRegisterAcc[23], 0);
	TextDrawBoxColor(g_tdRegisterAcc[23], 255);
	TextDrawUseBox(g_tdRegisterAcc[23], 0);
	TextDrawSetProportional(g_tdRegisterAcc[23], 1);
	TextDrawSetSelectable(g_tdRegisterAcc[23], 0);
	TextDrawSetPreviewModel(g_tdRegisterAcc[23], 1614);
	TextDrawSetPreviewRot(g_tdRegisterAcc[23], -10.000000, 0.000000, -88.000000, 1.000000);
	TextDrawSetPreviewVehCol(g_tdRegisterAcc[23], 1, 1);

	/* LAST LOGIN DATE */
	g_tdLastConnection = TextDrawCreate(138.500000, 296.500000, !"_");
	TextDrawFont(g_tdLastConnection , 2);
	TextDrawLetterSize(g_tdLastConnection , 0.149990, 0.949994);
	TextDrawTextSize(g_tdLastConnection , 400.000000, 272.500000);
	TextDrawSetOutline(g_tdLastConnection , 0);
	TextDrawSetShadow(g_tdLastConnection , 1);
	TextDrawAlignment(g_tdLastConnection , 2);
	TextDrawColor(g_tdLastConnection , -1094795668);
	TextDrawBackgroundColor(g_tdLastConnection , 336860200);
	TextDrawBoxColor(g_tdLastConnection , -16777166);
	TextDrawUseBox(g_tdLastConnection , 0);
	TextDrawSetProportional(g_tdLastConnection , 1);
	TextDrawSetSelectable(g_tdLastConnection , 0);

	g_tdPlayerCustomization[0] = TextDrawCreate(244.000000, 274.000000, "HUD:skipicon");
	TextDrawFont(g_tdPlayerCustomization[0], 4);
	TextDrawLetterSize(g_tdPlayerCustomization[0], 0.600000, 2.000000);
	TextDrawTextSize(g_tdPlayerCustomization[0], -41.500000, 42.500000);
	TextDrawSetOutline(g_tdPlayerCustomization[0], 1);
	TextDrawSetShadow(g_tdPlayerCustomization[0], 0);
	TextDrawAlignment(g_tdPlayerCustomization[0], 1);
	TextDrawColor(g_tdPlayerCustomization[0], 135);
	TextDrawBackgroundColor(g_tdPlayerCustomization[0], 255);
	TextDrawBoxColor(g_tdPlayerCustomization[0], 50);
	TextDrawUseBox(g_tdPlayerCustomization[0], 1);
	TextDrawSetProportional(g_tdPlayerCustomization[0], 1);
	TextDrawSetSelectable(g_tdPlayerCustomization[0], 0);

	g_tdPlayerCustomization[1] = TextDrawCreate(377.000000, 273.000000, "HUD:skipicon");
	TextDrawFont(g_tdPlayerCustomization[1], 4);
	TextDrawLetterSize(g_tdPlayerCustomization[1], 0.600000, 2.000000);
	TextDrawTextSize(g_tdPlayerCustomization[1], 42.500000, 42.500000);
	TextDrawSetOutline(g_tdPlayerCustomization[1], 1);
	TextDrawSetShadow(g_tdPlayerCustomization[1], 0);
	TextDrawAlignment(g_tdPlayerCustomization[1], 1);
	TextDrawColor(g_tdPlayerCustomization[1], 135);
	TextDrawBackgroundColor(g_tdPlayerCustomization[1], 255);
	TextDrawBoxColor(g_tdPlayerCustomization[1], 50);
	TextDrawUseBox(g_tdPlayerCustomization[1], 1);
	TextDrawSetProportional(g_tdPlayerCustomization[1], 1);
	TextDrawSetSelectable(g_tdPlayerCustomization[1], 0);

	g_tdPlayerCustomization[2] = TextDrawCreate(310.000000, 315.000000, "_");
	TextDrawFont(g_tdPlayerCustomization[2], 1);
	TextDrawLetterSize(g_tdPlayerCustomization[2], 0.600000, 11.200003);
	TextDrawTextSize(g_tdPlayerCustomization[2], 298.500000, 154.000000);
	TextDrawSetOutline(g_tdPlayerCustomization[2], 1);
	TextDrawSetShadow(g_tdPlayerCustomization[2], 0);
	TextDrawAlignment(g_tdPlayerCustomization[2], 2);
	TextDrawColor(g_tdPlayerCustomization[2], -1);
	TextDrawBackgroundColor(g_tdPlayerCustomization[2], 255);
	TextDrawBoxColor(g_tdPlayerCustomization[2], 90);
	TextDrawUseBox(g_tdPlayerCustomization[2], 1);
	TextDrawSetProportional(g_tdPlayerCustomization[2], 1);
	TextDrawSetSelectable(g_tdPlayerCustomization[2], 0);

	g_tdPlayerCustomization[3] = TextDrawCreate(259.000000, 333.500000, "_");
	TextDrawFont(g_tdPlayerCustomization[3], 1);
	TextDrawLetterSize(g_tdPlayerCustomization[3], 0.204163, 8.600003);
	TextDrawTextSize(g_tdPlayerCustomization[3], 298.500000, 47.500000);
	TextDrawSetOutline(g_tdPlayerCustomization[3], 1);
	TextDrawSetShadow(g_tdPlayerCustomization[3], 0);
	TextDrawAlignment(g_tdPlayerCustomization[3], 2);
	TextDrawColor(g_tdPlayerCustomization[3], -1094795521);
	TextDrawBackgroundColor(g_tdPlayerCustomization[3], 255);
	TextDrawBoxColor(g_tdPlayerCustomization[3], -1094795686);
	TextDrawUseBox(g_tdPlayerCustomization[3], 1);
	TextDrawSetProportional(g_tdPlayerCustomization[3], 1);
	TextDrawSetSelectable(g_tdPlayerCustomization[3], 0);

	g_tdPlayerCustomization[4] = TextDrawCreate(215.500000, 332.000000, "Preview_Model");
	TextDrawFont(g_tdPlayerCustomization[4], 5);
	TextDrawLetterSize(g_tdPlayerCustomization[4], 0.600000, 2.000000);
	TextDrawTextSize(g_tdPlayerCustomization[4], 85.500000, 85.000000);
	TextDrawSetOutline(g_tdPlayerCustomization[4], 0);
	TextDrawSetShadow(g_tdPlayerCustomization[4], 0);
	TextDrawAlignment(g_tdPlayerCustomization[4], 1);
	TextDrawColor(g_tdPlayerCustomization[4], -1);
	TextDrawBackgroundColor(g_tdPlayerCustomization[4], 0);
	TextDrawBoxColor(g_tdPlayerCustomization[4], 255);
	TextDrawUseBox(g_tdPlayerCustomization[4], 0);
	TextDrawSetProportional(g_tdPlayerCustomization[4], 1);
	TextDrawSetSelectable(g_tdPlayerCustomization[4], 0);
	TextDrawSetPreviewModel(g_tdPlayerCustomization[4], 59);
	TextDrawSetPreviewRot(g_tdPlayerCustomization[4], -10.000000, 0.000000, 18.000000, 0.949998);
	TextDrawSetPreviewVehCol(g_tdPlayerCustomization[4], 1, 1);

	g_tdPlayerCustomization[5] = TextDrawCreate(361.000000, 333.500000, "_");
	TextDrawFont(g_tdPlayerCustomization[5], 1);
	TextDrawLetterSize(g_tdPlayerCustomization[5], 0.204163, 8.600003);
	TextDrawTextSize(g_tdPlayerCustomization[5], 298.500000, 47.500000);
	TextDrawSetOutline(g_tdPlayerCustomization[5], 1);
	TextDrawSetShadow(g_tdPlayerCustomization[5], 0);
	TextDrawAlignment(g_tdPlayerCustomization[5], 2);
	TextDrawColor(g_tdPlayerCustomization[5], -1094795521);
	TextDrawBackgroundColor(g_tdPlayerCustomization[5], 255);
	TextDrawBoxColor(g_tdPlayerCustomization[5], -1094795686);
	TextDrawUseBox(g_tdPlayerCustomization[5], 1);
	TextDrawSetProportional(g_tdPlayerCustomization[5], 1);
	TextDrawSetSelectable(g_tdPlayerCustomization[5], 0);

	g_tdPlayerCustomization[6] = TextDrawCreate(233.500000, 396.500000, "ld_bum:blkdot");
	TextDrawFont(g_tdPlayerCustomization[6], 4);
	TextDrawLetterSize(g_tdPlayerCustomization[6], 0.600000, 2.000000);
	TextDrawTextSize(g_tdPlayerCustomization[6], 51.000000, 19.000000);
	TextDrawSetOutline(g_tdPlayerCustomization[6], 1);
	TextDrawSetShadow(g_tdPlayerCustomization[6], 0);
	TextDrawAlignment(g_tdPlayerCustomization[6], 1);
	TextDrawColor(g_tdPlayerCustomization[6], -1094795521);
	TextDrawBackgroundColor(g_tdPlayerCustomization[6], 255);
	TextDrawBoxColor(g_tdPlayerCustomization[6], 50);
	TextDrawUseBox(g_tdPlayerCustomization[6], 1);
	TextDrawSetProportional(g_tdPlayerCustomization[6], 1);
	TextDrawSetSelectable(g_tdPlayerCustomization[6], 0);

	g_tdPlayerCustomization[7] = TextDrawCreate(309.500000, 399.000000, "_");
	TextDrawFont(g_tdPlayerCustomization[7], 1);
	TextDrawLetterSize(g_tdPlayerCustomization[7], 0.174998, 1.550004);
	TextDrawTextSize(g_tdPlayerCustomization[7], 298.500000, 37.500000);
	TextDrawSetOutline(g_tdPlayerCustomization[7], 1);
	TextDrawSetShadow(g_tdPlayerCustomization[7], 0);
	TextDrawAlignment(g_tdPlayerCustomization[7], 2);
	TextDrawColor(g_tdPlayerCustomization[7], -1094795521);
	TextDrawBackgroundColor(g_tdPlayerCustomization[7], 255);
	TextDrawBoxColor(g_tdPlayerCustomization[7], -1094795686);
	TextDrawUseBox(g_tdPlayerCustomization[7], 1);
	TextDrawSetProportional(g_tdPlayerCustomization[7], 1);
	TextDrawSetSelectable(g_tdPlayerCustomization[7], 0);

	g_tdPlayerCustomization[8] = TextDrawCreate(309.500000, 386.000000, "Edad");
	TextDrawFont(g_tdPlayerCustomization[8], 2);
	TextDrawLetterSize(g_tdPlayerCustomization[8], 0.179166, 1.000000);
	TextDrawTextSize(g_tdPlayerCustomization[8], 400.000000, 36.500000);
	TextDrawSetOutline(g_tdPlayerCustomization[8], 0);
	TextDrawSetShadow(g_tdPlayerCustomization[8], 1);
	TextDrawAlignment(g_tdPlayerCustomization[8], 2);
	TextDrawColor(g_tdPlayerCustomization[8], -1094795521);
	TextDrawBackgroundColor(g_tdPlayerCustomization[8], 125);
	TextDrawBoxColor(g_tdPlayerCustomization[8], 50);
	TextDrawUseBox(g_tdPlayerCustomization[8], 0);
	TextDrawSetProportional(g_tdPlayerCustomization[8], 1);
	TextDrawSetSelectable(g_tdPlayerCustomization[8], 0);

	g_tdPlayerCustomization[9] = TextDrawCreate(316.500000, 332.000000, "Preview_Model");
	TextDrawFont(g_tdPlayerCustomization[9], 5);
	TextDrawLetterSize(g_tdPlayerCustomization[9], 0.600000, 2.000000);
	TextDrawTextSize(g_tdPlayerCustomization[9], 85.500000, 85.000000);
	TextDrawSetOutline(g_tdPlayerCustomization[9], 0);
	TextDrawSetShadow(g_tdPlayerCustomization[9], 0);
	TextDrawAlignment(g_tdPlayerCustomization[9], 1);
	TextDrawColor(g_tdPlayerCustomization[9], -1);
	TextDrawBackgroundColor(g_tdPlayerCustomization[9], 0);
	TextDrawBoxColor(g_tdPlayerCustomization[9], 255);
	TextDrawUseBox(g_tdPlayerCustomization[9], 0);
	TextDrawSetProportional(g_tdPlayerCustomization[9], 1);
	TextDrawSetSelectable(g_tdPlayerCustomization[9], 0);
	TextDrawSetPreviewModel(g_tdPlayerCustomization[9], 91);
	TextDrawSetPreviewRot(g_tdPlayerCustomization[9], -10.000000, 0.000000, -14.000000, 0.949998);
	TextDrawSetPreviewVehCol(g_tdPlayerCustomization[9], 1, 1);

	g_tdPlayerCustomization[10] = TextDrawCreate(335.500000, 396.500000, "ld_bum:blkdot");
	TextDrawFont(g_tdPlayerCustomization[10], 4);
	TextDrawLetterSize(g_tdPlayerCustomization[10], 0.600000, 2.000000);
	TextDrawTextSize(g_tdPlayerCustomization[10], 51.000000, 19.000000);
	TextDrawSetOutline(g_tdPlayerCustomization[10], 1);
	TextDrawSetShadow(g_tdPlayerCustomization[10], 0);
	TextDrawAlignment(g_tdPlayerCustomization[10], 1);
	TextDrawColor(g_tdPlayerCustomization[10], -1094795521);
	TextDrawBackgroundColor(g_tdPlayerCustomization[10], 255);
	TextDrawBoxColor(g_tdPlayerCustomization[10], 50);
	TextDrawUseBox(g_tdPlayerCustomization[10], 1);
	TextDrawSetProportional(g_tdPlayerCustomization[10], 1);
	TextDrawSetSelectable(g_tdPlayerCustomization[10], 0);

	g_tdPlayerCustomization[11] = TextDrawCreate(259.000000, 401.000000, "HOMBRE");
	TextDrawFont(g_tdPlayerCustomization[11], 3);
	TextDrawLetterSize(g_tdPlayerCustomization[11], 0.258332, 1.100000);
	TextDrawTextSize(g_tdPlayerCustomization[11], 11.000000, 45.000000);
	TextDrawSetOutline(g_tdPlayerCustomization[11], 0);
	TextDrawSetShadow(g_tdPlayerCustomization[11], 1);
	TextDrawAlignment(g_tdPlayerCustomization[11], 2);
	TextDrawColor(g_tdPlayerCustomization[11], 205);
	TextDrawBackgroundColor(g_tdPlayerCustomization[11], 0);
	TextDrawBoxColor(g_tdPlayerCustomization[11], 50);
	TextDrawUseBox(g_tdPlayerCustomization[11], 0);
	TextDrawSetProportional(g_tdPlayerCustomization[11], 1);
	TextDrawSetSelectable(g_tdPlayerCustomization[11], 1);

	g_tdPlayerCustomization[12] = TextDrawCreate(361.000000, 401.000000, "Mujer");
	TextDrawFont(g_tdPlayerCustomization[12], 3);
	TextDrawLetterSize(g_tdPlayerCustomization[12], 0.258332, 1.100000);
	TextDrawTextSize(g_tdPlayerCustomization[12], 11.000000, 45.000000);
	TextDrawSetOutline(g_tdPlayerCustomization[12], 0);
	TextDrawSetShadow(g_tdPlayerCustomization[12], 1);
	TextDrawAlignment(g_tdPlayerCustomization[12], 2);
	TextDrawColor(g_tdPlayerCustomization[12], 205);
	TextDrawBackgroundColor(g_tdPlayerCustomization[12], 0);
	TextDrawBoxColor(g_tdPlayerCustomization[12], 50);
	TextDrawUseBox(g_tdPlayerCustomization[12], 1);
	TextDrawSetProportional(g_tdPlayerCustomization[12], 1);
	TextDrawSetSelectable(g_tdPlayerCustomization[12], 1);

	g_tdPlayerCustomization[13] = TextDrawCreate(310.000000, 316.000000, "CONFIGURA TU PERSONAJE");
	TextDrawFont(g_tdPlayerCustomization[13], 3);
	TextDrawLetterSize(g_tdPlayerCustomization[13], 0.254166, 1.149999);
	TextDrawTextSize(g_tdPlayerCustomization[13], 400.000000, 147.000000);
	TextDrawSetOutline(g_tdPlayerCustomization[13], 0);
	TextDrawSetShadow(g_tdPlayerCustomization[13], 1);
	TextDrawAlignment(g_tdPlayerCustomization[13], 2);
	TextDrawColor(g_tdPlayerCustomization[13], -1094795521);
	TextDrawBackgroundColor(g_tdPlayerCustomization[13], 97);
	TextDrawBoxColor(g_tdPlayerCustomization[13], -16777166);
	TextDrawUseBox(g_tdPlayerCustomization[13], 0);
	TextDrawSetProportional(g_tdPlayerCustomization[13], 1);
	TextDrawSetSelectable(g_tdPlayerCustomization[13], 0);

	g_tdPlayerCustomization[14] = TextDrawCreate(372.000000, 312.000000, "ld_beat:chit");
	TextDrawFont(g_tdPlayerCustomization[14], 4);
	TextDrawLetterSize(g_tdPlayerCustomization[14], 0.600000, 2.000000);
	TextDrawTextSize(g_tdPlayerCustomization[14], 16.500000, 19.000000);
	TextDrawSetOutline(g_tdPlayerCustomization[14], 1);
	TextDrawSetShadow(g_tdPlayerCustomization[14], 0);
	TextDrawAlignment(g_tdPlayerCustomization[14], 1);
	TextDrawColor(g_tdPlayerCustomization[14], -1094795521);
	TextDrawBackgroundColor(g_tdPlayerCustomization[14], 255);
	TextDrawBoxColor(g_tdPlayerCustomization[14], 50);
	TextDrawUseBox(g_tdPlayerCustomization[14], 1);
	TextDrawSetProportional(g_tdPlayerCustomization[14], 1);
	TextDrawSetSelectable(g_tdPlayerCustomization[14], 0);

	g_tdPlayerCustomization[15] = TextDrawCreate(377.799987, 313.500000, "!");
	TextDrawFont(g_tdPlayerCustomization[15], 2);
	TextDrawLetterSize(g_tdPlayerCustomization[15], 0.491665, 1.600000);
	TextDrawTextSize(g_tdPlayerCustomization[15], 400.000000, 17.000000);
	TextDrawSetOutline(g_tdPlayerCustomization[15], 0);
	TextDrawSetShadow(g_tdPlayerCustomization[15], 0);
	TextDrawAlignment(g_tdPlayerCustomization[15], 1);
	TextDrawColor(g_tdPlayerCustomization[15], 195);
	TextDrawBackgroundColor(g_tdPlayerCustomization[15], 255);
	TextDrawBoxColor(g_tdPlayerCustomization[15], 50);
	TextDrawUseBox(g_tdPlayerCustomization[15], 0);
	TextDrawSetProportional(g_tdPlayerCustomization[15], 1);
	TextDrawSetSelectable(g_tdPlayerCustomization[15], 0);

	g_tdPlayerCustomization[16] = TextDrawCreate(634.000000, 432.000000, "~w~presiona ~y~ESCAPE ~w~para terminar");
	TextDrawFont(g_tdPlayerCustomization[16], 3);
	TextDrawLetterSize(g_tdPlayerCustomization[16], 0.254166, 1.099999);
	TextDrawTextSize(g_tdPlayerCustomization[16], 400.000000, 147.000000);
	TextDrawSetOutline(g_tdPlayerCustomization[16], 0);
	TextDrawSetShadow(g_tdPlayerCustomization[16], 1);
	TextDrawAlignment(g_tdPlayerCustomization[16], 3);
	TextDrawColor(g_tdPlayerCustomization[16], -1094795521);
	TextDrawBackgroundColor(g_tdPlayerCustomization[16], 97);
	TextDrawBoxColor(g_tdPlayerCustomization[16], -16777166);
	TextDrawUseBox(g_tdPlayerCustomization[16], 0);
	TextDrawSetProportional(g_tdPlayerCustomization[16], 1);
	TextDrawSetSelectable(g_tdPlayerCustomization[16], 0);

	g_tdPlayerCustomization[17] = TextDrawCreate(375.000000, 315.000000, "~y~_________tu_skin_cambiara_dependiendo~n~_________de_la_edad_de_tu_personaje.");
	TextDrawFont(g_tdPlayerCustomization[17], 2);
	TextDrawLetterSize(g_tdPlayerCustomization[17], 0.150000, 0.899999);
	TextDrawTextSize(g_tdPlayerCustomization[17], 386.500000, 11.000000);
	TextDrawSetOutline(g_tdPlayerCustomization[17], 0);
	TextDrawSetShadow(g_tdPlayerCustomization[17], 0);
	TextDrawAlignment(g_tdPlayerCustomization[17], 1);
	TextDrawColor(g_tdPlayerCustomization[17], -256);
	TextDrawBackgroundColor(g_tdPlayerCustomization[17], 255);
	TextDrawBoxColor(g_tdPlayerCustomization[17], -16777166);
	TextDrawUseBox(g_tdPlayerCustomization[17], 0);
	TextDrawSetProportional(g_tdPlayerCustomization[17], 1);
	TextDrawSetSelectable(g_tdPlayerCustomization[17], 1);

	g_tdPlayerCustomization[18] = TextDrawCreate(224.000000, 275.000000, "_");
	TextDrawFont(g_tdPlayerCustomization[18], 1);
	TextDrawLetterSize(g_tdPlayerCustomization[18], 0.600000, 3.850000);
	TextDrawTextSize(g_tdPlayerCustomization[18], 400.000000, 42.000000);
	TextDrawSetOutline(g_tdPlayerCustomization[18], 1);
	TextDrawSetShadow(g_tdPlayerCustomization[18], 0);
	TextDrawAlignment(g_tdPlayerCustomization[18], 2);
	TextDrawColor(g_tdPlayerCustomization[18], -1);
	TextDrawBackgroundColor(g_tdPlayerCustomization[18], 255);
	TextDrawBoxColor(g_tdPlayerCustomization[18], 50);
	TextDrawUseBox(g_tdPlayerCustomization[18], 0);
	TextDrawSetProportional(g_tdPlayerCustomization[18], 1);
	TextDrawSetSelectable(g_tdPlayerCustomization[18], 1);

	g_tdPlayerCustomization[19] = TextDrawCreate(398.000000, 274.000000, "_");
	TextDrawFont(g_tdPlayerCustomization[19], 1);
	TextDrawLetterSize(g_tdPlayerCustomization[19], 0.600000, 3.850000);
	TextDrawTextSize(g_tdPlayerCustomization[19], 400.000000, 42.000000);
	TextDrawSetOutline(g_tdPlayerCustomization[19], 1);
	TextDrawSetShadow(g_tdPlayerCustomization[19], 0);
	TextDrawAlignment(g_tdPlayerCustomization[19], 2);
	TextDrawColor(g_tdPlayerCustomization[19], -1);
	TextDrawBackgroundColor(g_tdPlayerCustomization[19], 255);
	TextDrawBoxColor(g_tdPlayerCustomization[19], 50);
	TextDrawUseBox(g_tdPlayerCustomization[19], 0);
	TextDrawSetProportional(g_tdPlayerCustomization[19], 1);
	TextDrawSetSelectable(g_tdPlayerCustomization[19], 1);

	return 1;
}

hook OnGameModeExit()
{
	for (new i = _:MAX_TEXT_DRAWS - 1; i != -1; i -= 1)
	{
		TextDrawDestroy(Text:i);
	}

	return 1;
}

hook OnPlayerConnect(playerid)
{
	if(IsPlayerNPC(playerid))
		return ~1;

	p_tdRegisterAcc[playerid]{0} = CreatePlayerTextDraw(playerid, 25.000000, 112.000000, !"Motumbo_Abimbola");
	PlayerTextDrawFont(playerid, p_tdRegisterAcc[playerid]{0}, 1);
	PlayerTextDrawLetterSize(playerid, p_tdRegisterAcc[playerid]{0}, 0.212500, 1.050001);
	PlayerTextDrawTextSize(playerid, p_tdRegisterAcc[playerid]{0}, 266.000000, 11.000000);
	PlayerTextDrawSetOutline(playerid, p_tdRegisterAcc[playerid]{0}, 0);
	PlayerTextDrawSetShadow(playerid, p_tdRegisterAcc[playerid]{0}, 0);
	PlayerTextDrawAlignment(playerid, p_tdRegisterAcc[playerid]{0}, 1);
	PlayerTextDrawColor(playerid, p_tdRegisterAcc[playerid]{0}, 135);
	PlayerTextDrawBackgroundColor(playerid, p_tdRegisterAcc[playerid]{0}, 336860200);
	PlayerTextDrawBoxColor(playerid, p_tdRegisterAcc[playerid]{0}, -16777166);
	PlayerTextDrawUseBox(playerid, p_tdRegisterAcc[playerid]{0}, 0);
	PlayerTextDrawSetProportional(playerid, p_tdRegisterAcc[playerid]{0}, 1);
	PlayerTextDrawSetSelectable(playerid, p_tdRegisterAcc[playerid]{0}, 1);

	p_tdRegisterAcc[playerid]{1} = CreatePlayerTextDraw(playerid, 25.000000, 162.000000, Str_FixEncoding("Tu contraseña"));
	PlayerTextDrawFont(playerid, p_tdRegisterAcc[playerid]{1}, 1);
	PlayerTextDrawLetterSize(playerid, p_tdRegisterAcc[playerid]{1}, 0.212500, 1.050001);
	PlayerTextDrawTextSize(playerid, p_tdRegisterAcc[playerid]{1}, 265.500000, 11.000000);
	PlayerTextDrawSetOutline(playerid, p_tdRegisterAcc[playerid]{1}, 0);
	PlayerTextDrawSetShadow(playerid, p_tdRegisterAcc[playerid]{1}, 0);
	PlayerTextDrawAlignment(playerid, p_tdRegisterAcc[playerid]{1}, 1);
	PlayerTextDrawColor(playerid, p_tdRegisterAcc[playerid]{1}, 135);
	PlayerTextDrawBackgroundColor(playerid, p_tdRegisterAcc[playerid]{1}, 336860200);
	PlayerTextDrawBoxColor(playerid, p_tdRegisterAcc[playerid]{1}, -16777166);
	PlayerTextDrawUseBox(playerid, p_tdRegisterAcc[playerid]{1}, 0);
	PlayerTextDrawSetProportional(playerid, p_tdRegisterAcc[playerid]{1}, 1);
	PlayerTextDrawSetSelectable(playerid, p_tdRegisterAcc[playerid]{1}, 1);

	p_tdRegisterAcc[playerid]{2} = CreatePlayerTextDraw(playerid, 269.500000, 178.000000, Str_FixEncoding("Mostrar contraseña"));
	PlayerTextDrawFont(playerid, p_tdRegisterAcc[playerid]{2}, 3);
	PlayerTextDrawLetterSize(playerid, p_tdRegisterAcc[playerid]{2}, 0.208333, 0.950002);
	PlayerTextDrawTextSize(playerid, p_tdRegisterAcc[playerid]{2}, 349.000000, 9.500000);
	PlayerTextDrawSetOutline(playerid, p_tdRegisterAcc[playerid]{2}, 2);
	PlayerTextDrawSetShadow(playerid, p_tdRegisterAcc[playerid]{2}, 0);
	PlayerTextDrawAlignment(playerid, p_tdRegisterAcc[playerid]{2}, 3);
	PlayerTextDrawColor(playerid, p_tdRegisterAcc[playerid]{2}, -1094795521);
	PlayerTextDrawBackgroundColor(playerid, p_tdRegisterAcc[playerid]{2}, 336860160);
	PlayerTextDrawBoxColor(playerid, p_tdRegisterAcc[playerid]{2}, -16777166);
	PlayerTextDrawUseBox(playerid, p_tdRegisterAcc[playerid]{2}, 0);
	PlayerTextDrawSetProportional(playerid, p_tdRegisterAcc[playerid]{2}, 1);
	PlayerTextDrawSetSelectable(playerid, p_tdRegisterAcc[playerid]{2}, 1);

	p_tdRegisterAcc[playerid]{3} = CreatePlayerTextDraw(playerid, 26.000000, 215.000000, !"(OPCIONAL)");
	PlayerTextDrawFont(playerid, p_tdRegisterAcc[playerid]{3}, 1);
	PlayerTextDrawLetterSize(playerid, p_tdRegisterAcc[playerid]{3}, 0.212500, 1.050001);
	PlayerTextDrawTextSize(playerid, p_tdRegisterAcc[playerid]{3}, 163.000000, 11.000000);
	PlayerTextDrawSetOutline(playerid, p_tdRegisterAcc[playerid]{3}, 0);
	PlayerTextDrawSetShadow(playerid, p_tdRegisterAcc[playerid]{3}, 0);
	PlayerTextDrawAlignment(playerid, p_tdRegisterAcc[playerid]{3}, 1);
	PlayerTextDrawColor(playerid, p_tdRegisterAcc[playerid]{3}, 135);
	PlayerTextDrawBackgroundColor(playerid, p_tdRegisterAcc[playerid]{3}, 336860200);
	PlayerTextDrawBoxColor(playerid, p_tdRegisterAcc[playerid]{3}, -16777166);
	PlayerTextDrawUseBox(playerid, p_tdRegisterAcc[playerid]{3}, 0);
	PlayerTextDrawSetProportional(playerid, p_tdRegisterAcc[playerid]{3}, 1);
	PlayerTextDrawSetSelectable(playerid, p_tdRegisterAcc[playerid]{3}, 1);

	p_tdRegisterAcc[playerid]{4} = CreatePlayerTextDraw(playerid, 25.000000, 265.000000, !"(OPCIONAL)");
	PlayerTextDrawFont(playerid, p_tdRegisterAcc[playerid]{4}, 1);
	PlayerTextDrawLetterSize(playerid, p_tdRegisterAcc[playerid]{4}, 0.212500, 1.050001);
	PlayerTextDrawTextSize(playerid, p_tdRegisterAcc[playerid]{4}, 265.500000, 11.000000);
	PlayerTextDrawSetOutline(playerid, p_tdRegisterAcc[playerid]{4}, 0);
	PlayerTextDrawSetShadow(playerid, p_tdRegisterAcc[playerid]{4}, 0);
	PlayerTextDrawAlignment(playerid, p_tdRegisterAcc[playerid]{4}, 1);
	PlayerTextDrawColor(playerid, p_tdRegisterAcc[playerid]{4}, 135);
	PlayerTextDrawBackgroundColor(playerid, p_tdRegisterAcc[playerid]{4}, 336860200);
	PlayerTextDrawBoxColor(playerid, p_tdRegisterAcc[playerid]{4}, -16777166);
	PlayerTextDrawUseBox(playerid, p_tdRegisterAcc[playerid]{4}, 0);
	PlayerTextDrawSetProportional(playerid, p_tdRegisterAcc[playerid]{4}, 1);
	PlayerTextDrawSetSelectable(playerid, p_tdRegisterAcc[playerid]{4}, 1);
	
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

	p_tdSkinSelector{playerid} = CreatePlayerTextDraw(playerid, 324.000000, 31.000000, !"mujer");
	PlayerTextDrawFont(playerid, p_tdSkinSelector{playerid}, 2);
	PlayerTextDrawLetterSize(playerid, p_tdSkinSelector{playerid}, 0.404166, 1.450000);
	PlayerTextDrawTextSize(playerid, p_tdSkinSelector{playerid}, 430.000000, -173.000000);
	PlayerTextDrawSetOutline(playerid, p_tdSkinSelector{playerid}, 0);
	PlayerTextDrawSetShadow(playerid, p_tdSkinSelector{playerid}, 1);
	PlayerTextDrawAlignment(playerid, p_tdSkinSelector{playerid}, 2);
	PlayerTextDrawColor(playerid, p_tdSkinSelector{playerid}, -6957313);
	PlayerTextDrawBackgroundColor(playerid, p_tdSkinSelector{playerid}, 255);
	PlayerTextDrawBoxColor(playerid, p_tdSkinSelector{playerid}, 119);
	PlayerTextDrawUseBox(playerid,p_tdSkinSelector{playerid}, 0);
	PlayerTextDrawSetProportional(playerid, p_tdSkinSelector{playerid}, 1);
	PlayerTextDrawSetSelectable(playerid, p_tdSkinSelector{playerid}, 0);

	p_tdPlayerCustomization{playerid} = CreatePlayerTextDraw(playerid, 309.000000, 400.000000, "18");
	PlayerTextDrawFont(playerid, p_tdPlayerCustomization{playerid}, 2);
	PlayerTextDrawLetterSize(playerid, p_tdPlayerCustomization{playerid}, 0.179166, 1.100000);
	PlayerTextDrawTextSize(playerid, p_tdPlayerCustomization{playerid}, 11.000000, 36.500000);
	PlayerTextDrawSetOutline(playerid, p_tdPlayerCustomization{playerid}, 0);
	PlayerTextDrawSetShadow(playerid, p_tdPlayerCustomization{playerid}, 1);
	PlayerTextDrawAlignment(playerid, p_tdPlayerCustomization{playerid}, 2);
	PlayerTextDrawColor(playerid, p_tdPlayerCustomization{playerid}, -1094795521);
	PlayerTextDrawBackgroundColor(playerid, p_tdPlayerCustomization{playerid}, 125);
	PlayerTextDrawBoxColor(playerid, p_tdPlayerCustomization{playerid}, 50);
	PlayerTextDrawUseBox(playerid, p_tdPlayerCustomization{playerid}, 0);
	PlayerTextDrawSetProportional(playerid, p_tdPlayerCustomization{playerid}, 1);
	PlayerTextDrawSetSelectable(playerid, p_tdPlayerCustomization{playerid}, 1);

	return 1;
}