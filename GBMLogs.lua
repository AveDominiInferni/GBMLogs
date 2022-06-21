frame = CreateFrame("FRAME", "frame")
frame:RegisterEvent("BANKFRAME_OPENED")
charname = UnitName("player")
DEFAULT_CHAT_FRAME:AddMessage("Bank log tracking enabled")

function eventHandler()
	if bank == nil then
		bank = ""
	end
	if event == "BANKFRAME_OPENED" then
		local name_start, name_end = string.find(bank, charname)
		if name_start ~= nil then
			local entry_end, junk = string.find(bank, "$", name_end, true)
			local temp1 = ""
			local temp2 = ""
			if name_start ~= 1 then
				temp1 = string.sub(bank, 1, name_start - 1)
			end
			if string.len(bank) ~= entry_end then
				temp2 = string.sub(bank, entry_end + 1)
			end
			bank = table.concat({temp1, temp2})
		end
		bank = table.concat({bank, charname, "*"})
		local i = 0
		for bag = -1, 10 do
			local slots = GetContainerNumSlots(bag)
			for slot = 1, slots do
				local itemLink = GetContainerItemLink(bag,slot)
				if itemLink then
					local icon, itemCount = GetContainerItemInfo(bag, slot)
					local itemName = GetItemName(itemLink)
					bank = table.concat({bank, itemCount, "~", itemName, "*"})
					i = i + 1
				end
			end
		end
		bank = table.concat({bank, tostring(GetMoney()), "~Money", "$"})
		DEFAULT_CHAT_FRAME:AddMessage("Bank logs have been updated, " .. i .. " entries")
	end
end

frame:SetScript("OnEvent", eventHandler)

SlashCmdList["SLASH_GML"] = function(flag) end
SLASH_GML1 = "/mlog"
function SlashCmdList.GML(args)
	local i = 0
	if mail == nil then
		mail = ""
	end
	CheckInbox();
	local mailNum = GetInboxNumItems()
	for mailcount = 1, mailNum do
		local packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, hasItem, wasRead, wasReturned, textCreated, canReply, isGM = GetInboxHeaderInfo(mailcount)
		local name, itemTexture, count, quality, canUse = GetInboxItem(mailcount)
		if name == nil then name = nothing end
		if count == nil then count = 0 end
		mail = table.concat({mail, sender, "~", money, "~", name, "~", count, "*"})
		i = i + 1
	end
	DEFAULT_CHAT_FRAME:AddMessage("Mail logs have been updated, " .. i .. " entries")
end

function GetItemName(some_string)
	local name_start = string.find(some_string, "%[") + 1
	local name_end = string.find(some_string, "%]") - 1
	return string.sub(some_string, name_start, name_end)
end
