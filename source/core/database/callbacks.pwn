#if defined _CALLBACKS_DATABASE_
	#endinput
#endif
#define _CALLBACKS_DATABASE_

#include <YSI_Coding\y_hooks>

hook OnScriptInit()
{
	g_sqlDatabase = mysql_connect_file("MongZoneSQL.ini");
	if(mysql_errno(g_sqlDatabase) != 0)
	{
		new err[128];
		mysql_error(err);
		print(!"[!] No se pudo conectar a la base de datos principal.");
		print(!"[!] Detalles del incidente:");
		printf("[!]    %s", err);
		SendRconCommand(!"exit");
		return ~0;
	}
	
	mysql_log(ALL & ~DEBUG);
	
	print("~ Base de datos conectada.");
	print("~ Ejecutando primeras operaciones...");

	mysql_query_file(g_sqlDatabase, "db_struct.sql");

	print("~ Inicialización de la base de datos completada.");

	return 1;
}

hook OnScriptExit()
{
	mysql_close(g_sqlDatabase);
	return 1; 
}