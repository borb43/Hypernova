SMODS.Joker {
    key = "evil_eris",
    atlas = "placeholder",
    pos = { x = 0, y = 2 },
    soul_pos = { x = 1, y = 2 },
    rarity = "entr_reverse_legendary",
    cost = 20,
    blueprint_compat = true,
    config = { extra = { asc = 0.25, xasc = 0.05 }},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.asc, card.ability.extra.xasc }}
    end,
    calculate = function (self, card, context)
        if context.using_consumeable and HPR.is_any(context.consumeable.ability.set, "hpr_moons", "Star", "Planet") then
            for _, c in ipairs(G.playing_cards) do
                if SMODS.has_no_rank(c) then
                    c.ability.entr_perma_asc = c.ability.entr_perma_asc + card.ability.extra.xasc
                else
                    c.ability.entr_perma_plus_asc = c.ability.entr_perma_plus_asc + card.ability.asc
                end
            end
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.GOLD
            }
        end
    end
}