SMODS.Joker { --tipping scales, increases numerator and denominator of probabilities
    key = "scales",
    atlas = "placeholder",
    pos = { x = 0, y = 0 },
    config = { extra = { mod = 1 } },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.mod } }
    end,
    rarity = 1,
    cost = 5,
    calculate = function (self, card, context)
        if context.mod_probability and not context.blueprint then
            return {
                numerator = context.numerator + card.ability.extra.mod,
                denominator = context.denominator + card.ability.extra.mod
            }
        end
    end
}

SMODS.Joker {
    key = "british",
    atlas = "placeholder",
    pos = { x = 0, y = 0 },
    config = { extra = 45 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra }}
    end,
    rarity = 1,
    cost = 2,
    blueprint_compat = true,
    demicoloncompat = true,
    calculate = function (self, card, context)
        if context.joker_main or context.forcetrigger then
            return {
                chips = card.ability.extra,
                message = localize { type = "variable", key = "a_crisps", vars = { card.ability.extra }}
            }
        end
    end
}