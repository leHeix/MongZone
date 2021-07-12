#if defined _SERVER_CONFIG_FUNCTIONS_
	#endinput
#endif
#define _SERVER_CONFIG_FUNCTIONS_

Config_Save()
{
	new File:fhandle = fopen(!"Config.bin", io_write);

	if (!fhandle)
	{
		printf("[!] No se pudo guardar la configuración del servidor.");
		return 0;
	}

	fblockwrite(fhandle, g_rgeServerData);
	fclose(fhandle);

	return 1;
}

Config_Load()
{
	new File:fhandle = fopen(!"Config.bin", io_read);

	if (!fhandle)
	{
		printf("[!] No se pudo guardar la configuración del servidor.");
		return 0;
	}

	if (flength(fhandle) != (EServerData * 4))
	{
		print("\n[!] El array de configuración guardado no es compatible con el del gamemode.\n");
		fclose(fhandle);

		SendRconCommand("exit");
		return 0;
	}

	fblockread(fhandle, g_rgeServerData);
	fclose(fhandle);

	return 1;
}