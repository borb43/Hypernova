SMODS.Joker { --fusion reactor, balances before scoring
    key = "fusion",
    atlas = "placeholder",
    pos = { x = 1, y = 0 },
    rarity = 2,
    cost = 7,
    blueprint_compat = true,
    demicoloncompat = true,
    calculate = function (self, card, context)
        if context.initial_scoring_step or context.forcetrigger then
            return {
                balance = true
            }
        end
    end
}


SMODS.Joker {
    key = "gambler",
    atlas = "placeholder",
    pos = { x = 0, y = 0 },
    config = { extra = { chips = 0, mult = 0, multiplier = 1 }},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult }}
    end,
    rarity = 2,
    cost = 4,
    calculate = function (self, card, context)
        if context.pseudorandom_result then
            if not context.result then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "chips",
                    scalar_value = "multiplier",
                    operation = function(ref_table, ref_value, initial, change)
                        ref_table[ref_value] = initial + change*context.numerator*context.denominator
                    end,
                    message = {
                        colour = G.C.CHIPS,
                        message_key = "a_chips"
                    }
                })
            elseif context.result then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "mult",
                    scalar_value = "multiplier",
                    operation = function(ref_table, ref_value, initial, change)
                        ref_table[ref_value] = initial + change*context.denominator
                    end,
                    message = {
                        colour = G.C.MULT,
                        message_key = "a_mult"
                    }
                })
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end
    end
}