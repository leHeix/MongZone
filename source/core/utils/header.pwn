#if defined _H_UTILS_
	#endinput
#endif
#define _H_UTILS_

enum {
	VW_GENERAL = (MAX_PLAYERS / 2),
	VW_PLAYER = 1
}

#define @f str_format
native mysql_tquery_s(MySQL:handle, ConstAmxString:query, const callback[] = "", const format[] = "", {Float,_}:...) = mysql_tquery;

forward OnPlayerPressEsc(playerid);