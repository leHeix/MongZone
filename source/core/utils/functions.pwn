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

