/*
**
** 	Sends a reliable, non-ordered, non-sequenced, crafted RPC for client checks
** 				and fixes OnClientCheckResposne call problems.
**
*/

#if defined _PATCH_sendclientcheck_
	#endinput
#endif
#define _PATCH_sendclientcheck_

#include <YSI_Coding\y_hooks>

hook native SendClientCheck(playerid, type, memAddr, memOffset, byteCount)
{
	new BitStream:bs = BS_New();

	BS_WriteValue(bs,
		PR_UINT8, type,
		PR_UINT32, memAddr, 
		PR_UINT16, memOffset,
		PR_UINT16, byteCount
	);

	PR_SendRPC(bs, playerid, 0x67, PR_HIGH_PRIORITY, PR_RELIABLE);
	
	BS_Delete(bs);

	return 1;
}

PR_Handler<PR_INCOMING_RPC,sccir>:0x67(playerid, BitStream:bs)
{
	new type, arg, response;

	BS_ReadValue(bs,
		PR_UINT8, type,
		PR_UINT32, arg,
		PR_UINT8, response
	);

	CallLocalFunction(!"OnClientCheckResponse", !"dddd", playerid, type, arg, response);

	return 1;
}