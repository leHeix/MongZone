#if defined _H_CONFIG_
	#endinput
#endif
#define _H_CONFIG_

enum _:eServerData {
	e_iPlayerRecord
};

new g_rgeServerData[eServerData];

new const g_rgcAllowedNameChars[] = {
	'�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�',
	'�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�',
	'�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�',
	'�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�',
	'�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�',
	'�', '�', '�', '�', '�'
};