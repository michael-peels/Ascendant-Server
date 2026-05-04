-- abysmal\Magus_Pellen.lua NPCID 279217

function event_say(e)
	if e.message:findi("hail") then
		e.self:Say("I can provide you with travel to [" .. eq.say_link("Natimbi",false,"Natimbi") .. "] with our Farstone magic.  Just tell me where you'd like to go and I shall send you.");
	elseif e.message:findi("natimbi") then
		e.other:MovePC(280, -1557, -853, 241, 180); -- Zone: natimbi
	end
end

function event_trade(e)
	local item_lib = require("items");
	item_lib.return_items(e.self, e.other, e.trade);
end
