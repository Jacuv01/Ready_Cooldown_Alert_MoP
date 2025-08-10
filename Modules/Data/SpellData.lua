local SpellData = {}

function SpellData:GetSpellInfo(spellID)
    return {
        name = GetSpellInfo(spellID),
        texture = GetSpellTexture(spellID),
        spellID = spellID
    }
end

function SpellData:GetSpellCooldown(spellID)
    local start, duration, enabled, modRate = GetSpellCooldown(spellID)
    return {
        start = start,
        duration = duration,
        enabled = enabled,
        modRate = modRate or 1
    }
end

function SpellData:IsSpellKnown(spellID)
    return IsSpellKnown(spellID)
end

function SpellData:GetRemainingCooldown(spellID)
    local cooldown = self:GetSpellCooldown(spellID)
    if cooldown.start and cooldown.duration > 0 then
        return cooldown.duration - (GetTime() - cooldown.start)
    end
    return 0
end

_G.SpellData = SpellData

return SpellData