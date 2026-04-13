#include "common/servertalk.h"
#include "zone/client.h"
#include "zone/worldserver.h"

extern WorldServer worldserver;

void command_adventure(Client *c, const Seperator *sep)
{
	auto arguments = sep->argnum;
	if (arguments < 1) {
		c->Message(Chat::White, "Usage: #adventure clear [player] - Force clear a player's active adventure (target or by name)");
		c->Message(Chat::White, "Usage: #adventure list - List all active adventures");
		return;
	}

	std::string sub_command = sep->arg[1];

	if (sub_command == "clear") {
		std::string player_name;

		if (sep->arg[2][0] != '\0') {
			player_name = sep->arg[2];
		}
		else if (c->GetTarget() && c->GetTarget()->IsClient()) {
			player_name = c->GetTarget()->CastToClient()->GetName();
		}
		else {
			c->Message(Chat::Red, "Usage: #adventure clear [player] - Target a player or provide a name.");
			return;
		}

		auto pack = new ServerPacket(
			ServerOP_AdventureForceClear,
			sizeof(ServerAdventureForceClear_Struct)
		);
		auto *saf = (ServerAdventureForceClear_Struct *) pack->pBuffer;
		strn0cpy(saf->requester, c->GetName(), sizeof(saf->requester));
		strn0cpy(saf->player, player_name.c_str(), sizeof(saf->player));
		worldserver.SendPacket(pack);
		safe_delete(pack);

		c->Message(Chat::Yellow, "Sent adventure clear request for player '%s' to world.", player_name.c_str());

		if (c->GetTarget() && c->GetTarget()->IsClient()) {
			Client *target = c->GetTarget()->CastToClient();
			if (strcasecmp(target->GetName(), player_name.c_str()) == 0) {
				target->ClearAdventureData();
				target->ClearPendingAdventureData();
				target->ClearPendingAdventureCreate();
				target->ClearPendingAdventureLeave();
				target->ClearPendingAdventureDoorClick();
				target->SendAdventureError("Your adventure has been cleared by a GM.");
			}
		}
	}
	else if (sub_command == "list") {
		auto pack = new ServerPacket(
			ServerOP_AdventureListRequest,
			sizeof(ServerAdventureListRequest_Struct)
		);
		auto *sal = (ServerAdventureListRequest_Struct *) pack->pBuffer;
		strn0cpy(sal->requester, c->GetName(), sizeof(sal->requester));
		worldserver.SendPacket(pack);
		safe_delete(pack);

		c->Message(Chat::Yellow, "Requesting active adventure list from world...");
	}
	else {
		c->Message(Chat::White, "Usage: #adventure clear [player] - Force clear a player's active adventure");
		c->Message(Chat::White, "Usage: #adventure list - List all active adventures");
	}
}
