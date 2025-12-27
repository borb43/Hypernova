
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

SMODS.Enhancement {
    key = "prism",
    atlas = "enhancers",
    pos = { x = 3, y = 0 },
    shatters = true,
    loc_vars = function (self, info_queue, card)
        if not self.edition or self.edition.key ~= "e_polychrome" then
            info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
        end
    end,
    calculate = function (self, card, context)
        if context.before and context.cardarea == G.play then
            local cards = SMODS.Edition:get_edition_cards(G.hand, true)
            local target = pseudorandom_element(cards, "hpr_prism")
            if target then
                return {
                    message = localize("k_upgrade_ex"),
                    colour = G.C.DARK_EDITION,
                    message_card = target,
                    func = function ()
                        target:set_edition("e_polychrome", nil, nil)
                    end
                }
            end
        end
        if context.discard and context.other_card == card then
            return { remove = true }
        end
        if context.playing_card_end_of_round then
            SMODS.destroy_cards(card)
        end
    end,
    weight = 2
}

SMODS.Enhancement {
    key = "alloy",
    atlas = "enhancers",
    pos = { x = 0, y = 1 },
    weight = 2
}

SMODS.Enhancement {
    key = "schematic",
    atlas = "enhancers",
    pos = { x = 1, y = 1},
    no_rank = true,
    no_suit = true,
    replace_base_card = true,
    always_scores = true,
    calculate = function (self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return { balance = true }
        end
    end,
    weight = 2
}

SMODS.Enhancement {
    key = "silver",
    atlas = "enhancers",
    pos = { x = 2, y = 1 },
    calculate = function (self, card, context)
        if context.playing_card_end_of_round and context.cardarea == G.hand then
            G.E_MANAGER:add_event(Event{
                func = function ()
                    add_tag(Tag(HPR.poll_tag("hpr_silver"), false, "Small"))
                    return true
                end
            })
            return { message = localize("k_plus_tag") }
        end
    end,
    weight = 2
}

SMODS.Enhancement {
    key = "lunar",
    atlas = "enhancers",
    pos = { x = 3, y = 1 },
    config = { extra = 2 },
    loc_vars = function (self, info_queue, card)
        local n, d = SMODS.get_probability_vars(card, 1, card.ability.extra, "hpr_lunar")
    end,
    calculate = function (self, card, context)
        if context.before and context.cardarea == G.play and SMODS.pseudorandom_probability(card, "hpr_lunar", 1, card.ability.extra) then
            return {
                level_up = true,
                message = localize("k_level_up_ex")
            }
        end
    end
}