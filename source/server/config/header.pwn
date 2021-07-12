#if defined _H_CONFIG_
	#endinput
#endif
#define _H_CONFIG_

enum _:EServerData
{
	e_iPlayersRecord
};

new g_rgeServerData[EServerData];

new const g_rgcAllowedNameChars[] = {
	'ï', 'ò', 'ù', 'ú', 'û', 'ü', 'ý', 'þ', 'ÿ', '÷', 'ø', 'ö',
	'Š', 'Œ', 'Ž', 'š', 'ž', 'Ÿ', 'õ', 'À', 'Á', 'Â', 'Ã', 'Ä',
	'Å', 'Æ', 'Ç', 'ñ', 'È', 'É', 'Ê', 'Ë', 'Ì', 'Í', 'Î', 'Ï',
	'Ð', 'Ñ', 'Ò', 'Ó', 'Ô', 'Õ', 'Ö', 'Ø', 'Ù', 'Ú', 'Û', 'Ü',
	'Ý', 'Þ', 'ß', 'à', 'á', 'â', 'ã', 'ä', 'å', 'î', 'ç', 'è',
	'é', 'ê', 'ë', 'ì', 'í'
};