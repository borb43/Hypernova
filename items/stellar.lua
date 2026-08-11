
SMODS.Rarity {
    badge_colour = HPR.stellar_gradient,
    key = "stellar",
    get_weight = function (self, weight, object_type)
        return G.GAME.modifiers.hpr_stellar_in_shop and 0.05 or 0
    end,
    default_weight = 0,
    pools = { Joker = true }
}

HPR.STELLAR_INDEX = 0
HPR.StellarJoker = SMODS.Joker:extend({
    atlas = "hpr_stellar",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    rarity = "hpr_stellar",
    cost = 30,
    inject = function (self, i)
        SMODS.Joker.inject(self, i)
        self.stellar_num = HPR.STELLAR_INDEX
        HPR.STELLAR_INDEX = HPR.STELLAR_INDEX + 1
    end
})

SMODS.Consumable {
    key = "ascender",
    set = "Spectral",
    atlas = "placeholder",
    pos = { x = 2, y = 2 },
    cost = 4,
    hidden = true,
    can_use = function (self, card)
        local highlighted = Spectrallib.get_highlighted_cards({ G.jokers }, card, 1, 1)
        return #highlighted == 1 and not not G.P_CENTERS[HPR.get_ascension(highlighted[1])]
    end,
    use = function (self, card, area, copier)
        local function blacklist(c)
            local asc = HPR.get_ascension(c)
            if asc and G.P_CENTERS[asc] then return true end
            return false
        end
        local highlighted = Spectrallib.get_highlighted_cards({ G.jokers }, card, 1, 1, blacklist, self.key.."_forcetrigger")
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
                highlighted[1]:flip()
                play_sound('card1')
                return true
            end
        })
        delay(0.2)
        G.E_MANAGER:add_event(Event{
            trigger = 'after',
            delay = 0.15,
            func = function ()
                highlighted[1]:remove_from_deck()
                highlighted[1]:set_ability(HPR.get_ascension(G.jokers.highlighted[1]))
                highlighted[1]:add_to_deck()
                highlighted[1]:set_cost()
                highlighted[1]:flip()
                return true
            end
        })
        delay(0.5)
    end,
    force_use = function (self, card, area)
        self:use(card, area)
    end,
    forcetrigger_compat = true,
    attributes = { "rarity", "joker", }
}

HPR.error_ops = { '+', '-', '=', '..', 'X', '/', '^', '%', '?' }
HPR.error_numbers = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '21', '41', '61', '67', '69', '84', '404', '420', 'nan', 'inf', 'i', 'e', 'pi', 'n'}

HPR.StellarJoker {
    key = "missing",
    config = { extra = { uses = 4 }},
    loc_vars = function (self, info_queue, card)
        local error_other = {
            { string = localize("k_chips"), colour = G.C.CHIPS },
            { string = localize("k_mult"),  colour = G.C.MULT },
            { string = localize("k_blindsize"),  colour = G.C.DYN_UI.DARK },
            { string = localize("k_score"), colour = G.C.PURPLE },
            { string = localize("k_card"),  colour = G.C.FILTER },
            { string = localize("$"), colour = G.C.MONEY },
        }
        local elements = {
            --cycling random operator
            {
                n = G.UIT.O,
                config = {
                    object = DynaText({
                        string = HPR.error_ops,
                        colours = { G.C.DARK_EDITION },
                        pop_in_rate = 9999999,
                        silent = true,
                        random_element = true,
                        pop_delay = 0.3,
                        scale = 0.32,
                        min_cycle_time = 0
                    })
                },
            },
            --cycling random number
            {
                n = G.UIT.O,
                config = {
                    object = DynaText({
                        string = HPR.error_numbers,
                        colours = { G.C.DARK_EDITION },
                        pop_in_rate = 9999999,
                        silent = true,
                        random_element = true,
                        pop_delay = 0.351,
                        scale = 0.32,
                        min_cycle_time = 0
                    })
                },
            },
            --cycling random effect
            {
                n = G.UIT.O,
                config = {
                    object = DynaText({
                        string = error_other,
                        colours = { G.C.UI.TEXT_DARK },
                        pop_in_rate = 9999999,
                        silent = true,
                        random_element = true,
                        pop_delay = 0.299,
                        scale = 0.32,
                        min_cycle_time = 0
                    })
                },
            },
        }
        return {
            vars = { card.ability.extra.uses, elements = elements }
        }
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play or context.forcetrigger then
            local res = pseudorandom("hpr_error_effect", 1, 10)
            if res == 1 then return { xchips = pseudorandom("hpr_error_amt",30,100)/10 } end
            if res == 2 then return { xmult = pseudorandom("hpr_error_amt",30,100)/10 } end
            if res == 3 then return { echips = pseudorandom("hpr_error_amt",110,175)/100 } end
            if res == 4 then return { emult = pseudorandom("hpr_error_amt",120,200)/100 } end
            if res == 5 then return { xscore = pseudorandom("hpr_error_amt",20, 30)/10 } end
            if res == 6 then return { escore = pseudorandom("hpr_error_amt",105,130)/100} end
            if res == 7 then return { xblindsize = pseudorandom("hpr_error_amt",3,9)/10 } end
            if res == 8 then return { eblindsize = pseudorandom("hpr_error_amt",75,95)/100 } end
            if res == 9 then
                local d = pseudorandom("hpr_error_effect", 3, 20)
                G.GAME.dollar_buffer = G.GAME.dollar_buffer + d
                return { dollars = d, func = HPR.event_presets.reset_dollar_buffer }
            end
            if res == 10 then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    local _type = pseudorandom_element({"Consumeables", "Voucher", "Booster"}, "hpr_error_amt")
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event{
                        func = function (n)
                            SMODS.add_card{
                                set = _type,
                                key_append = "hpr_error_card",
                                area = G.consumeables,
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    })
                    return { message = "+1?" }
                else
                    return { message = localize("k_no_room_ex"), no_retrigger = true }
                end
            end
        end
    end,
    attributes = { "xchips", "xmult", "emult", "echips", "xscore", "escore", "xblindsize", "eblindsize", "economy", "generation", "consumable", "voucher", "booster", },
    forcetrigger_compat = true,
}

HPR.StellarJoker {
    key = "observatorium",
    config = { extra = { chips = 0, mult = 0 }},
    forcetrigger_compat = true,
    perishable_compat = false,
    calculate = function (self, card, context)
        if context.hpr_other_modify_hand and context.func then
            local chips = HPR.contains(context.parameters, "chips")
            local mult = HPR.contains(context.parameters, "mult")
            if chips then card.ability.extra.chips = math.max(context.func(card.ability.extra.chips,context.hand_type,"chips",context.levels) or 0, card.ability.extra.chips) end
            if mult then card.ability.extra.mult = math.max(context.func(card.ability.extra.mult,context.hand_type,"mult",context.levels) or 0, card.ability.extra.mult) end
            for _, c in ipairs(G.playing_cards) do
                if chips then c.ability.perma_bonus = math.max(context.func(c.ability.perma_bonus,context.hand_type,"chips",context.levels) or 0, c.ability.perma_bonus) end
                if mult then c.ability.perma_mult = math.max(context.func(c.ability.perma_mult,context.hand_type,"mult",context.levels) or 0, c.ability.perma_mult) end
            end
            if (chips or mult) and not context.instant then
                return { message = localize("k_upgrade_ex") }
            end
        end
        if context.joker_main or context.forcetrigger then
            return {
                chips = card.ability.extra.chips ~= 0 and card.ability.extra.chips or nil,
                mult = card.ability.extra.mult ~= 0 and card.ability.extra.mult or nil
            }
        end
    end,
    attributes = { "space", "chips", "mult", "modify_card", "full_deck", },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.asc }}
    end,
}

HPR.StellarJoker {
    key = "master",
    forcetrigger_compat = true,
    config = { extra = { multiuse = 1, uses = 0 } },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.multiuse, card.ability.extra.uses }}
    end,
    calculate = function (self, card, context)
        if context.ending_shop then
            G.E_MANAGER:add_event(Event{ --event to account for stuff created in events before this joker
                func = function (n)
                    for _, c in ipairs(G.consumeables.cards) do
                        c.ability.cry_multiuse = (c.ability.cry_multiuse or 1) + card.ability.extra.multiuse
                    end
                    return true
                end
            })
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "uses",
                scalar_value = "multiuse",
            })
            return nil, true
        end
    end,
    can_use = function (self, card)
        local cards = Spectrallib.get_highlighted_cards({ G.shop_vouchers, G.shop_booster }, card, 1, 1)
        return #cards == 1 and card.ability.extra.uses > 0 and G.consumeables.config.card_limit > #G.consumeables.cards
    end,
    use = function (self, card)
        card.ability.extra.uses = card.ability.extra.uses - 1
        local cards = Spectrallib.get_highlighted_cards({ G.shop_vouchers, G.shop_booster }, card, 1, 1)
        local c = cards[1]
        SMODS.copy_card(c, {
            area = G.consumeables
        })
    end,
    attributes = { "multiuse", "vouchers", "booster", "scaling", "consumable", },
}

HPR.StellarJoker {
    key = "potassium",
    forcetrigger_compat = true,
    config = { extra = { odds1 = 6 }},
    loc_vars = function (self, info_queue, card)
        local e = card.ability.extra
        local numerator, denominator = SMODS.get_probability_vars(card, 1, e.odds1, self.key)
        return { vars = { numerator, denominator }}
    end,
    calculate = function (self, card, context)
        if context.destroy_card and not context.blueprint and context.cardarea == G.play and SMODS.pseudorandom_probability(card, self.key, 1, card.ability.extra.odds1) then
            return { destroy = true }
        end
        if context.individual and context.cardarea == G.play and next(SMODS.get_enhancements(context.other_card)) then
            return {
                func = function ()
                    for c in Spectrallib.iter.areacards(G.jokers) do
                        if c:has_attribute("food") then
                            Spectrallib.forcetrigger {
                                card = c,
                                context = context,
                                colour = G.C.RARITY.hpr_stellar,
                            }
                        end
                    end
                end
            }
        end
        if context.scaling_card and context.card:has_attribute("food") then
            if context.operation == "+" or context.operation == "-" or not context.operation then
                return {
                    override_scalar = -context.scalar,
                    override_message = {
                        message = localize("k_upgrade_ex")
                    }
                }
            elseif context.operation == "X" then
                return {
                    override_scalar = 1/context.scalar,
                    override_message = {
                        message = localize("k_upgrade_ex")
                    }
                }
            end
        end
    end,
    attributes = { "destroy_card", "chance", "food", "forcetrigger", "enhancements", },
}

HPR.StellarJoker {
    key = "crazy",
    pos = { x = 3, y = 0 },
    soul_pos = {
        x = 4, y = 0,
        extra = { x = 5, y = 0 }
    },
    config = { extra = { mult = 0.1 }},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.mult }}
    end,
    calculate = function (self, card, context)
        if context.before and not context.blueprint then
            local hands = {}
            for k, hand in pairs(context.poker_hands) do
                if next(hand) then hands[#hands+1] = k end
            end
            local count = #hands
            local m = 1 + card.ability.extra.mult*count
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.MULT,
                func = function ()
                    SMODS.upgrade_poker_hands{
                        from = card,
                        parameters = {"mult"},
                        level_up = false,
                        hands = hands,
                        StatusText = "X"..number_format(m),
                        func = function (base, hand, param)
                            return base * m
                        end
                    }
                end
            }
        end
    end,
    attributes = { "hand_type", },
    hpr_badge_info = {
        { key = "credits_code", vars = {"Eris"} },
        { key = "credits_art", vars = {"Eris"}},
        { key = "credits_idea", vars = {"Eris"}},
    },
}

HPR.StellarJoker {
    key = "crafty",
    pos = { x = 6, y = 0 },
    soul_pos = {
        x = 7, y = 0,
        extra = { x = 8, y = 0 }
    },
    config = { extra = { chips = 0.1 }},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.chips }}
    end,
    calculate = function (self, card, context)
        if context.before and not context.blueprint then
            local hands = {}
            for k, hand in pairs(context.poker_hands) do
                if next(hand) then hands[#hands+1] = k end
            end
            local count = #hands
            local m = 1+card.ability.extra.chips*count
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.MULT,
                func = function ()
                    SMODS.upgrade_poker_hands{
                        from = card,
                        parameters = {"chips"},
                        level_up = false,
                        hands = hands,
                        StatusText = "X"..number_format(m),
                        func = function (base, hand, param)
                            return base * m
                        end
                    }
                end
            }
        end
    end,
    attributes = { "hand_type", },
    hpr_badge_info = {
        { key = "credits_code", vars = {"Eris"} },
        { key = "credits_art", vars = {"Eris"}},
        { key = "credits_idea", vars = {"Eris"}},
    },
}

HPR.StellarJoker {
    key = "storm",
    calculate = function (self, card, context)
        if context.modify_scoring_hand and not context.blueprint then
            return { add_to_hand = true }
        end
        if context.repetition then
            return { repetitions = 1 }
        end
    end,
    attributes = { "passive", "retrigger", },
}
--[[
HPR.StellarJoker {
    key = "straightaway",
    config = { extra = { xmult = 1, gain = 0.15, gain_gain = 0.05 }},
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
        return { vars = { card.ability.extra.xmult, card.ability.extra.gain, card.ability.extra.gain_gain }}
    end,
    calculate = function (self, card, context)
        if context.before or context.forcetrigger then
            local b
            if context.forcetrigger or context.poker_hands and next(context.poker_hands["Straight Flush"]) then
                b=true
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "gain",
                    scalar_value = "gain_gain"
                })
                if G.GAME.consumeable_buffer + #G.consumeables.cards < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event{
                        func = function ()
                            G.GAME.consumeable_buffer = 0
                            SMODS.add_card{
                                set = "Voucher",
                                area = G.consumeables,
                                key_append = "hpr_straightaway_voucher"
                            }
                            return true
                        end
                    })
                    SMODS.calculate_effect({ message = localize("k_hpr_plus_voucher") }, card)
                end
            end
            if context.forcetrigger or context.poker_hands and next(context.poker_hands["Straight"]) then
                b=true
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "xmult",
                    scalar_value = "gain",
                    message_key = "a_xmult",
                    message_colour = G.C.MULT
                })
                G.E_MANAGER:add_event(Event{
                    func = function ()
                        SMODS.add_card({
                            set = "Consumeables",
                            edition = "e_negative",
                            key_append = "hpr_straightaway_cons"
                        })
                        return true
                    end
                })
                SMODS.calculate_effect({ message = localize("k_hpr_plus_consumable") }, card)
            end
            if b and not context.forcetrigger then return nil, true end
        end
        if (context.joker_main or context.forcetrigger) and card.ability.extra.xmult ~= 1 then
            return { xmult = card.ability.extra.xmult }
        end
    end,
    attributes = { "hand_type", "generation", "scaling", "xmult", },
    forcetrigger_compat = true,
}
]]
HPR.StellarJoker {
    key = "void",
    config = { extra = { xmult_per = 0.25, emult_per = 0.05 }},
    loc_vars = function (self, info_queue, card)
        local e, x = 1, 1
        if G.playing_cards then
            x = 1 + (G.GAME.starting_deck_size - #G.playing_cards)*card.ability.extra.xmult_per
            x = math.max(x, 1)
            local empty = 0
            empty = empty + math.max(G.consumeables.config.card_limit - (G.GAME.consumeable_buffer + #G.consumeables.cards), 0)
            empty = empty + math.max(G.jokers.config.card_limit - (G.GAME.joker_buffer + #G.jokers.cards), 0)
            empty = empty + math.max(G.GAME.starting_params.play_limit - (G.STATE == G.STATES.HAND_PLAYED and #G.play.cards or #G.hand.highlighted), 0)
            e = 1 + card.ability.extra.emult_per*empty
            e = math.max(e, 1)
        end
        return { vars = {card.ability.extra.xmult_per, x, G.GAME.starting_deck_size or 52, card.ability.extra.emult_per, e,} }
    end,
    calculate = function (self, card, context)
        if context.joker_main or context.forcetrigger then
            local e, x = 1, 1
            x = 1 + (G.GAME.starting_deck_size - #G.playing_cards)*card.ability.extra.xmult_per
            x = math.max(x, 1)
            local empty = 0
            empty = empty + math.max(G.consumeables.config.card_limit - (G.GAME.consumeable_buffer + #G.consumeables.cards), 0)
            empty = empty + math.max(G.jokers.config.card_limit - (G.GAME.joker_buffer + #G.jokers.cards), 0)
            empty = empty + math.max(G.GAME.starting_params.play_limit - (G.STATE == G.STATES.HAND_PLAYED and #G.play.cards or #G.hand.highlighted), 0)
            e = 1 + card.ability.extra.emult_per*empty
            e = math.max(e, 1)
            if x~=1 or e~=1 then
                return { xmult = x~=1 and x or nil, extra = e~=1 and { emult = e } or nil }
            end
        end
    end,
    attributes = { "emult", "xmult", "joker_slot", "consumable_slot", },
    forcetrigger_compat = true,
}

HPR.StellarJoker {
    key = "shorthand",
    blueprint_compat = false,
    config = { extra = { csl = 999, h_size = 10 } },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.csl, card.ability.extra.h_size }}
    end,
    add_to_deck = function (self, card, from_debuff)
        Spectrallib.change_selection_limit(card.ability.extra.csl)
        G.hand:change_size(card.ability.extra.h_size)
    end,
    remove_from_deck = function (self, card, from_debuff)
        Spectrallib.change_selection_limit(-card.ability.extra.csl)
        G.hand:change_size(-card.ability.extra.h_size)
    end,
    calculate = function (self, card, context)
        if context.debuff_card then
            return { prevent_debuff = true, no_retrigger = true }
        end
        if context.stay_flipped then
            return { prevent_stay_flipped = true, no_retrigger = true }
        end
    end,
    attributes = { "passive", "hand_size", },
}

HPR.StellarJoker {
    key = "prideful",
    config = { extra = 1 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra }}
    end,
    calculate = function (self, card, context)
        if context.first_hand_drawn and not context.blueprint then
            local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        if context.before and G.GAME.current_round.hands_played == 0 then
            local suit_tbl = {}
            for _, c in ipairs(context.full_hand) do
                for _, suit in ipairs(SMODS.Suit.obj_buffer) do
                    if not suit_tbl[suit] and c:is_suit(suit) then suit_tbl[suit] = true end
                end
                if not suit_tbl.suitless and Spectrallib.true_suitless(c) then suit_tbl.suitless = true end
            end
            return {
                message = localize("k_level_up_ex"),
                func = function ()
                    for k in pairs(suit_tbl) do
                        Spectrallib.level_suit(k, card, 1, 0, card.ability.extra, nil, true)
                    end
                end
            }
        end
        if context.repetition then
            local lv_total = 0
            for _, suit in ipairs(SMODS.Suit.obj_buffer) do
                if context.other_card:is_suit(suit) then
                    lv_total = lv_total + (Spectrallib.safe_get(G.GAME.SuitBuffs, suit, "level") or 0)
                end
            end
            if Spectrallib.true_suitless(context.other_card) then
                lv_total = lv_total + G.GAME.SuitBuffs.suitless.level
            end
            local reps = math.floor(math.log(lv_total))
            if reps>0 then
                return {
                    repetitions = reps
                }
            end
        end
    end,
    attributes = { "mult", "suit_level", "retrigger", "hands", }
}

HPR.StellarJoker {
    key = "prism",
    config = { extra = { dollars = 0, xmult = 2, d_gain = 1 }},
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_wild
        local suit = G.GAME.current_round.hpr_prism_suit or "Spades"
        return { vars = { card.ability.extra.dollars, card.ability.extra.d_gain, card.ability.extra.xmult, localize(suit, "suits_singular"), colours = { G.C.SUITS[suit] } }}
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit(G.GAME.current_round.hpr_prism_suit) then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "dollars",
                scalar_value = "d_gain",
                message_colour = G.C.MONEY,
            })
            return {
                xmult = card.ability.extra.xmult
            }
        end
        if context.modify_scoring_hand and SMODS.has_enhancement(context.other_card, "m_wild") then
            return { add_to_hand = true }
        end
    end,
    calc_dollar_bonus = function (self, card)
        if card.ability.extra.dollars ~= 0 then
            local d = card.ability.extra.dollars
            SMODS.reset_card(card, {
                ref_table = card.ability.extra,
                ref_value = "dollars",
                reset_value = 0,
            })
            return d
        end
    end,
    attributes = { "scaling", "economy", "xmult", "reset", }
}

--[[
HPR.StellarJoker {
    key = "diamond",
    pos = { x = 0, y = 1 },
    soul_pos = {
        x = 1, y = 1,
        extra = { x = 2, y = 1 },
    },
    config = { extra = { mult = 1.5, dollars = 2 }},
    loc_vars = function (self, info_queue, card)
        local count = 0
        if G.playing_cards then
            for _, c in ipairs(G.playing_cards) do
                if c:is_suit("Diamonds") then count = count + 1 end
            end
        end
        return { vars = { card.ability.extra.mult, card.ability.extra.dollars, count * card.ability.extra.dollars }}
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit("Diamonds") then
            return {
                xmult = card.ability.extra.mult
            }
        end
    end,
    calc_dollar_bonus = function (self, card)
        local count = 0
        for _, c in ipairs(G.playing_cards) do
            if c:is_suit("Diamonds") then count = count + 1 end
        end
        if count > 0 then
            return count * card.ability.extra.dollars
        end
    end,
    attributes = { "economy", "suit", "diamonds", "xmult", },
}

HPR.StellarJoker {
    key = "heart",
    pos = { x = 3, y = 1 },
    soul_pos = {
        x = 4, y = 1,
        extra = { x = 5, y = 1 }
    },
    config = { extra = { odds = 3, xmult = 1.5, emult = 1.1 }},
    loc_vars = function (self, info_queue, card)
        local n,d = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, self.key)
        return { vars = { n, d, card.ability.extra.xmult, card.ability.extra.emult }}
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit("Hearts") or context.forcetrigger then
            if SMODS.pseudorandom_probability(card, self.key, 1, card.ability.extra.odds) then
                return { emult = card.ability.extra.emult }
            else
                return { xmult = card.ability.extra.xmult }
            end
        end
    end,
    attributes = { "emult", "xmult", "chance", "suit", "hearts" },
    forcetrigger_compat = true,
}

HPR.StellarJoker {
    key = "spade",
    pos = { x = 6, y = 1 },
    soul_pos = {
        x = 7, y = 1,
        extra = { x = 8, y = 1 }
    },
    config = { extra = { mult = 4, chips = 30, xstuff = 1.25 }},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.xstuff }}
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit("Spades") then
            context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra.mult
            context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + card.ability.extra.chips
            return {
                message = localize("k_upgrade_ex"),
                extra = {
                    xchips = card.ability.extra.xstuff,
                    xmult = card.ability.extra.xstuff
                }
            }
        end
    end,
    attributes = { "mult", "chips", "xmult", "xchips", "suit", "spades", "modify_card", },
}

HPR.StellarJoker {
    key = "club",
    pos = { x = 9, y = 1 },
    soul_pos = {
        x = 10, y = 1,
        extra = { x = 11, y = 1 }
    },
    config = { extra = { chips = 10, mult = 1, xmult = 1.5 }},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.xmult }}
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit("Clubs") then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        if context.before then
            local b = false
            for _, c in ipairs(context.full_hand) do
                if c:is_suit("Clubs") then
                    b = true
                    SMODS.calculate_effect({ message = localize("k_level_up_ex"), message_card = c }, card)
                    Spectrallib.level_suit("Clubs", card, 1, card.ability.extra.chips, card.ability.extra.mult, nil, true)
                end
            end
            if b then return nil, true end
        end
    end,
    attributes = { "xmult", "suit", "clubs", },
}

HPR.StellarJoker {
    key = "wild",
    config = { extra = 2 },
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_wild
        info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
        local suit = (G.GAME.current_round.ancient_card or {}).suit or "Spades"
        return { vars = { card.ability.extra, localize(suit, "suits_singular"), colours = {G.C.SUITS[suit]}}}
    end,
    calculate = function (self, card, context)
        if context.before then
            for _, c in ipairs(context.full_hand) do
                if c:is_suit(G.GAME.current_round.ancient_card.suit) then
                    c:set_ability("m_wild", nil, true)
                    c:set_edition("e_polychrome", nil, nil, true)
                end
            end
        end
        if context.individual and context.cardarea == G.play and context.other_card:is_suit(G.GAME.current_round.ancient_card.suit) or context.forcetrigger then
            return { xmult = card.ability.extra }
        end
    end,
    attributes = { "xmult", "enhancements", "suit", },
    forcetrigger_compat = true,
}
]]
HPR.StellarJoker {
    key = "conjurer",
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = { set = "Edition", key = "e_negative_playing_card", config = { extra = 1 } }
    end,
    calculate = function (self, card, context)
        if context.before then
            if #context.full_hand == 1 then
                local card_copied = SMODS.copy_card(context.full_hand[1], { area = G.hand })
                card_copied:set_edition("e_negative", true, true)
                card_copied.states.visible = nil

                G.E_MANAGER:add_event(Event({
                    func = function()
                        card_copied:start_materialize()
                        return true
                    end
                }))
                return {
                    message = localize('k_copied_ex'),
                    colour = G.C.DARK_EDITION,
                    func = function() -- This is for timing purposes, it runs after the message
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                SMODS.calculate_context({ playing_card_added = true, cards = { card_copied } })
                                return true
                            end
                        }))
                    end
                }
            else
                local did_stuff = false
                for c in Spectrallib.iter.areacards(context.scoring_hand) do
                    local this_did_stuff = false
                    if c.config.center_key == "c_base" then
                        did_stuff, this_did_stuff = true, true
                        c:set_ability(SMODS.poll_enhancement{ guaranteed = true, type_key = "hpr_conjurer_enh" }, nil, true)
                    end
                    if not c.seal then
                        did_stuff, this_did_stuff = true, true
                        c:set_seal(SMODS.poll_seal{ guaranteed = true, type_key = "hpr_conjurer_seal" })
                    end
                    if not c.edition then
                        did_stuff, this_did_stuff = true, true
                        c:set_edition(SMODS.poll_edition{ guaranteed = true, type_key = "hpr_conjurer_ed", no_negative = true, })
                    end
                    if this_did_stuff then
                        G.E_MANAGER:add_event(Event{
                            func = function (n)
                                c:juice_up()
                                return true
                            end
                        })
                    end
                end
                if did_stuff then
                    return {
                        message = localize("k_enhanced_ex"),
                        colour = G.C.DARK_EDITION,
                        no_retrigger = true,
                    }
                end
            end
        end
    end,
    attributes = { "generation", "playing_card", "editions", "enhancements", "seals", "modify_card" },
    forcetrigger_compat = true,
}

HPR.StellarJoker {
    key = "circus",
    config = { extra = 1 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra } }
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit_shade("dark") then
            return {
                message = localize{type = "variable", key = "a_discards", vars = {card.ability.extra}},
                func = function ()
                    ease_discard(card.ability.extra)
                end,
                colour = G.C.RED
            }
        end
        if context.discard and context.other_card:is_suit_shade("light") then
            return {
                message = localize{type = "variable", key = "a_hands", vars = {card.ability.extra}},
                func = function ()
                    ease_hands_played(card.ability.extra)
                end,
                colour = G.C.BLUE
            }
        end
        if context.before then
            return {
                message = localize{ type = "variable", key = "a_handsize", vars = { card.ability.extra }},
                func = function ()
                    G.E_MANAGER:add_event(Event{
                        func = function ()
                            G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + card.ability.extra
                            G.hand:change_size(card.ability.extra)
                            return true
                        end,
                    })
                end
            }
        end
    end,
    attributes = { "hand_size", "hands", "discard", "suit", },
    blueprint_compat = false,
}

HPR.StellarJoker {
    key = "unity",
    pos = { x = 9, y = 0 },
    soul_pos = {
        x = 10, y = 0,
        --extra = { x = 11, y = 0 }
    },
    config = { extra = { swap_portion = 0.05, echult = 1.25, }},
    loc_vars = function (self, info_queue, card)
        return { vars = { Spectrallib.clamp(card.ability.extra.swap_portion, 0, 1)*100, card.ability.extra.echult }}
    end,
    forcetrigger_compat = true,
    calculate = function (self, card, context)
        if context.joker_main or (context.forcetrigger and context.poker_hands) then
            local hands = 0
            for _, hand in pairs(context.poker_hands) do
                if next(hand) then hands = hands + 1 end
            end
            local val = Spectrallib.clamp(card.ability.extra.swap_portion*hands, 0, 1)
            if val > 0 then
                return {
                    cry_broken_swap = val,
                }
            end
        end
        if context.end_of_round and context.main_eval and G.GAME.hands[G.GAME.last_hand_played] then
            local mul = card.ability.extra.echult
            local h = G.GAME.last_hand_played
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.MULT,
                func = function ()
                    SMODS.upgrade_poker_hands{
                        from = card,
                        hands = h,
                        parameters = {"mult"},
                        StatusText = function (hand, parameter)
                            local ret = {
                                text = "^"..number_format(mul),
                            }
                            if parameter == "chips" then
                                ret.cover_colour = Spectrallib.echips
                            elseif parameter == "mult" then
                                ret.cover_colour = Spectrallib.emult
                            end
                            return ret
                        end,
                        level_up = false,
                        func = function (base, hand, param, level_up)
                            return base^mul
                        end,
                    }
                end
            }
        end
    end,
    attributes = { "swap", "hand_type", },
    hpr_badge_info = {
        { key = "credits_code", vars = {"Eris"} },
        { key = "credits_art", vars = {"Eris"}},
        { key = "credits_idea", vars = {"Eris"}},
    },
}

HPR.StellarJoker {
    key = "royalty",
    config = { extra = { xmult = 2, dollar = 3, reps = 3 }},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.dollar, card.ability.extra.reps } }
    end,
    forcetrigger_compat = true,
    calculate = function (self, card, context)
        if context.individual and not context.end_of_round and not context.other_card.debuff then
            local id = context.other_card:get_id()
            if context.cardarea == G.discard and (id == 11) then
                return { xmult = card.ability.extra.xmult }
            end
            if context.cardarea == G.hand and (id == 12) then
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollar
                return {
                    dollars = card.ability.extra.dollar,
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.GAME.dollar_buffer = 0
                                return true
                            end
                        }))
                    end
                }
            end
        end
        if context.repetition and context.cardarea == G.play then
            local id = context.other_card:get_id()
            if id == 13 then
                return { repetitions = card.ability.extra.reps }
            end
        end
        if context.forcetrigger then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollar
            return {
                dollars = card.ability.extra.dollar,
                xmult = card.ability.extra.xmult,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }
        end
    end,
    attributes = { "xmult", "econ", "face", "retrigger", "king", "queen", "jack", },
}

HPR.StellarJoker {
    key = "numeric",
    config = { extra = { xchips = 1.25, gain = 0.05, } },
    loc_vars = function (self, iq, card)
        return { vars = { card.ability.extra.xchips, card.ability.extra.gain }}
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and not context.other_card:is_face() then
            return {
                xchips = card.ability.extra.xchips
            }
        end
        if context.before then
            local check = true
            for v in Spectrallib.iter.areacards(context.scoring_hand) do
                if not ({[2]=true,[3]=true,[5]=true,[7]=true,[14]=true})[v:get_id()] then
                    check = false
                    break
                end
            end
            if check then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "xchips",
                    scalar_value = "gain",
                    scalar_factor = #context.scoring_hand,
                    message_key = "a_xchips",
                })
            end
        end
    end,
    attributes = { "xchips", "scaling", "two", "three", "five", "seven", "ace", },
}

HPR.StellarJoker {
    key = "payload",
    config = { extra = { portion = 0.1, scale = 0.05 } },
    calc_dollar_bonus = function (self, card)
        local amt = math.floor(G.GAME.dollars*card.ability.extra.portion)
        SMODS.reset_card(card, {
            ref_table = card.ability.extra,
            ref_value = "portion",
            reset_value = 0.1,
        })
        if amt > 0 then return amt end
    end,
    loc_vars = function (self, info_queue, card)
        local rank_loc = localize(G.GAME.current_round.hpr_payload_rank or "Ace", "ranks")
        return { vars = { card.ability.extra.portion*100, card.ability.extra.scale*100, rank_loc }}
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == (SMODS.Ranks[G.GAME.current_round.hpr_payload_rank] or {}).id then
            return {
                func = function ()
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "portion",
                        scalar_value = "scale",
                        message_colour = G.C.MONEY,
                    })
                end
            }
        end
    end,
    forcetrigger = function (self, card, context)
        local d = math.floor(G.GAME.dollars*card.ability.extra.portion)
        if d ~= 0 then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + d
            return { dollars = d, func = HPR.event_presets.reset_dollar_buffer }
        end
    end,
    attributes = { "economy", "scaling", "rank", },
    blueprint_compat = true,
}

HPR.StellarJoker {
    key = "destroyer",
    config = { extra = { emult = 1, emult_mod = 0.04, }},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.emult, card.ability.extra.emult_mod }}
    end,
    calculate = function (self, card, context)
        if (context.setting_blind) and not context.blueprint and card.area and card.rank then
            local target = card.area.cards[card.rank+1]
            if target and not SMODS.is_eternal(target, card) and not target.getting_sliced then
                target.getting_sliced = true
                G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                G.E_MANAGER:add_event(Event {
                    func = function()
                        G.GAME.joker_buffer = 0
                        SMODS.scale_card(card, {
                            ref_table = card.ability.extra,
                            ref_value = "emult",
                            scalar_value = "emult_mod",
                            scalar_factor = target.sell_cost,
                            message_key = "a_powmult",
                        })
                        target:start_dissolve({ G.C.HPR_STLR }, nil, 1.6)
                        play_sound('slice1', 0.96 + math.random() * 0.08)
                        return true
                    end
                })
                if not context.forcetrigger then
                    return nil, true
                end
            end
        end
        if (context.joker_main or context.forcetrigger) and card.ability.extra.emult ~= 1 then
            return {
                emult = card.ability.extra.emult,
            }
        end
    end,
    attributes = { "destroy_card", "emult", "scaling", "position", },
    forcetrigger_compat = true,
}

HPR.StellarJoker {
    key = "ascendant",
    config = { extra = { xchips = 0.05, dollars = 3, } },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.xchips, card.ability.extra.dollars }}
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play then
            context.other_card.ability.perma_x_chips = context.other_card.ability.perma_x_chips + card.ability.extra.xchips
            return { message = localize("k_upgrade_ex"), colour = G.C.BLUE }
        end
        if context.individual and context.end_of_round and context.cardarea == G.hand then
            context.other_card.ability.perma_p_dollars = context.other_card.ability.perma_p_dollars + card.ability.extra.dollars
            return { message = localize("k_upgrade_ex"), colour = G.C.MONEY }
        end
        if context.before and #context.full_hand == 1 and G.GAME.current_round.hands_played == 0 then
            local c = context.full_hand[1]
            c.ability.perma_repetitions = c.ability.perma_repetitions + 1
            return {
                message = localize("k_upgrade_ex"),
                message_card = c
            }
        end
        if context.first_hand_drawn and not context.blueprint then
            local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
    end,
    attributes = { "modify_card", "retrigger", "economy", "xchips", "perma_bonus", },
}

HPR.StellarJoker {
    key = "mimic",
    config = { extra = { rep = 1, scale = 1 } },
    loc_vars = function (self, info_queue, card)
        local n,d = SMODS.get_probability_vars(card, 1, card.ability.extra.rep, self.key)
        return { vars = { card.ability.extra.rep, card.ability.extra.scale, n, d }}
    end,
    calculate = function (self, card, context)
        if context.retrigger_joker_check and not context.retrigger_joker and card.area and card.rank then
            if context.other_card == card.area.cards[card.rank+1] then
                return { repetitions = card.ability.extra.rep }
            end
        end
        if context.end_of_round and context.main_eval and SMODS.pseudorandom_probability(card, self.key, 1, card.ability.extra.rep) then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "rep",
                scalar_value = "scale",
            })
            return nil, true
        end
    end,
    attributes = { "retrigger", "joker", "chance", "scaling", },
}

HPR.StellarJoker {
    key = "lucky",
    config = { extra = { crit_rate = 0.3 }, },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.crit_rate * 100 }}
    end,
    calculate = function (self, card, context)
        if context.mod_probability then
            return { numerator = context.numerator * 2 }
        end
        if context.fix_probability and card.rank and card.area and context.trigger_obj and Card.is(context.trigger_obj, Card) and context.trigger_obj.area == card.area then
            if context.trigger_obj.rank < card.rank then
                return { numerator = 0 }
            elseif context.trigger_obj.rank > card.rank then
                return { numerator = context.denominator }
            end
        end
    end,
    attributes = { "mod_chance", },
}

HPR.StellarJoker {
    key = "guardian",
    config = { extra = { active = true, hands = 1, emult = 1, emult_gain = 0.1 }},
    loc_vars = function (self, info_queue, card)
        return { vars = { localize(card.ability.extra.active and "k_active" or "k_inactive"), card.ability.extra.hands, card.ability.extra.emult, card.ability.extra.emult_gain }}
    end,
    calculate = function (self, card, context)
        if context.ante_change and SMODS.ante_end then
            card.ability.extra.active = true
        end
        if context.game_over and card.ability.extra.active and not context.blueprint and context.main_eval then
            card.ability.extra.active = false
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.hand_text_area.blind_chips:juice_up()
                    G.hand_text_area.game_chips:juice_up()
                    play_sound('tarot1')
                    G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands --no ease hands played because your hands are getting reset anyway
                    return true
                end
            }))
            return {
                message = localize("k_blessed_ex"),
                saved = "ph_hpr_stellar_revive",
                colour = G.C.RARITY.hpr_stellar
            }
        end
        if context.before then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "emult",
                scalar_value = "emult_gain",
                no_message = true,
            })
        end
        if context.end_of_round and context.main_eval and not context.blueprint and not context.retrigger_joker and card.ability.extra.emult ~= 1 then
            SMODS.reset_card(card, {
                ref_table = card.ability.extra,
                ref_value = "emult",
                reset_value = 1,
            })
            return { no_retrigger = true }
        end
        if context.joker_main then
            return {
                emult = card.ability.extra.emult
            }
        end
        if context.skip_blind and not context.blueprint and not context.retrigger_joker then
            card.ability.extra.active = false
            return {
                message = localize("k_disabled_ex")
            }
        end
    end,
    forcetrigger = function (self, card, context)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
        ease_hands_played(card.ability.extra.hands)
        return { emult = card.ability.extra.emult }
    end,
    attributes = { "prevents_death", "hands", "emult", "scaling", "reset", },
    forcetrigger_compat = true,
    blueprint_compat = false,
}

HPR.StellarJoker {
    key = "buffoon",
    config = { extra = { bonus_effects = 1, gain = 1, }},
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra.bonus_effects, card.ability.extra.gain} }
    end,
    calculate = function (self, card, context)
        if context.setting_blind then
            local jokers_to_create = G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer)
            if jokers_to_create > 0 then
                G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
                local buffs_to_give = card.ability.extra.bonus_effects
                G.E_MANAGER:add_event(Event({
                    func = function()
                        for _ = 1, jokers_to_create do
                            local c = SMODS.add_card {
                                set = 'Joker',
                                key_append = 'hpr_buffoon_card',
                            }
                            for i = 1, buffs_to_give do
                                local key, config = HPR.poll_buffoon_effect()
                                Spectrallib.add_bonus_effect(c, key, config)
                            end
                            G.GAME.joker_buffer = 0
                        end
                        return true
                    end
                }))
            end
        end
        if context.end_of_round and context.main_eval and context.beat_boss then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "bonus_effects",
                scalar_value = "gain",
            })
            return nil, true
        end
    end,
    attributes = { "joker", "modify_card", "generation" },
}

HPR.StellarJoker {
    key = "hunter",
    config = { extra = { xblindsize = 0.2, tags = 6, } },
    forcetrigger_compat = true,
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.xblindsize, card.ability.extra.tags }}
    end,
    calculate = function (self, card, context)
        if (context.setting_blind or context.forcetrigger) and not context.blueprint then
            if context.blind.boss and not context.forcetrigger then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.GAME.blind:disable()
                                play_sound('timpani')
                                delay(0.4)
                                return true
                            end
                        }))
                        SMODS.calculate_effect({ message = localize('ph_boss_disabled') }, card)
                        return true
                    end
                }))
                return nil, true
            else
                return {
                    xblindsize = card.ability.extra.xblindsize,
                }
            end
        end
        if context.round_eval and G.GAME.last_blind and G.GAME.last_blind.boss then
            for _ = 1, card.ability.extra.tags do
                G.E_MANAGER:add_event(Event({
                    func = function()
                        add_tag({ key = SMODS.poll_object { type = "Tag", seed = "hpr_hunter_tag", } })
                        play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                        return true
                    end
                }))
            end
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        if G.GAME.blind and G.GAME.blind.in_blind and not G.GAME.blind.disabled then
            if G.GAME.blind.boss then
                G.GAME.blind:disable()
                play_sound('timpani')
                SMODS.calculate_effect({ message = localize('ph_boss_disabled') }, card)
            else
                SMODS.calculate_effect({ xblindsize = card.ability.extra.xblindsize }, card)
            end
        end
    end,
    attributes = { "generation", "tags", "boss_blind", "xblindsize", }, --this one def needs a rework but whatever 
}

HPR.StellarJoker {
    key = "boosted",
    blueprint_compat = false,
    config = { extra = { b_size = 0, gain = 1, uses = 0, use_mod = 1, max_highlighted = 5, } },
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.p_hpr_universe
        return { vars = { card.ability.extra.b_size, card.ability.extra.gain, card.ability.extra.uses, card.ability.extra.use_mod, card.ability.extra.max_highlighted }}
    end,
    calculate = function (self, card, context)
        if context.skipping_booster and context.booster.kind == "hpr_universe" and not context.blueprint then
            G.GAME.modifiers.booster_size_mod = (G.GAME.modifiers.booster_size_mod or 0) - card.ability.extra.b_size
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "b_size",
                scalar_value = "gain",
            })
            G.GAME.modifiers.booster_size_mod = (G.GAME.modifiers.booster_size_mod or 0) + card.ability.extra.b_size
            return nil, true
        end
        if context.end_of_round and context.main_eval and context.beat_boss then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "uses",
                scalar_value = "use_mod",
                no_message = true
            })
            return {
                message = "+"..card.ability.extra.use_mod
            }
        end
    end,
    add_to_deck = function (self, card, from_debuff)
        G.GAME.modifiers.booster_size_mod = (G.GAME.modifiers.booster_size_mod or 0) + card.ability.extra.b_size
    end,
    remove_from_deck = function (self, card, from_debuff)
        G.GAME.modifiers.booster_size_mod = (G.GAME.modifiers.booster_size_mod or 0) - card.ability.extra.b_size
    end,
    can_use = function (self, card)
        if card.ability.extra.uses <= 0 then
            return false
        end
        local areas = { G.hand, G.jokers, G.consumeables, }
        areas[#areas+1] = G.shop_jokers
        areas[#areas+1] = G.shop_booster
        areas[#areas+1] = G.shop_vouchers
        areas[#areas+1] = G.pack_cards
        local function blacklist(c)
            return Spectrallib.safe_get(c, "config", "center", "kind") ~= "hpr_universe"
        end
        local cards = Spectrallib.get_highlighted_cards(areas, card, 1, card.ability.extra.max_highlighted, blacklist)
        return #cards > 0 and #cards <= card.ability.extra.max_highlighted
    end,
    use = function (self, card)
        card.ability.extra.uses = card.ability.extra.uses - 1
        local areas = { G.hand, G.jokers, G.consumeables, }
        areas[#areas+1] = G.shop_jokers
        areas[#areas+1] = G.shop_booster
        areas[#areas+1] = G.shop_vouchers
        areas[#areas+1] = G.pack_cards
        local function blacklist(c)
            return Spectrallib.safe_get(c, "config", "center", "kind") ~= "hpr_universe"
        end
        local cards = Spectrallib.get_highlighted_cards(areas, card, 1, card.ability.extra.max_highlighted, blacklist)
        for _, c in ipairs(cards) do
            local t = {
                edition = c.edition and c.edition.key or nil,
                seal = c.seal,
                key = c.config.center_key,
                set = c.ability.set,
                no_edition = true,
                rank = c.base and c.base.value or nil,
                suit = c.base and c.base.suit or nil,
            }
            for k in pairs(SMODS.Stickers) do
                if c.ability[k] or (k == "pinned" and c.pinned) then
                    t.stickers = t.stickers or {}
                    t.stickers[#t.stickers+1] = k
                    t.force_stickers = true
                end
            end
            G.GAME.hpr_universe_pack_pool[#G.GAME.hpr_universe_pack_pool+1] = t
        end
        card:juice_up()
    end,
    attributes = { "booster", }
}

HPR.StellarJoker {
    key = "enchant",
    config = { extra = { emult_per = 0.05, percent = 0.2 } },
    loc_vars = function (self, info_queue, card)
        local enh_key, tied, tied_count, highest = nil, false, 1, 0
        if G.playing_cards then
            local enh_table = {}
            for _, v in ipairs(G.playing_cards) do
                for k in pairs(SMODS.get_enhancements(v)) do
                    enh_table[k] = (enh_table[k] or 0) + 1
                end
            end
            for k, v in pairs(enh_table) do
                if v > highest then
                    enh_key = k
                    highest = v
                    tied_count = 1
                    tied = false
                elseif v == highest then
                    tied = true
                    tied_count = tied_count + 1
                end
            end
        end
        local loc = tied and localize{ type = "variable", key = "n_way_tie", vars = {tied_count} } or enh_key and localize{ type = "name_text", set = "Enhanced", key = enh_key } or localize("k_none")
        return { vars = { card.ability.extra.emult_per, loc, 1 + card.ability.extra.emult_per*highest, Spectrallib.clamp(card.ability.extra.percent,0,1)*100 }}
    end,
    calculate = function (self, card, context)
        if context.joker_main then
            local enh_table = {}
            for _, v in ipairs(G.playing_cards) do
                for k in pairs(SMODS.get_enhancements(v)) do
                    enh_table[k] = (enh_table[k] or 0) + 1
                end
            end
            local highest = 0
            for _, v in pairs(enh_table) do
                highest = math.max(highest, v)
            end
            if highest > 0 then
                return { emult = 1 + card.ability.extra.emult_per*highest }
            end
        end
        if (context.individual and context.cardarea == G.play and context.other_card or context.other_joker or context.other_consumeable or {}).edition then
            return {
                cry_broken_swap = card.ability.extra.percent
            }
        end
    end,
    attributes = { "emult", "swap", "enhancements" }
}

HPR.StellarJoker {
    key = "stardust",
    config = { extra = { xchult = 1.4, echult = 1.25, }},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.xchult, card.ability.extra.echult, }}
    end,
    calculate = function (self, card, context)
        if context.pre_discard and G.GAME.current_round.discards_used <= 0 and not context.hook then
            local text, _ = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
            local m = card.ability.extra.echult
            return {
                message = localize("k_upgrade_ex"),
                func = function ()
                    SMODS.upgrade_poker_hands{
                        from = card,
                        hands = text,
                        parameters = {"chips", "mult"},
                        StatusText = function (hand, parameter)
                            local ret = {
                                text = "^"..number_format(m),
                            }
                            if parameter == "chips" then
                                ret.cover_colour = Spectrallib.echips
                            elseif parameter == "mult" then
                                ret.cover_colour = Spectrallib.emult
                            end
                            return ret
                        end,
                        level_up = false,
                        func = function (base, hand, param, level_up)
                            return base^m
                        end,
                    }
                end
            }
        end
        if context.before then
            local text = context.scoring_name
            local m = card.ability.extra.xchult
            return {
                message = localize("k_upgrade_ex"),
                func = function ()
                    SMODS.upgrade_poker_hands{
                        from = card,
                        hands = text,
                        parameters = {"chips", "mult"},
                        StatusText = "X"..number_format(m),
                        level_up = false,
                        func = function (base, hand, param, level_up)
                            return base*m
                        end,
                    }
                end
            }
        end
    end,
    attributes = { "hand_type", "discard", }
}

HPR.StellarJoker {
    key = "mark",
    config = { extra = { dollars = 5, emult = 1.1, hand_type = "High Card", }},
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.extra.dollars,
                localize(G.GAME.current_round.hpr_mark_suit or "Spades", "suits_plural"),
                card.ability.extra.emult,
                localize(G.GAME.current_round.hpr_mark_rank or "Ace", "ranks"),
                localize(card.ability.extra.hand_type, "poker_hands"),
                colours = { G.C.SUITS[G.GAME.current_round.hpr_mark_suit or "Spades"] }
            }
        }
    end,
    set_ability = function (self, card, initial, delay_sprites)
        card.ability.extra.hand_type = HPR.get_random_hand(nil, HPR.false_area(card.area) and "false_hpr_mark" or "hpr_mark_hand")
    end,
    calculate = function (self, card, context)
        if context.joker_main and context.scoring_name == card.ability.extra.hand_type then
            return {
                balance = true,
            }
        end
        if context.discard and context.other_card:is_suit(G.GAME.current_round.hpr_mark_suit) then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
            return {
                dollars = card.ability.extra.dollars,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }
        end
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == Spectrallib.safe_get(SMODS.Ranks, G.GAME.current_round.hpr_mark_rank, "id") then
            return {
                emult = card.ability.extra.emult
            }
        end
        if context.end_of_round and not context.game_over and context.main_eval and not context.blueprint then
            local function p(v)
                return v ~= card.ability.extra.hand_type
            end
            card.ability.extra.hand_type = HPR.get_random_hand(nil, "hpr_mark_hand", p)
            return {
                message = localize("k_reset"),
                no_retrigger = true,
            }
        end
    end,
    attributes = { "rank", "suit", "hand_type", "emult", "economy", "balance", }
}

HPR.StellarJoker {
    key = "mask",
    config = { extra = { emult = 1.25, loss = 0.05, xchips = 1, gain = 0.2 } },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.emult, card.ability.extra.loss, card.ability.extra.xchips, card.ability.extra.gain }}
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_face() then
            local ret = {
                emult = card.ability.extra.emult ~= 1 and card.ability.extra.emult or nil,
                xchips = card.ability.extra.xchips ~= 1 and card.ability.extra.xchips or nil,
            }
            if card.ability.extra.emult > 1 then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "emult",
                    scalar_value = "loss",
                    no_message = true,
                    operation = "-",
                })
                card.ability.extra.emult = math.max(card.ability.extra.emult, 1)
            end
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "xchips",
                scalar_value = "gain",
                no_message = true,
            })
            return ret
        end
        if context.after then
            if card.ability.extra.emult ~= 1.25 then
                SMODS.reset_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "emult",
                    reset_value = 1.25,
                    no_message = true
                })
            end
            if card.ability.extra.xchips ~= 1 then
                SMODS.reset_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "xchips",
                    reset_value = 1,
                    no_message = true,
                })
            end
            return { message = localize("k_reset" ) }
        end
    end,
    attributes = { "xchips", "emult", "scaling", "reset", "face", }
}