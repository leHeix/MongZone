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
	'�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�',
	'�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�',
	'�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�',
	'�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�',
	'�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�',
	'�', '�', '�', '�', '�'
};