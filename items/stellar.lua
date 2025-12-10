HPR.stellar_gradient = SMODS.Gradient {
    key = "stellar",
    colours = {
        HEX("010052"),
        HEX("520052")
    }
}

SMODS.Rarity {
    badge_colour = HPR.stellar_gradient,
    key = "stellar"
}

SMODS.Consumable {
    key = "ascender",
    atlas = "placeholder",
    pos = { x = 2, y = 2 },
    --soul_pos,
    set = "Spectral",
    cost = 4,
    hidden = true,
    can_use = function (self, card)
        return G.jokers and #G.jokers.highlighted == 1 and HPR.get_ascension(G.jokers.highlighted[1])
    end,
    use = function (self, card, area, copier)
        G.E_MANAGER:add_event(Event{
            trigger = 'after',
            delay = 0.4,
            func = function ()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        })
        G.E_MANAGER:add_event(Event{
            trigger = 'after',
            delay = 0.15,
            func = function ()
                G.jokers.highlighted[1]:flip()
                play_sound('card1')
                return true
            end
        })
        delay(0.2)
        G.E_MANAGER:add_event(Event{
            trigger = 'after',
            delay = 0.15,
            func = function ()
                G.jokers.highlighted[1]:set_ability(HPR.get_ascension(G.jokers.highlighted[1]))
                G.jokers.highlighted[1]:flip()
                return true
            end
        })
        delay(0.5)
    end
}

HPR.vanilla_ascensions = {
    j_supernova = "j_hpr_observatorium",
    j_constellation = "j_hpr_observatorium",
    j_space = "j_hpr_observatorium"
}

SMODS.Joker {
    key = "observatorium",
    atlas = "placeholder",
    pos = { x = 0, y = 1 },
    soul_pos = { x = 1, y = 1 },
    config = { extra = { chips = 0, mult = 0 }},
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
                mult = card.ability.extra.chips
            }
        end
    end,
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.asc }}
    end
}