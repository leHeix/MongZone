#if defined _UTILS_FUNCTIONS_
	#endinput
#endif
#define _UTILS_FUNCTIONS_

Str_Random(len = 10)
{
	new str_result[32];
	assert len < sizeof(str_result);

	while(--len != -1)
	{
		str_result[len] = random(2) ? (random(26) + (random(2) ? 'a' : 'A')) : (random(10) + '0');
	}

	return str_result;
}

stock Str_PackedRandom(len = 10)
{
	new str_result[32 char];

	while(--len != -1)
	{
		str_result{len} = random(2) ? (random(26) + (random(2) ? 'a' : 'A')) : (random(10) + '0');
	}

	return str_result;
}

Str_FixEncoding(const base[])
{
	new result[256];

	strcat(result, base);

	for (new i = (strlen(base) - 1); i != -1; --i)
	{
		switch (result[i])
		{
			case '�': result[i] = 151;
			case '�': result[i] = 152;
			case '�': result[i] = 153;
			case '�': result[i] = 154;
			case '�': result[i] = 128;
			case '�': result[i] = 129;
			case '�': result[i] = 130;
			case '�': result[i] = 131;
			case '�': result[i] = 157;
			case '�': result[i] = 158;
			case '�': result[i] = 159;
			case '�': result[i] = 160;
			case '�': result[i] = 134;
			case '�': result[i] = 135;
			case '�': result[i] = 136;
			case '�': result[i] = 137;
			case '�': result[i] = 161;
			case '�': result[i] = 162;
			case '�': result[i] = 163;
			case '�': result[i] = 164;
			case '�': result[i] = 138;
			case '�': result[i] = 139;
			case '�': result[i] = 140;
			case '�': result[i] = 141;
			case '�': result[i] = 165;
			case '�': result[i] = 166;
			case '�': result[i] = 167;
			case '�': result[i] = 168;
			case '�': result[i] = 142;
			case '�': result[i] = 143;
			case '�': result[i] = 144;
			case '�': result[i] = 145;
			case '�': result[i] = 169;
			case '�': result[i] = 170;
			case '�': result[i] = 171;
			case '�': result[i] = 172;
			case '�': result[i] = 146;
			case '�': result[i] = 147;
			case '�': result[i] = 148;
			case '�': result[i] = 149;
			case '�': result[i] = 174;
			case '�': result[i] = 173;
			case '�': result[i] = 64;
			case '�': result[i] = 175;
			case '`': result[i] = 177;
			case '&': result[i] = 38;
		}
	}
	return result;
}

String:Str_FixEncoding_s(ConstStringTag:orig)
{
	new String:str = str_clone(orig);

	new c, i = -1;
	while((c = str_getc(str, ++i)) != INVALID_CHAR)
	{
		switch (c)
		{
			case '�': str_setc(str, i, 151);
			case '�': str_setc(str, i, 152);
			case '�': str_setc(str, i, 153);
			case '�': str_setc(str, i, 154);
			case '�': str_setc(str, i, 128);
			case '�': str_setc(str, i, 129);
			case '�': str_setc(str, i, 130);
			case '�': str_setc(str, i, 131);
			case '�': str_setc(str, i, 157);
			case '�': str_setc(str, i, 158);
			case '�': str_setc(str, i, 159);
			case '�': str_setc(str, i, 160);
			case '�': str_setc(str, i, 134);
			case '�': str_setc(str, i, 135);
			case '�': str_setc(str, i, 136);
			case '�': str_setc(str, i, 137);
			case '�': str_setc(str, i, 161);
			case '�': str_setc(str, i, 162);
			case '�': str_setc(str, i, 163);
			case '�': str_setc(str, i, 164);
			case '�': str_setc(str, i, 138);
			case '�': str_setc(str, i, 139);
			case '�': str_setc(str, i, 140);
			case '�': str_setc(str, i, 141);
			case '�': str_setc(str, i, 165);
			case '�': str_setc(str, i, 166);
			case '�': str_setc(str, i, 167);
			case '�': str_setc(str, i, 168);
			case '�': str_setc(str, i, 142);
			case '�': str_setc(str, i, 143);
			case '�': str_setc(str, i, 144);
			case '�': str_setc(str, i, 145);
			case '�': str_setc(str, i, 169);
			case '�': str_setc(str, i, 170);
			case '�': str_setc(str, i, 171);
			case '�': str_setc(str, i, 172);
			case '�': str_setc(str, i, 146);
			case '�': str_setc(str, i, 147);
			case '�': str_setc(str, i, 148);
			case '�': str_setc(str, i, 149);
			case '�': str_setc(str, i, 174);
			case '�': str_setc(str, i, 173);
			case '�': str_setc(str, i, 64);
			case '�': str_setc(str, i, 175);
			case '`': str_setc(str, i, 177);
			case '&': str_setc(str, i, 38);
		}
	}

	return str;
}

TextDraw_DelayedSelect(playerid, hovercolor)
{
	inline const Due()
	{
		SelectTextDraw(playerid, hovercolor);
	}
	PlayerTimer_Start(playerid, 200, false, using inline Due);
	return 1;
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

// this is a mess
SplitTextInLines(string[], results[][], split_max = 2, split_at = 145)
{
	++split_max;

	new string_len = strlen(string) - 1;

	if(string_len < split_at)
	{
		return strcpy(results[0], string, split_at);
	}

	new j, lastwrap;

	for(new i, wraploc; i < string_len && j < split_max; ++i, ++wraploc)
	{
		if(wraploc >= split_at)
		{
			for(new k = i; k > 0; --k)
			{
				if(k - lastwrap <= split_at && string[k] == ' ')
				{
					strmid(results[j++], string, lastwrap, k + 1, (j ? split_at - 2 : split_at));
					if(j)
						strins(results[j], "� ", 0, split_at);

					lastwrap = k + 1;
					break;
				}
			}
			wraploc = i - lastwrap;
		}
	}

	if(!(lastwrap >= string_len) && j < split_max)
		format(results[j++], split_at, "� %s", string[lastwrap]); // hack-hack

	return j;
}

RawIpToString(rawip)
{
    static ip[16];
    ip[3] = (rawip >> 24) & 0xFF; // hi
    ip[2] = (rawip >> 16) & 0xFF;
    ip[1] = (rawip >>  8) & 0xFF;
    ip[0] = rawip & 0xFF;         // lo

    format(ip, 16, "%d.%d.%d.%d", ip[3], ip[2], ip[1], ip[0]);

    return ip;
}