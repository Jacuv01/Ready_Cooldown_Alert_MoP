local ItemData = {}

function ItemData:GetItemInfo(itemID)
    local itemName, _, _, _, _, _, _, _, _, itemIcon = GetItemInfo(itemID)
    return {
        name = itemName,
        texture = itemIcon,
        itemID = itemID
    }
end

function ItemData:GetItemCooldown(itemID)
    local start, duration, enabled = GetItemCooldown(itemID)
    return {
        start = start,
        duration = duration,
        enabled = enabled
    }
end

function ItemData:GetItemSpell(itemID)
    local spellName, spellID = GetItemSpell(itemID)
    return spellID, spellName
end

function ItemData:GetInventoryItemInfo(slot)
    local itemID = GetInventoryItemID("player", slot)
    if itemID then
        local itemName, _, _, _, _, _, _, _, _, itemIcon = GetItemInfo(itemID)
        return {
            itemID = itemID,
            texture = GetInventoryItemTexture("player", slot),
            name = itemName
        }
    end
    return nil
end

function ItemData:GetContainerItemInfo(bag, slot)
    local itemID = GetContainerItemID(bag, slot)
    if not itemID then
        local itemLink = GetContainerItemLink(bag, slot)
        if itemLink then
            itemID = tonumber(itemLink:match("item:(%d+)"))
        end
    end
    
    if itemID then
        local itemName, _, _, _, _, _, _, _, _, itemIcon = GetItemInfo(itemID)
        return {
            itemID = itemID,
            texture = itemIcon,
            name = itemName
        }
    end
    return nil
end

_G.ItemData = ItemData

return ItemData