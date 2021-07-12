#if defined _UTILS_FUNCTIONS_
	#endinput
#endif

#define _UTILS_FUNCTIONS_

Str_Random(len = 10)
{
	new str_generated[32];
	assert len < sizeof(str_generated);

	while (--len != -1)
	{
		str_generated[len] = random(2) ? (random(26) + (random(2) ? 'a' : 'A')) : (random(10) + '0');
	}

	return str_generated;
}

TextDraw_DelayedSelect(playerid, hovercolor)
{
	wait_ms(200);
	SelectTextDraw(playerid, hovercolor);
	return 1;
}

stock String:Str_FixEncoding_s(String:base)
{
	for (new i = (str_len(base) - 1); i != -1; --i)
	{
		switch (str_getc(base, i))
		{
			case 'à': str_setc(base, i, 151);
			case 'á': str_setc(base, i, 152);
			case 'â': str_setc(base, i, 153);
			case 'ä': str_setc(base, i, 154);
			case 'À': str_setc(base, i, 128);
			case 'Á': str_setc(base, i, 129);
			case 'Â': str_setc(base, i, 130);
			case 'Ä': str_setc(base, i, 131);
			case 'è': str_setc(base, i, 157);
			case 'é': str_setc(base, i, 158);
			case 'ê': str_setc(base, i, 159);
			case 'ë': str_setc(base, i, 160);
			case 'È': str_setc(base, i, 134);
			case 'É': str_setc(base, i, 135);
			case 'Ê': str_setc(base, i, 136);
			case 'Ë': str_setc(base, i, 137);
			case 'ì': str_setc(base, i, 161);
			case 'í': str_setc(base, i, 162);
			case 'î': str_setc(base, i, 163);
			case 'ï': str_setc(base, i, 164);
			case 'Ì': str_setc(base, i, 138);
			case 'Í': str_setc(base, i, 139);
			case 'Î': str_setc(base, i, 140);
			case 'Ï': str_setc(base, i, 141);
			case 'ò': str_setc(base, i, 165);
			case 'ó': str_setc(base, i, 166);
			case 'ô': str_setc(base, i, 167);
			case 'ö': str_setc(base, i, 168);
			case 'Ò': str_setc(base, i, 142);
			case 'Ó': str_setc(base, i, 143);
			case 'Ô': str_setc(base, i, 144);
			case 'Ö': str_setc(base, i, 145);
			case 'ù': str_setc(base, i, 169);
			case 'ú': str_setc(base, i, 170);
			case 'û': str_setc(base, i, 171);
			case 'ü': str_setc(base, i, 172);
			case 'Ù': str_setc(base, i, 146);
			case 'Ú': str_setc(base, i, 147);
			case 'Û': str_setc(base, i, 148);
			case 'Ü': str_setc(base, i, 149);
			case 'ñ': str_setc(base, i, 174);
			case 'Ñ': str_setc(base, i, 173);
			case '¡': str_setc(base, i, 64);
			case '¿': str_setc(base, i, 175);
			case '`': str_setc(base, i, 177);
			case '&': str_setc(base, i, 38);
			case ']': str_setc(base, i, ')');
			case '[': str_setc(base, i, '(');
		}
	}
	return base;
}

Str_FixEncoding(const base[])
{
	new result[256];

	strcat(result, base);

	for (new i = (strlen(base) - 1); i != -1; --i)
	{
		switch (result[i])
		{
			case 'à': result[i] = 151;
			case 'á': result[i] = 152;
			case 'â': result[i] = 153;
			case 'ä': result[i] = 154;
			case 'À': result[i] = 128;
			case 'Á': result[i] = 129;
			case 'Â': result[i] = 130;
			case 'Ä': result[i] = 131;
			case 'è': result[i] = 157;
			case 'é': result[i] = 158;
			case 'ê': result[i] = 159;
			case 'ë': result[i] = 160;
			case 'È': result[i] = 134;
			case 'É': result[i] = 135;
			case 'Ê': result[i] = 136;
			case 'Ë': result[i] = 137;
			case 'ì': result[i] = 161;
			case 'í': result[i] = 162;
			case 'î': result[i] = 163;
			case 'ï': result[i] = 164;
			case 'Ì': result[i] = 138;
			case 'Í': result[i] = 139;
			case 'Î': result[i] = 140;
			case 'Ï': result[i] = 141;
			case 'ò': result[i] = 165;
			case 'ó': result[i] = 166;
			case 'ô': result[i] = 167;
			case 'ö': result[i] = 168;
			case 'Ò': result[i] = 142;
			case 'Ó': result[i] = 143;
			case 'Ô': result[i] = 144;
			case 'Ö': result[i] = 145;
			case 'ù': result[i] = 169;
			case 'ú': result[i] = 170;
			case 'û': result[i] = 171;
			case 'ü': result[i] = 172;
			case 'Ù': result[i] = 146;
			case 'Ú': result[i] = 147;
			case 'Û': result[i] = 148;
			case 'Ü': result[i] = 149;
			case 'ñ': result[i] = 174;
			case 'Ñ': result[i] = 173;
			case '¡': result[i] = 64;
			case '¿': result[i] = 175;
			case '`': result[i] = 177;
			case '&': result[i] = 38;
		}
	}
	return result;
}

KillFeed_Clear(playerid = INVALID_PLAYER_ID)
{
	if (!IsPlayerConnected(playerid) && playerid != INVALID_PLAYER_ID)
	{
		return 0;
	}

	const invisible_id = INVALID_PLAYER_ID - 1;
	new i = 5;
   
	#emit push.c invisible_id
	#emit push.c invisible_id

	if (playerid == INVALID_PLAYER_ID)
	{
		#emit push.c 12

		while (--i != -1)
		{
			#emit sysreq.c SendDeathMessage
		}

		#emit stack 12
	}
	else
	{
		#emit push.s playerid
		#emit push.c 16

		while (--i != -1)
		{
			#emit sysreq.c SendDeathMessageToPlayer
		}

		#emit stack 16
	}
	return 1;
}

Chat_Clear(playerid = INVALID_PLAYER_ID, lines = 20)
{
	if (playerid != INVALID_PLAYER_ID && !IsPlayerConnected(playerid))
	{
		return 0;
	}

	static const space[] = !" ";

	#emit push.c space
	#emit push.c 0x01

	if (playerid == INVALID_PLAYER_ID)
	{
		#emit push.c 12

		while (lines-- != -1)
		{
			#emit sysreq.c SendClientMessageToAll
		}

		#emit stack 12
	}
	else
	{
		#emit push.s playerid
		#emit push.c 16

		while (lines-- != -1)
		{
			#emit sysreq.c SendClientMessage
		}

		#emit stack 16
	}
	return 1;
}

stock Date_GetAsText()
{
	new date[11], year, month, day;

	getdate(year, month, day);
	format(date, sizeof(date), "%02d/%02d/%d", day, month, year);
	return date;
}

stock any_acquire(AnyTag:value, tag = tagof(value))
{
	if(tag == tagof(_:))
		return 0;
	
	if(tag == tagof(String:))
	{
		str_acquire(value);
	}
	/* too lazy - add more as the script grows */

	return 1;
}