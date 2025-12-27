
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
                    SMODS.calculate_effect({ message = localize("k_upgrade_ex"), message_card = c })
                end
            end
            return nil, true
        end
    end
}