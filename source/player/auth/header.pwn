#if defined _H_AUTH_
	#endinput
#endif
#define _H_AUTH_

enum eIntroductionData
{
	e_iIntroPlayer,
	e_iIntroPilot,
	e_iTaxiDriver
};

new
	g_rgeIntroData[MAX_PLAYERS][eIntroductionData],
	g_rgiSelectedSkin[MAX_PLAYERS char],
	bool:g_rgbPasswordShown[MAX_PLAYERS char];

new const
	g_rgiIntroSkins[] = {
		cellmin,

		/* Edad: 18 - 34 */
		7, 19, 20, 21, 22, 101, 29, 47, 48, // Hombres
		12, 13, 40, 41, 55, 56, 85, 90, 91, // Mujeres

		/* Edad: 35 - 60 */
		14, 15, 32, 34, 37, 43, 44, 59, 96, // Hombres
		31, 69, 76, 130, 131, 141, 148, 150, 157, // Mujeres

		/* Edad: 61 - 100 */
		32, 35, 36, 49, 57, 58, 94, 132, 158, // Hombres
		9, 10, 31, 38, 39, 53, 54, 88, 89 // Mujeres
	};