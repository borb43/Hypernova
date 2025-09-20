SMODS.Joker {
    key = "eris",
    atlas = "placeholder",
    pos = { x = 3, y = 0 },
    soul_pos = { x = 4, y = 0 },
    config = { extra = { chips = 25, xmult = 0.1, reps = 2 }},
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_stone
        return { vars = { card.ability.extra.chips, card.ability.extra.xmult, card.ability.extra.reps }}
    end,
    rarity = 4,
    cost = 20,
    blueprint_compat = true,
    demicoloncompat = true,
    calculate = function (self, card, context)
        if context.repetition and SMODS.has_enhancement(context.other_card, "m_stone") then
            return {
                repetitions = card.ability.extra.reps
            }
        end
        if context.end_of_round or context.forcetrigger then
            for _, rock in pairs(G.I.CARD) do
                if SMODS.has_enhancement(rock, "m_stone") then
                    rock.ability.perma_bonus = (rock.ability.perma_bonus or 0) + card.ability.extra.chips
                    rock.ability.perma_x_mult = (rock.ability.perma_x_mult or 1) + card.ability.extra.xmult
                end
            end
        end
    end
}