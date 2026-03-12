SMODS.Rarity {
    key = "elite",
    badge_colour = HEX("b3006b"),
    default_weight = 0.01
}

SMODS.Joker {
    key = "cornucopia",
    rarity = "hpr_elite",
    cost = 15,
    atlas = "placeholder",
    pos = { x = 0, y = 1 },
    config = { extra = { c_size = 3, rounds = 5 }},
    loc_vars = function (self, info_queue, card)
        return{ vars = { card.ability.extra.c_size, card.ability.extra.rounds }}
    end,
    add_to_deck = function (self, card, from_debuff)
        G.consumeables:change_size(card.ability.extra.c_size)
    end,
    remove_from_deck = function (self, card, from_debuff)
        G.consumeables:change_size(-card.ability.extra.c_size)
    end,
    calculate = function (self, card, context)
        if context.setting_blind then
            card.ability.extra.rounds = card.ability.extra.rounds - 1
            local to_create = G.consumeables.config.card_limit - (#G.consumeables.cards + G.GAME.consumeable_buffer)
            if to_create > 0 then
                G.E_MANAGER:add_event(Event{
                    func = function ()
                        for _ = 1, to_create do
                            SMODS.add_card{
                                set = "Consumeables",
                                area = G.consumeables,
                                key_append = "hpr_cornucopia"
                            }
                        end
                        return true
                    end
                })
            end
            if card.ability.extra.rounds <= 0 then
                SMODS.destroy_cards(card)
                return { message = localize("k_empty_ex") }
            end
        end
    end
}

SMODS.Joker {
    key = "golden_ratio",
    rarity = "hpr_elite",
    cost = 15,
    atlas = "placeholder",
    pos = { x = 0, y = 1 },
    config = { extra = 8 },
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra}}
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and (context.other_card:get_id() == 14 or context.other_card:get_id() == 6 or context.other_card:get_id() == 8) or context.forcetrigger then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra
            HPR.reset_dollar_buffer()
            return {
                dollars = card.ability.extra,
            }
        end
    end
}

SMODS.Joker {
    key = "pie",
    rarity = "hpr_elite",
    cost = 15,
    atlas = "placeholder",
    pos = { x = 0, y = 1 },
    config = { extra = 3.14 },
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra}}
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and (context.other_card:get_id() == 3 or context.other_card:get_id() == 14 or context.other_card:get_id() == 4) then
            return { xchips = card.ability.extra }
        end
    end
}

SMODS.Joker {
    key = "duplicator",
    rarity = "hpr_elite",
    cost = 15,
    atlas = "placeholder",
    pos = { x = 0, y = 1 },
    loc_vars = function (self, info_queue, card)
        if not (card.edition and card.edition.negative) then
            info_queue[#info_queue+1] = G.P_CENTERS.e_negative
        end
        info_queue[#info_queue+1] = { key = "perishable", set = "Other", vars = { 5, 5 } }
    end,
    calculate = function (self, card, context)
        if context.buying_card and context.card.ability.set == "Joker" then
            local c = context.card
            G.E_MANAGER:add_event(Event{
                func = function ()
                    local copy = copy_card(c)
                    copy:set_edition("e_negative", true)
                    copy:add_sticker("perishable", true)
                    copy:add_to_deck()
                    G.jokers:emplace(copy)
                    return true
                end
            })
        end
    end,
    blueprint_compat = false,
    hpr_ascension_key = "j_hpr_mimic"
}

SMODS.Joker {
    key = "prospector",
    rarity = "hpr_elite",
    cost = 15,
    atlas = "placeholder",
    pos = { x = 0, y = 1 },
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_gold
    end,
    calculate = function (self, card, context)
        if context.first_hand_drawn and not context.retrigger_joker and not G.GAME.hpr_prospector_triggering then
            G.GAME.hpr_prospector_triggering = true
            G.E_MANAGER:add_event(Event{
                func = function ()
                    local golds = {}
                    for _, c in ipairs(G.deck.cards) do
                        if SMODS.has_enhancement(c, "m_gold") then
                            golds[#golds+1] = c
                        end
                    end
                    delay(0.3)
                    SMODS.drawn_cards = {}
                    for i = 1, #golds do
                        draw_card(G.deck, G.hand, nil, "up", true, golds[i])
                    end
                    G.E_MANAGER:add_event(Event{ --i heart recreating smods functions because of limited functionality related to drawing specific cards
                        trigger = "before",
                        delay = 0.4,
                        func = function ()
                            if #SMODS.drawn_cards > 0 then
                                SMODS.calculate_context({
                                    first_hand_drawn = not G.GAME.current_round.any_hand_drawn and G.GAME.facing_blind,
                                    hand_drawn = G.GAME.facing_blind and SMODS.drawn_cards, --literally why the fuck does lsp say this should be a boolean when the docs say its a table
                                    other_drawn = not G.GAME.facing_blind and SMODS.drawn_cards,
                                })
                                SMODS.drawn_cards = {}
                                if G.GAME.facing_blind then G.GAME.current_round.any_hand_drawn = true end
                            end
                            return true
                        end
                    })
                    G.E_MANAGER:add_event(Event{
                        func = function ()
                            G.GAME.hpr_prospector_triggering = nil
                            save_run()
                            return true
                        end
                    })
                    return true
                end
            })
        end
    end
}

SMODS.Joker {
    key = "evil_heat",
    rarity = "hpr_elite",
    cost = 15,
    atlas = "placeholder",
    pos = { x = 0, y = 1 },
    config = { extra = { xmult = 1, gain = 0.25, heat_max = 3 }},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.gain, card.ability.extra.heat_max }}
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 10 then
            local ret = { xmult = card.ability.extra.xmult }
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "xmult",
                scalar_value = "gain",
                no_message = true,
            })
            if ret.xmult ~= 1 then
                return ret
            end
        end
        if context.destroy_card and (context.cardarea == G.play or context.cardarea == "unscored") and card.ability.extra.xmult >= card.ability.extra.heat_max then
            return { remove = true }
        end
        if context.after then
            card.ability.extra.xmult = 1
        end
    end
}

SMODS.Joker {
    key = "ashes",
    rarity = "hpr_elite",
    cost = 15,
    atlas = "placeholder",
    pos = { x = 0, y = 1 },
    calculate = function (self, card, context)
        if context.before then
            local enh_pool = SMODS.shallow_copy(get_current_pool("Enhanced"))
            for k in ipairs(enh_pool) do
                if enh_pool[k] ~= "UNAVAILABLE" and (enh_pool[k] == "m_stone" or G.P_CENTERS[enh_pool[k]].has_no_rank or G.P_CENTERS[enh_pool[k]].replace_base_card) then
                    enh_pool[k] = "UNAVAILABLE"
                end
            end
            for _, c in ipairs(context.scoring_hand) do
                if c:get_id() == 14 then
                    c:set_ability(SMODS.poll_enhancement{ options = enh_pool, guaranteed = true, key_append = "hpr_ashes_enh" } or "c_base", nil, true)
                    c:set_seal(SMODS.poll_seal{ guaranteed = true, type_key = "hpr_ashes_seal" })
                    c:set_edition(SMODS.poll_edition{ guaranteed = true, type_key = "hpr_ashes_ed"}, nil, nil, true)
                end
            end
        end
    end
}

--more encore jokers after they get added so hopefully an elite joker for each rank will exist