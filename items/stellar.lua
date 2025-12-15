
SMODS.Rarity {
    badge_colour = HPR.stellar_gradient,
    key = "stellar"
}

HPR.StellarJoker = SMODS.Joker:extend({
    atlas = "hpr_placeholder",
    pos = { x = 0, y = 1 },
    soul_pos = { x = 1, y = 1 },
    rarity = "hpr_stellar",
    cost = 30
})

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
    j_space = "j_hpr_observatorium",
    j_misprint = "j_hpr_missing",
    j_cartomancer = "j_hpr_master",
    j_astronomer = "j_hpr_master",
    j_gros_michel = "j_hpr_potassium",
    j_cavendish = "j_hpr_potassium",
    j_jolly = "j_hpr_crazy",
    j_zany = "j_hpr_crazy",
    j_mad = "j_hpr_crazy",
    j_crazy = "j_hpr_crazy",
    j_droll = "j_hpr_crazy",
    j_sly = "j_hpr_crafty",
    j_wily = "j_hpr_crafty",
    j_clever = "j_hpr_crafty",
    j_devious = "j_hpr_crafty",
    j_crafty = "j_hpr_crafty",
    j_splash = "j_hpr_storm",
    j_selzer = "j_hpr_storm"
}

HPR.error_ops = { '+', '-', '=', '..', 'X', '/', '^', '%', '==', '~=', '>', '<', '>=', '<=', 'or', 'and', 'not', '#', 'ln', 'log', 'sin', 'cos', 'tan' }
HPR.error_numbers = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '21', '41', '61', '67', '69', '84', '404', '420', 'nan', 'inf', 'i', 'e', 'pi', 'huge', '666', '999', '-1', '23', '80085' }
HPR.error_other = {
    { string = "Chips", colour = G.C.CHIPS },
    { string = "Mult", colour = G.C.MULT },
    { string = "Dollars", colour = G.C.MONEY },
    { string = "Hand size", colour = G.C.FILTER },
    { string = "Hands", colour = G.C.BLUE },
    { string = "Discards", colour = G.C.RED },
    { string = "Vouchers", colour = G.C.SECONDARY_SET.Voucher },
    { string = "Boosters", colour = G.C.SECONDARY_SET.Booster },
    { string = "Slots", colour = G.C.DARK_EDITION },
    { string = "Hearts", colour = G.C.SUITS.Hearts },
    { string = "Diamonds", colour = G.C.SUITS.Diamonds },
    { string = "Spades", colour = G.C.SUITS.Spades },
    { string = "Clubs", colour = G.C.SUITS.Clubs },
    { string = "Tarots", colour = G.C.SECONDARY_SET.Tarot },
    { string = "Planets", colour = G.C.SECONDARY_SET.Planet },
    { string = "Spectrals", colour = G.C.SECONDARY_SET.Spectral },
    { string = "Common", colour = G.C.RARITY[1] },
    { string = "Uncommon", colour = G.C.RARITY[2] },
    { string = "Rare", colour = G.C.RARITY[3] },
    { string = "Blind Size", colour = G.C.FILTER },
    { string = "Rerolls", colour = G.C.GREEN },
    { string = "Levels", colour = G.C.SECONDARY_SET.Planet },
    { string = "Enhanced", colour = G.C.SECONDARY_SET.Enhanced },
    { string = "Tags", colour = G.C.FILTER },
    { string = "Faces", colour = G.C.FILTER },
    { string = "Score", colour = HEX('7b559c') }
}
HPR.error_context = {
    "context.before",
    "context.individual",
    "context.repetition",
    "context.joker_main",
    "context.setting_blind",
    "context.discard",
    "context.skip_blind",
    "context.post_trigger",
    "context.mod_probability",
    "calc_dollar_bonus",
    "context.selling_self",
    "context.game_over"
}

HPR.StellarJoker {
    key = "missing",
    blueprint_compat = true,
    loc_vars = function (self, info_queue, card)
        return {
            main_start = {
                {
                    n = G.UIT.O,
                    config = {
                        object = DynaText({
                            string = HPR.error_ops,
                            colours = { HPR.gay },
                            pop_in_rate = 9999999,
                            silent = true,
                            random_element = true,
                            pop_delay = 0.3,
                            scale = 0.32,
                            min_cycle_time = 0
                        })
                    },
                },
                {
                    n = G.UIT.O,
                    config = {
                        object = DynaText({
                            string = HPR.error_numbers,
                            colours = { HPR.gay },
                            pop_in_rate = 9999999,
                            silent = true,
                            random_element = true,
                            pop_delay = 0.351,
                            scale = 0.32,
                            min_cycle_time = 0
                        })
                    },
                },
                {
                    n = G.UIT.O,
                    config = {
                        object = DynaText({
                            string = HPR.error_other,
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
                {
                    n = G.UIT.T,
                    config = {
                        text = " when",
                        scale = 0.32,
                        colour = G.C.UI.TEXT_DARK
                    },
                },
            },
            main_end = {
                {
                    n = G.UIT.O,
                    config = {
                        object = DynaText({
                            string = HPR.error_context,
                            colours = { G.C.FILTER },
                            pop_in_rate = 9999999,
                            silent = true,
                            random_element = true,
                            pop_delay = 0.3,
                            scale = 0.32,
                            min_cycle_time = 0
                        })
                    },
                },
            }
        }
    end,
    calc_dollar_bonus = function (self, card)
        return pseudorandom("hpr_error_cashout",-4,11)
    end,
    calculate = function (self, card, context)
        if context.setting_blind then
            ease_discard(pseudorandom("hpr_error_discard", -2, 4))
            ease_hands_played(pseudorandom("hpr_error_hands", -2, 4))
            local h = pseudorandom("hpr_error_h_size", -1, 2)
            G.hand:change_size(h)
            G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + h
            return { message = localize("hpr_generic_q")}
        end
        if context.individual and context.cardarea == G.play then
            local res = pseudorandom("hpr_error_individual",1,6)
            if res == 1 then return { chips = pseudorandom("hpr_error_individual_effect",5,75) } end
            if res == 2 then return { xchips = pseudorandom("hpr_error_individual_effect",10,15)/10 } end
            if res == 3 then return { mult = pseudorandom("hpr_error_individual_effect",1,25) } end
            if res == 4 then return { xmult = pseudorandom("hpr_error_individual_effect",10,15)/10 } end
            if res == 5 then return { dollars = pseudorandom("hpr_error_individual_effect",0,4)} end
            if res == 6 then return { swap = true } end
        end
        if context.joker_main then
            return {
                xmult = pseudorandom("hpr_error_j_main", 7, 47)/10
            }
        end
    end
}

HPR.StellarJoker {
    key = "observatorium",
    config = { extra = { chips = 0, mult = 0 }},
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
    end,
}

HPR.StellarJoker {
    key = "master",
    blueprint_compat = true,
    demicoloncompat = true,
    calculate = function (self, card, context)
        if context.setting_blind or context.forcetrigger then
            G.E_MANAGER:add_event(Event{
                func = function ()
                    G.E_MANAGER:add_event(Event{
                        func = function ()
                            SMODS.add_card{
                                set = 'Consumeables',
                                key_append = "hpr_master",
                                edition = "e_negative",
                                area = G.consumeables
                            }
                            return true
                        end
                    })
                    SMODS.calculate_effect({ message = localize("k_plus_q"), colour = G.C.DARK_EDITION }, context.blueprint_card or card)
                    return true
                end
            })
            return nil, true
        end
    end,
    add_to_deck = function (self, card, from_debuff)
        G.E_MANAGER:add_event(Event{
            func = function ()
                for _,v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        })
    end,
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.e_negative
    end
}

HPR.StellarJoker {
    key = "potassium",
    blueprint_compat = true,
    --demicoloncompat = true,
    config = { extra = { xmult = 3, odds1 = 4, odds2 = 6 }},
    loc_vars = function (self, info_queue, card)
        local e = card.ability.extra
        local numerator, denominator = SMODS.get_probability_vars(card, 1, e.odds1, self.key)
        local numerator2, denominator2 = SMODS.get_probability_vars(card, 1, e.odds2, self.key.."2")
        return { vars = { e.xmult, numerator, denominator, numerator2, denominator2 }}
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play or context.forcetrigger then
            return { xmult = card.ability.extra.xmult }
        end
        if context.destroy_card and context.cardarea == G.play and SMODS.pseudorandom_probability(card, self.key, 1, card.ability.extra.odds1) then
            G.GAME.banned_keys[context.destroy_card.config.center.key] = true
            return { remove = true }
        end
        if context.end_of_round and card.area and card.rank then
            if card.area[card.rank-1] and SMODS.pseudorandom_probability(card, self.key.."2", 1, card.ability.extra.odds2) then
                G.GAME.banned_keys[card.area[card.rank-1].config.center.key] = true
                SMODS.calculate_effect({ message_card = card.area[card.rank-1], message = localize("k_extinct_ex")}, card)
            else
                SMODS.calculate_effect({ message_card = card.area[card.rank-1], message = localize("k_safe_ex")}, card)
            end
            if card.area[card.rank+1] and SMODS.pseudorandom_probability(card, self.key.."2", 1, card.ability.extra.odds2) then
                G.GAME.banned_keys[card.area[card.rank+1].config.center.key] = true
                SMODS.calculate_effect({ message_card = card.area[card.rank+1], message = localize("k_extinct_ex")}, card)
            else
                SMODS.calculate_effect({ message_card = card.area[card.rank+1], message = localize("k_safe_ex")}, card)
            end
            return nil, true
        end
    end
}

HPR.StellarJoker {
    key = "crazy",
    blueprint_compat = true,
    demicoloncompat = true,
    config = { extra = { mult = 0, scale = 5 }},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.scale }}
    end,
    calculate = function (self, card, context)
        if context.before then
            local hands = 0
            for _, hand in pairs(context.poker_hands) do
                if next(hand) then hands = hands + 1 end
            end
            if hands > 0 then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "mult",
                    scalar_value = "scale",
                    operation = function (ref_table, ref_value, initial, change)
                        ref_table[ref_value] = initial + change * hands
                    end,
                })
            end
        end
        if context.joker_main or context.forcetrigger then
            return { mult = card.ability.extra.mult }
        end
    end
}

HPR.StellarJoker {
    key = "crafty",
    blueprint_compat = true,
    demicoloncompat = true,
    config = { extra = { chips = 0, scale = 30 }},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.scale }}
    end,
    calculate = function (self, card, context)
        if context.before then
            local hands = 0
            for _, hand in pairs(context.poker_hands) do
                if next(hand) then hands = hands + 1 end
            end
            if hands > 0 then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "chips",
                    scalar_value = "scale",
                    operation = function (ref_table, ref_value, initial, change)
                        ref_table[ref_value] = initial + change * hands
                    end,
                })
            end
        end
        if context.joker_main or context.forcetrigger then
            return { chips = card.ability.extra.chips }
        end
    end
}

HPR.StellarJoker {
    key = "storm",
    calculate = function (self, card, context)
        if context.modify_scoring_hand and not context.blueprint then
            return { add_to_hand = true }
        end
        if context.repetition and context.cardarea == G.play then
            return { repetitions = 1 }
        end
    end
}

HPR.StellarJoker {
    key = "straightaway",
    config = { extra = { xmult = 0, gain = 0.15 }},
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.e_negative
        return { vars = { card.ability.extra.xmult, card.ability.extra.gain }}
    end,
    calculate = function (self, card, context)
        if context.before and next(context.poker_hands["Straight"]) then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "xmult",
                scalar_value = "gain",
            })
            G.E_MANAGER:add_event(Event{
                func = function ()
                    SMODS.add_card({
                        set = "Spectral",
                        edition = "e_negative"
                    })
                end
            })
            return { message = localize("k_plus_spectral") }
        end
    end
}