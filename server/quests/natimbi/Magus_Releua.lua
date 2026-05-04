-- natimbi\Magus_Releua.lua NPCID 280060

function event_say(e)
	if(e.message:findi("hail")) then
		e.self:Say("I'm sorry, my Farstone magic cannot reach any available destinations at this time.");
	end
end

function event_trade(e)
	local item_lib = require("items");
	item_lib.return_items(e.self, e.other, e.trade);
end
