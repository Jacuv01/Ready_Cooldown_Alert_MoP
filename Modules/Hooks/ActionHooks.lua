local ActionHooks = {}

ActionHooks.callbacks = {}

function ActionHooks:RegisterCallback(callback)
    table.insert(self.callbacks, callback)
end

function ActionHooks:TriggerCallbacks(actionType, id, texture, extraData)
    for _, callback in ipairs(self.callbacks) do
        callback(actionType, id, texture, extraData)
    end
end

function ActionHooks:GetItemSpellID(itemID)
    if ItemData then
        return ItemData:GetItemSpell(itemID)
    end
    local spellName, spellID = GetItemSpell(itemID)
    return spellID
end

function ActionHooks:HookUseAction()
    hooksecurefunc("UseAction", function(slot)
        local actionType, itemID = GetActionInfo(slot)
        
        if actionType == "item" then
            local spellID = self:GetItemSpellID(itemID)
            local texture = GetActionTexture(slot)
            
            self:TriggerCallbacks("item", itemID, texture, {
                spellID = spellID,
                slot = slot,
                source = "actionbar"
            })
        end
    end)
end

function ActionHooks:HookUseInventoryItem()
    hooksecurefunc("UseInventoryItem", function(slot)
        local itemID = GetInventoryItemID("player", slot)

        if itemID then
            local spellID = self:GetItemSpellID(itemID)
            local texture = GetInventoryItemTexture("player", slot)
            
            self:TriggerCallbacks("item", itemID, texture, {
                spellID = spellID,
                slot = slot,
                source = "inventory"
            })
        end
    end)
end

function ActionHooks:Initialize()
    self:HookUseAction()
    self:HookUseInventoryItem()
end

_G.ActionHooks = ActionHooks

return ActionHooks
