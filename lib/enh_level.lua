--this fucking sucks so im coming back to this later
do return end

HPR.level_enhancement = function (enh_key, amt)
    G.GAME.hpr_enh_levels = G.GAME.hpr_enh_levels or {}
    G.GAME.hpr_enh_levels[enh_key] = (G.GAME.hpr_enh_levels[enh_key] or 0) + amt
    if enh_key == "m_wild" then
        G.GAME.hpr_enh_levels.m_wild = G.GAME.hpr_enh_levels.m_wild or { chips = 0, mult = 0, xchips = 0, xmult = 0, l_chips = 10, l_mult = 1, l_xchips = 0.1, l_xmult = 0.1 }
        local roll = pseudorandom_element({"chips", "mult", "xchips", "xmult"}, "wild_upgrade") or "chips"
        G.GAME.hpr_enh_levels.m_wild[roll] = G.GAME.hpr_enh_levels.m_wild[roll] + G.GAME.hpr_enh_levels.m_wild["l_"..roll]
        local bonus_name = roll == "chips" and "perma_bonus" or roll == "xchips" and "perma_x_chips" or roll == "xmult" and "perma_x_mult" or "perma_mult"
        for _, card in pairs(G.I.CARD) do
            if card.config.center.key == "m_wild" then
                card.ability[bonus_name] = card.ability[bonus_name] + G.GAME.hpr_enh_levels.m_wild["l_"..roll]
            end
        end
    elseif G.P_CENTERS[enh_key].hpr_level then
        local l_data = G.P_CENTERS[enh_key].hpr_level
        for _, c in pairs(G.I.CARD) do
            local t = l_data.is_in_extra and c.ability.extra or c.ability
            t[l_data.val_key] = t[l_data.val_key] + l_data.amount * amt
        end
    end
end

local set_ability_ref = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
    G.GAME.hpr_enh_levels = G.GAME.hpr_enh_levels or {}
    local l_data = G.P_CENTERS[self.config.center.key].hpr_level
    if self.config.center.key == "m_wild" then
        G.GAME.hpr_enh_levels.m_wild = G.GAME.hpr_enh_levels.m_wild or { chips = 0, mult = 0, xchips = 0, xmult = 0, l_chips = 10, l_mult = 1, l_xchips = 0.1, l_xmult = 0.1 }
        local ca = self.ability or {}
        ca.perma_bonus = ca.perma_bonus - G.GAME.hpr_enh_levels.m_wild.chips
        ca.perma_mult = ca.perma_mult - G.GAME.hpr_enh_levels.m_wild.mult
        ca.perma_x_chips = ca.perma_x_chips - G.GAME.hpr_enh_levels.m_wild.xchips
        ca.perma_x_mult = ca.perma_x_mult - G.GAME.hpr_enh_levels.m_wild.xmult
    elseif G.GAME.hpr_enh_levels[self.config.center.key] and l_data and l_data.val_key == "bonus" then
        self.ability[l_data.val_key] = self.ability[l_data.val_key] - l_data.amount * G.GAME.hpr_enh_levels[self.config.center.key]
    end
    set_ability_ref(self, center, initial, delay_sprites)
    if self.config.center.key == "m_wild" then
        G.GAME.hpr_enh_levels.m_wild = G.GAME.hpr_enh_levels.m_wild or { chips = 0, mult = 0, xchips = 0, xmult = 0, l_chips = 10, l_mult = 1, l_xchips = 0.1, l_xmult = 0.1 }
        local ca = self.ability or {}
        ca.perma_bonus = ca.perma_bonus + G.GAME.hpr_enh_levels.m_wild.chips
        ca.perma_mult = ca.perma_mult + G.GAME.hpr_enh_levels.m_wild.mult
        ca.perma_x_chips = ca.perma_x_chips + G.GAME.hpr_enh_levels.m_wild.xchips
        ca.perma_x_mult = ca.perma_x_mult + G.GAME.hpr_enh_levels.m_wild.xmult
    elseif G.GAME.hpr_enh_levels[self.config.center.key] and l_data then
        local t = l_data.is_in_extra and self.ability.extra or self.ability or {}
        t[l_data.val_key] = t[l_data.val_key] + l_data.amount * G.GAME.hpr_enh_levels[self.config.center.key]
    end
end

G.P_CENTERS.m_bonus.hpr_level = {
    val_key = "bonus",
    amount = 15,
    is_in_extra = false
}

G.P_CENTERS.m_mult.hpr_level = {
    val_key = "mult",
    amount = 2,
    is_in_extra = false
}

G.P_CENTERS.m_glass.hpr_level = {
    val_key = "extra",
    amount = 1,
    is_in_extra = false
}