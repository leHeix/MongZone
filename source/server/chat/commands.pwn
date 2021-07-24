#if defined _CHAT_COMMANDS_
	#endinput
#endif
#define _CHAT_COMMANDS_

command d(playerid, params[], "Envia un mensaje desde tu personaje")
{
	if(isnull(params))
		return SendClientMessage(playerid, -1, "USO: /d {424242}<texto: string>");

	new Regex:message_regex = Regex_New("^\\s*([\\s\\S]+)$", REGEX_ICASE);
	new RegexMatch:match;

	if(!Regex_Match(params, message_regex, match))
	{
		Regex_Delete(message_regex);
		return 0;
	}

	new group_len;
	Match_GetGroup(match, 1, params, group_len, strlen(params) + 1);
	if(group_len == 1 && params[0] == ' ')
	{
		Match_Free(match);
		Regex_Delete(message_regex);
		return 0;
	}

	Match_Free(match);
	Regex_Delete(message_regex);

	new message[192];
	if(GetPlayerDrunkLevel(playerid) > 2000)
		format(message, sizeof(message), "%s alcoholizado dice: %s", Player_GetName(playerid), params);
	else
		format(message, sizeof(message), "%s dice: %s", Player_GetName(playerid), params);

	new lines[2][145];
	SplitTextInLines(message, lines, 2, 145);

	Player_SendLocalMessages(playerid, lines, 2);
	SetPlayerChatBubble(playerid, params, -1, 5.0, 5000);

	return 1;
}
flags:d(CMD_ADMIN<RANK_LEVEL_USER> | CMD_HIDDEN | CMD_NO_COOLDOWN)