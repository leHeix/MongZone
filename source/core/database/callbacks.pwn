#if defined _DATABASE_CALLBACKS_
	#endinput
#endif
#define _DATABASE_CALLBACKS_

#include <YSI_Coding\y_hooks>

hook OnScriptInit()
{
	g_hDatabase = mysql_connect_file(!"MongZoneSQL.ini");
	if(mysql_errno(g_hDatabase) != 0)
	{
		mysql_error(YSI_UNSAFE_HUGE_STRING, YSI_UNSAFE_HUGE_LENGTH);
		print("[!] No se pudo conectar a la base de datos.");
		print("[!] Informaci�n sobre la excepci�n:");
		printf("[!]     %s", YSI_UNSAFE_HUGE_STRING);
		SendRconCommand("exit");

		return ~1;
	}

	print("~ Base de datos principal conectada.");
	print("~ Ejecutando primeras operaciones...");
	
	mysql_query_file(g_hDatabase, !"db_struct.sql");

	print("~ Inicializaci�n de la base de datos completada con �xito.");

	return 1;
}

hook OnScriptExit()
{
	mysql_close(g_hDatabase);
	return 1;
}