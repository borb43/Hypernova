
SMODS.Enhancement {
    key = "ripple",
    atlas = "enhancers",
    pos = { x = 0, y = 0 },
    config = { extra = 20 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra }}
    end,
    calculate = function (self, card, context)
        if context.before and context.cardarea == G.play then
            for _, c in ipairs(context.scoring_hand) do
                if c ~= card then
                    c.ability.perma_bonus = c.ability.perma_bonus + card.ability.extra
                    SMODS.calculate_effect({ message = localize("k_upgrade_ex"), message_card = c, colour = G.C.CHIPS })
                end
            end
            return nil, true
        end
    end,
    weight = 2
}

SMODS.Enhancement {
    key = "storm",
    atlas = "enhancers",
    pos = { x = 1, y = 0 },
    config = { extra = 3 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra }}
    end,
    calculate = function (self, card, context)
        if context.before and context.cardarea == G.play then
            for _, c in ipairs(context.scoring_hand) do
                if c ~= card then
                    c.ability.perma_mult = c.ability.perma_mult + card.ability.extra
                    SMODS.calculate_effect({ message = localize("k_upgrade_ex"), message_card = c, colour = G.C.CHIPS })
                end
            end
            return nil, true
        end
    end,
    weight = 2
}

SMODS.Enhancement {
    key = "mimic",
    atlas = "enhancers",
    pos = { x = 2, y = 0 },
    config = { x_mult = 1.25 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.x_mult }}
    end,
    weight = 2
}