#if defined _COMMANDS_FUNCTIONS_
	#endinput
#endif
#define _COMMANDS_FUNCTIONS_

Commands_FreeIndex()
{
	for(new i; i < MZ_MAX_COMMANDS; ++i)
		if(!g_rgeCommandData[i][e_iCommandNameHash])
			return i;

	return -1;
}

Commands_GetByName(const command[])
{
	new cmd_hash = YHash(command);

	for(new i; i < MZ_MAX_COMMANDS; ++i)
		if(g_rgeCommandData[i][e_iCommandNameHash])
			if(g_rgeCommandData[i][e_iCommandNameHash] == cmd_hash)
				return i;

	return -1;
}

bool:Commands_GetDescription(const command[], destination[], length = sizeof(destination))
{
	new i = Commands_GetByName(command);
	if(i == -1)
		return false;

	strcpy(destination, g_rgeCommandData[i][e_szCommandDescription], length);

	return false;
}