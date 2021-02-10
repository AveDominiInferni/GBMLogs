frame = CreateFrame("FRAME", "frame")
frame:RegisterEvent("PLAYER_ALIVE")
frame:RegisterEvent("PLAYER_MONEY")
frame:RegisterEvent("BANKFRAME_OPENED")
charname = UnitName("player")

function eventHandler()
	if event == "BANKFRAME_OPENED" then
		local i = 0
		blog = ""
		for bag = -1, 10 do
			local slots = GetContainerNumSlots(bag)
			for slot = 1, slots do
				local itemLink = GetContainerItemLink(bag,slot)
				if itemLink then
					local icon, itemCount = GetContainerItemInfo(bag, slot)
					local itemName = GetItemName(itemLink)
					blog = table.concat({blog, itemCount, "~", itemName, "*"})
					i = i + 1
				end
			end
		end
		DEFAULT_CHAT_FRAME:AddMessage("Bag logs have been updated, " .. i .. " entries")
		if i == 0 then
			blog = nil
		end
	elseif event == "PLAYER_MONEY" or event == "PLAYER_ALIVE" then
		money = tostring(GetMoney())
	end
end

frame:SetScript("OnEvent", eventHandler)


SlashCmdList["SLASH_GML"] = function(flag) end
SLASH_GML1 = "/mlog"
function SlashCmdList.GML(args)
	local i = 0
	mlog = ""
	CheckInbox();
	local mailNum = GetInboxNumItems()
	for mailcount = 1, mailNum do
		local packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, hasItem, wasRead, wasReturned, textCreated, canReply, isGM = GetInboxHeaderInfo(mailcount)
		local name, itemTexture, count, quality, canUse = GetInboxItem(mailcount)
		if name == nil then name = nothing end
		if count == nil then count = 0 end
		mlog = table.concat({mlog, sender, "~", money, "~", name, "~", count, "*"})
		i = i + 1
	end
	DEFAULT_CHAT_FRAME:AddMessage("Mail logs have been updated, " .. i .. " entries")
	if i == 0 then
		mlog = nil
	end
end


function GetItemName(some_string)
	local name_start = string.find(some_string, "%[") + 1
	local name_end = string.find(some_string, "%]") - 1
	return string.sub(some_string, name_start, name_end)
end


	
