#if defined _CHAT_CALLBACKS_
	#endinput
#endif
#define _CHAT_CALLBACKS_

#include <YSI_Coding\y_hooks>

hook OnPlayerText(playerid, text[])
{
	if(Bit_Get(Player_Flags(playerid), PFLAG_AUTHENTICATING) || !Bit_Get(Player_Flags(playerid), PFLAG_REGISTERED) || Bit_Get(Player_Flags(playerid), PFLAG_INTRODUCTION_RUNNING))
		return 0;

	for(new i = strlen(text) - 1; i != -1; --i)
	{
		if(text[i] == '%')
			text[i] = '#';
	}

	new Regex:message_regex = Regex_New("^\\s*([\\s\\S]+)$", REGEX_ICASE);
	new RegexMatch:match;

	if(!Regex_Match(text, message_regex, match))
	{
		Regex_Delete(message_regex);
		return 0;
	}

	new group_len;
	Match_GetGroup(match, 1, text, group_len, strlen(text) + 1);
	if(group_len == 1 && text[0] == ' ')
	{
		Match_Free(match);
		Regex_Delete(message_regex);
		return 0;
	}

	Match_Free(match);
	Regex_Delete(message_regex);

	new message[192];
	if(GetPlayerDrunkLevel(playerid) > 2000)
		format(message, sizeof(message), "%s alcoholizado dice: %s", Player_GetName(playerid), text);
	else
		format(message, sizeof(message), "%s dice: %s", Player_GetName(playerid), text);

	new lines[2][145];
	SplitTextInLines(message, lines, 2, 145);

	Player_SendLocalMessages(playerid, lines, 2);
	SetPlayerChatBubble(playerid, text, -1, 5.0, 5000);
	
	return 0;
}

hook OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
	/*
		quick explanation:
		our flag thing uses 2 bytes for the flags and 2 bytes for the level (4 bytes, a cell)

		cell representation:
			00000000 00000000 00000000 00000000
			----------------- -----------------
			      level             flags
	*/

	new cmd_flags = (flags & ~(1 << 16));
	new cmd_level = (flags >>> 16);

	if(cmd_level != Player_Rank(playerid))
		return 0;

	if(!(cmd_flags & CMD_NO_COOLDOWN) && g_rgiPlayerCommandCooldown[playerid] + 1000 > GetTickCount())
	{
		SendClientMessage(playerid, 0xFFA02BFF, "Solo puedes enviar un comando por segundo. Algunos comandos no disponen de tiempo de espera.");
		return 0;
	}

	g_rgiPlayerCommandCooldown[playerid] = GetTickCount();

	return 1;
}

hook OPCommandPerformed(playerid, cmd[], params[], result, flags)
{
	if(result == -1)
	{
		SendClientMessagef(playerid, -1, "({FF3300}/%s{FFFFFF}) Comando desconocido, usa {DBED15}/ayuda{FFFFFF} para recibir ayuda.", cmd);
		return 0;
	}

	return 1;
}