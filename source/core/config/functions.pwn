#if defined _CONFIG_FUNCTIONS_
	#endinput
#endif
#define _CONFIG_FUNCTIONS_

Config_Save()
{
	new File:cfile = fopen(!"Config.bin", io_write);
	if(!cfile)
	{
		print("[!] No se pudo guardar la configuración.");
		return 0;
	}

	fblockwrite(cfile, g_rgeServerData);
	fclose(cfile);

	return 1;
}

Config_Load()
{
	new File:cfile = fopen(!"Config.bin", io_read);
	if(!cfile)
	{
		print("[!] No se pudo cargar el archivo de configuración del servidor.");
		return 0;
	}

	if(flength(cfile) != (eServerData * cellbytes))
	{
		print("[!] El archivo de configuración guardado no es compatible.");
		fclose(cfile);
		SendRconCommand(!"exit");
		
		return 0;
	}

	fblockread(cfile, g_rgeServerData);
	fclose(cfile);
	
	return 1;
}