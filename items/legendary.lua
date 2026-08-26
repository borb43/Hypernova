SMODS.Joker {
    key = "eris",
    atlas = "joker",
    pos = { x = 0, y = 1 },
    soul_pos = { x = 1, y = 1 },
    rarity = 4,
    cost = 20,
    blueprint_compat = false,
    forcetrigger_compat = true,
    config = { extra = { xchips = 0.25 }},
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_stone
        return { vars = { card.ability.extra.xchips }}
    end,
    calculate = function (self, card, context)
        if context.before then
            local any
            for _,c in ipairs(context.full_hand) do
                if (c:get_id() == 14 or SMODS.has_enhancement(c, "m_stone")) and not c.debuff then
                    any = true
                    SMODS.calculate_effect({
                        level_up = true,
                        message = localize("k_level_up_ex"),
                        message_card = c
                    }, card)
                end
            end
            if any then
                return nil, true
            end
        end
    end,
}