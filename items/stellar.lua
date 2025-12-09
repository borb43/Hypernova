
SMODS.Gradient {
    key = "stellar",
    colours = {
        HEX("010052"),
        HEX("520052")
    }
}

SMODS.Rarity {
    badge_colour = SMODS.Gradients.hpr_stellar,
    key = "stellar"
}

SMODS.Joker {
    key = "observatorium",
    atlas = "placeholder",
    pos = { x = 0, y = 1 },
    soul_pos = { x = 1, y = 1 },
    config = { extra = { chips = 0, mult = 0, asc = 0 }},
    rarity = "hpr_stellar",
    cost = 30,
    blueprint_compat = true,
    demicoloncompat = true,
    perishable_compat = false,
    calculate = function (self, card, context)
        if context.hpr_level_up_hand then
            card.ability.extra.chips = card.ability.extra.chips + context.chips
            card.ability.extra.mult = card.ability.extra.mult + context.mult
            for _, c in pairs(G.playing_cards) do
                c.ability.perma_bonus = c.ability.perma_bonus + context.chips
                c.ability.perma_mult = c.ability.perma_mult + context.mult
            end
            if not context.instant then
                return {
                    message = localize("k_upgrade_ex")
                }
            end
        end
        if context.joker_main or context.forcetrigger then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.chips,
                plus_asc = card.ability.extra.asc
            }
        end
    end,
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.asc }}
    end
}