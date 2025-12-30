
SMODS.Rarity {
    badge_colour = HPR.stellar_gradient,
    key = "stellar",
    get_weight = function (self, weight, object_type)
        return G.GAME.modifiers.hpr_stellar_in_shop and 0.05 or 0
    end,
    default_weight = 0,
    pools = { Joker = true }
}

HPR.StellarJoker = SMODS.Joker:extend({
    atlas = "hpr_stellar",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    rarity = "hpr_stellar",
    cost = 30,
})

HPR.vanilla_ascensions = { --ASCENSION LIST
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
    j_selzer = "j_hpr_storm",
    j_runner = "j_hpr_straightaway",
    j_superposition = "j_hpr_straightaway",
    j_seance = "j_hpr_straightaway",
    j_half = "j_hpr_void",
    j_stencil = "j_hpr_void",
    j_cloud_9 = "j_hpr_nimbus",
    j_four_fingers = "j_hpr_shorthand",
    j_shortcut = "j_hpr_shorthand",
    j_greedy_joker = "j_hpr_diamond",
    j_rough_gem = "j_hpr_diamond",
    j_lusty_joker = "j_hpr_heart",
    j_bloodstone = "j_hpr_heart",
    j_wrathful_joker = "j_hpr_spade",
    j_arrowhead = "j_hpr_spade",
    j_gluttenous_joker = "j_hpr_club",
    j_onyx_agate = "j_hpr_club",
    j_erosion = "j_hpr_void",
    j_ancient = "j_hpr_wild",
    j_seeing_double = "j_hpr_wild",
    j_flower_pot = "j_hpr_wild",
    j_marble = "j_hpr_stone",
    j_stone = "j_hpr_stone",
    j_hologram = "j_hpr_conjurer",
    j_certificate = "j_hpr_conjurer",
    j_juggler = "j_hpr_circus",
    j_drunkard = "j_hpr_circus",
    j_merry_andy = "j_hpr_circus",
    j_troubadour = "j_hpr_circus",
    j_duo = "j_hpr_unity",
    j_trio = "j_hpr_unity",
    j_family = "j_hpr_unity",
    j_order = "j_hpr_unity",
    j_tribe = "j_hpr_unity",
    j_photograph = "j_hpr_mask",
    j_scary_face = "j_hpr_mask",
    j_smiley = "j_hpr_mask",
    j_sock_and_buskin = "j_hpr_mask",
    j_golden = "j_hpr_payload",
    j_rocket = "j_hpr_payload",
    j_to_the_moon = "j_hpr_payload",
    j_satellite = "j_hpr_payload",
    j_odd_todd = "j_hpr_numeric",
    j_even_steven = "j_hpr_numeric",
    j_scholar = "j_hpr_numeric",
    j_ceremonial = "j_hpr_destroyer",
    j_madness = "j_hpr_destroyer",
    j_hiker = "j_hpr_ascendant",
    j_invisible = "j_hpr_mimic",
    j_blueprint = "j_hpr_mimic",
    j_brainstorm = "j_hpr_mimic",
    j_oops = "j_hpr_lucky"
}

HPR.error_ops = { '+', '-', '=', '..', 'X', '/', '^', '%', '==', '~=', '>', '<', '>=', '<=', 'or', 'and', 'not', '#', 'log', 'sin', 'cos', 'tan' }
HPR.error_numbers = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '21', '41', '61', '67', '69', '84', '404', '420', 'nan', 'inf', 'i', 'e', 'pi', '666', '999', '-1', '23', '80085' }
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
        if context.hpr_level_up_hand and not context.blueprint and (context.chips > 0 or context.mult > 0) then
            card.ability.extra.chips = card.ability.extra.chips + math.max(context.chips, 0)
            card.ability.extra.mult = card.ability.extra.mult + math.max(context.mult, 0)
            for _, c in pairs(G.playing_cards) do
                c.ability.perma_bonus = c.ability.perma_bonus + math.max(context.chips, 0)
                c.ability.perma_mult = c.ability.perma_mult + math.max(context.mult, 0)
            end
            if not context.instant then
                return {
                    message = localize("k_upgrade_ex")
                }
            else
                return nil, true
            end
        end
        if context.joker_main or context.forcetrigger then
            return {
                chips = card.ability.extra.chips ~= 0 and card.ability.extra.chips or nil,
                mult = card.ability.extra.mult ~= 0 and card.ability.extra.mult or nil
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
    config = { extra = { xmult = 3, odds1 = 3, odds2 = 6 }},
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
        if context.destroy_card and not context.blueprint and context.cardarea == G.play and SMODS.pseudorandom_probability(card, self.key, 1, card.ability.extra.odds1) then
            G.GAME.banned_keys[context.destroy_card.config.center.key] = true
            return { remove = true }
        end
        if context.end_of_round and card.area and card.rank and not context.blueprint then
            if card.area.cards[card.rank-1] and SMODS.pseudorandom_probability(card, self.key.."2", 1, card.ability.extra.odds2) then
                G.GAME.banned_keys[card.area.cards[card.rank-1].config.center.key] = true
                SMODS.calculate_effect({ message_card = card.area.cards[card.rank-1], message = localize("k_extinct_ex")}, card)
            else
                SMODS.calculate_effect({ message_card = card.area.cards[card.rank-1], message = localize("k_safe_ex")}, card)
            end
            if card.area.cards[card.rank+1] and SMODS.pseudorandom_probability(card, self.key.."2", 1, card.ability.extra.odds2) then
                G.GAME.banned_keys[card.area.cards[card.rank+1].config.center.key] = true
                SMODS.calculate_effect({ message_card = card.area.cards[card.rank+1], message = localize("k_extinct_ex")}, card)
            else
                SMODS.calculate_effect({ message_card = card.area.cards[card.rank+1], message = localize("k_safe_ex")}, card)
            end
            return nil, true
        end
    end
}

HPR.StellarJoker {
    key = "crazy",
    blueprint_compat = true,
    demicoloncompat = true,
    pos = { x = 2, y = 0 },
    soul_pos = { x = 3, y = 0 },
    config = { extra = { mult = 0, scale = 5 }},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.scale }}
    end,
    calculate = function (self, card, context)
        if context.before and not context.blueprint then
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
    pos = { x = 4, y = 0},
    soul_pos = { x = 5, y = 0 },
    config = { extra = { chips = 0, scale = 30 }},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.scale }}
    end,
    calculate = function (self, card, context)
        if context.before and not context.blueprint then
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
    config = { extra = { xmult = 1, gain = 0.15 }},
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
        return { vars = { card.ability.extra.xmult, card.ability.extra.gain }}
    end,
    calculate = function (self, card, context)
        if context.before and next(context.poker_hands["Straight"]) then
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
                        set = "Spectral",
                        edition = "e_negative"
                    })
                    return true
                end
            })
            return { message = localize("k_plus_spectral") }
        end
        if context.joker_main and card.ability.extra.xmult ~= 1 then
            return { xmult = card.ability.extra.xmult }
        end
    end
}

HPR.StellarJoker {
    key = "void",
    config = { extra = { xmult_per = 0.5 }},
    loc_vars = function (self, info_queue, card)
        local amt = 0
        if G.hand and G.consumeables and G.jokers and G.deck then
            local hand = G.STATE == G.STATES.HAND_PLAYED and G.play.cards or G.hand.highlighted
            amt = amt + G.GAME.starting_params.play_limit-#hand
            amt = amt + (G.jokers.config.card_limit - #G.jokers.cards)
            amt = amt + (G.consumeables.config.card_limit - #G.consumeables.cards)
            amt = amt * math.max(1, G.GAME.starting_deck_size - #G.playing_cards)
        else
            amt = 1
        end
        return { vars = { card.ability.extra.xmult_per, amt*card.ability.extra.xmult_per, G.GAME.starting_deck_size or 52 }}
    end,
    calculate = function (self, card, context)
        if context.joker_main then
            local amt = 0
            amt = amt + G.GAME.starting_params.play_limit-#context.full_hand
            amt = amt + (G.jokers.config.card_limit - #G.jokers.cards)
            amt = amt + (G.consumeables.config.card_limit - #G.consumeables.cards)
            amt = amt * math.max(1, G.GAME.starting_deck_size - #G.playing_cards)
            if amt > 1 then return { xmult = math.max(amt * card.ability.extra.xmult_per,1) } end
        end
    end
}

HPR.StellarJoker {
    key = "nimbus",
    config = { extra = { dollars = 1 }},
    loc_vars = function (self, info_queue, card)
        local total = 0
        for _, c in ipairs(G.playing_cards or {}) do
            if c:get_id() == 9 then total = total + c:get_p_dollars() + c:get_h_dollars() end
        end
        return { vars = { card.ability.extra.dollars, total }}
    end,
    calculate = function (self, card, context)
        if context.individual and not context.end_of_round and context.other_card:get_id() == 9 then
            if context.cardarea == G.play then
                context.other_card.ability.perma_p_dollars = context.other_card.ability.perma_p_dollars + card.ability.extra.dollars
            elseif context.cardarea == G.hand then
                context.other_card.ability.perma_h_dollars = context.other_card.ability.perma_h_dollars + card.ability.extra.dollars
            end
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.MONEY
            }
        end
    end,
    calc_dollar_bonus = function (self, card)
        local total = 0
        for _, c in ipairs(G.playing_cards) do
            if c:get_id() == 9 then total = total + c:get_p_dollars() + c:get_h_dollars() end
        end
        return total
    end
}

HPR.StellarJoker { --literally everything this does is a hook lmfao
    key = "shorthand"
}

HPR.StellarJoker {
    key = "diamond",
    config = { extra = { mult = 3, dollars = 1 }},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.dollars }}
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit("Diamonds") then
            context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra.mult
            context.other_card.ability.perma_p_dollars = context.other_card.ability.perma_p_dollars + card.ability.extra.dollars
            return {
                message = localize("k_upgrade_ex")
            }
        end
    end
}

HPR.StellarJoker {
    key = "heart",
    config = { extra = { mult = 3, xmult = 1.5 }},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.xmult }}
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit("Hearts") then
            context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra.mult
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

HPR.StellarJoker {
    key = "spade",
    config = { extra = { mult = 3, chips = 50 }},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.chips }}
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit("Spades") then
            context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra.mult
            context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + card.ability.extra.chips
            return {
                message = localize("k_upgrade_ex")
            }
        end
    end
}

HPR.StellarJoker {
    key = "club",
    config = { extra = { multiplier = 2 }},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.multiplier }}
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit("Clubs") then
            local base_chips = 0
            if not SMODS.has_no_rank(context.other_card) then
                base_chips = context.other_card.base.nominal
            end
            context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra.multiplier * base_chips
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.MULT
            }
        end
    end
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
        if context.individual and context.cardarea == G.play and context.other_card:is_suit(G.GAME.current_round.ancient_card.suit) then
            return { xmult = card.ability.extra }
        end
    end
}

HPR.StellarJoker {
    key = "stone",
    config = { extra = 0.25 },
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_stone
        local stones = 0
        if G.playing_cards then
            for _, c in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(c, "m_stone") then stones = stones + 1 end
            end
        end
        return { vars = { 1 + card.ability.extra*stones, card.ability.extra }}
    end,
    calculate = function (self, card, context)
        if context.setting_blind then
            local c = pseudorandom_element(G.deck.cards, "hpr_stone", { in_pool = function (v, args) return not SMODS.has_enhancement(v, "m_stone") end})
            if c then
                c:set_ability("m_stone")
            end

            local stone_card = SMODS.create_card { set = "Base", enhancement = "m_stone", area = G.discard }
            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            stone_card.playing_card = G.playing_card
            table.insert(G.playing_cards, stone_card)

            G.E_MANAGER:add_event(Event({
                func = function()
                    stone_card:start_materialize({ G.C.SECONDARY_SET.Enhanced })
                    G.play:emplace(stone_card)
                    return true
                end
            }))
            return {
                message = localize('k_plus_stone'),
                colour = G.C.SECONDARY_SET.Enhanced,
                func = function() -- This is for timing purposes, everything here runs after the message
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.deck.config.card_limit = G.deck.config.card_limit + 1
                            return true
                        end
                    }))
                    draw_card(G.play, G.deck, 90, 'up')
                    SMODS.calculate_context({ playing_card_added = true, cards = { stone_card } })
                end
            }
        end
        if context.before then
            for _, c in ipairs(context.full_hand) do
                if not c.seal then c:set_seal(SMODS.poll_seal{guaranteed=true}) end
                if not c.edition then c:set_edition(SMODS.poll_edition{guaranteed=true,no_negative=true}, nil, nil, true) end
            end
        end
        if context.joker_main then
            local stones = 0
            for _,c in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(c, "m_stone") then stones = stones + 1 end
            end
            if stones ~= 0 then return { xchips = 1+card.ability.extra*stones} end
        end
    end
}

HPR.StellarJoker {
    key = "conjurer",
    config = { extra = { xmult = 1, gain = 0.5, packs = 2 }},
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.p_standard_mega_1
        return { vars = { card.ability.extra.xmult, card.ability.extra.gain, card.ability.extra.packs }}
    end,
    calculate = function (self, card, context)
        if context.starting_shop then
            G.E_MANAGER:add_event(Event{
                func = function ()
                    for i = 1, card.ability.extra.packs do
                        local c = SMODS.add_booster_to_shop("p_standard_mega_"..pseudorandom("hpr_conjurer"..i,1,2))
                        c.ability.couponed = true
                        c:set_cost()
                    end
                    return true
                end
            })
        end
        if context.playing_card_added then
            local amt = #context.cards
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "xmult",
                scalar_value = "gain",
                operation = function (ref_table, ref_value, initial, change)
                    ref_table[ref_value] = initial + change * amt
                end
            })
        end
        if context.joker_main and card.ability.extra.xmult ~= 1 then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

HPR.StellarJoker {
    key = "circus",
    config = { extra = { h_d = 3, h_c = 2, csl = 1 }},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.h_d, card.ability.extra.h_c, card.ability.extra.csl}}
    end,
    add_to_deck = function (self, card, from_debuff)
        ease_hands_played(card.ability.extra.h_d)
        ease_discard(card.ability.extra.h_d)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.h_d
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.h_d
        G.hand:change_size(card.ability.extra.h_c); G.consumeables:change_size(card.ability.extra.h_c)
        SMODS.change_play_limit(card.ability.extra.csl)
        SMODS.change_discard_limit(card.ability.extra.csl)
    end,
    remove_from_deck = function (self, card, from_debuff)
        ease_hands_played(-card.ability.extra.h_d)
        ease_discard(-card.ability.extra.h_d)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.h_d
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.h_d
        G.hand:change_size(-card.ability.extra.h_c); G.consumeables:change_size(-card.ability.extra.h_c)
        SMODS.change_play_limit(-card.ability.extra.csl)
        SMODS.change_discard_limit(-card.ability.extra.csl)
    end
}

HPR.StellarJoker {
    key = "unity",
    pos = { x = 6, y = 0 },
    soul_pos = { x = 7, y = 0 },
    config = { extra = { xmult = 1, scale = 0.2}},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.scale }}
    end,
    blueprint_compat = true,
    demicoloncompat = true,
    calculate = function (self, card, context)
        if context.before and not context.blueprint then
            local hands = 0
            for _, hand in pairs(context.poker_hands) do
                if next(hand) then hands = hands + 1 end
            end
            if hands > 0 then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "xmult",
                    scalar_value = "scale",
                    operation = function (ref_table, ref_value, initial, change)
                        ref_table[ref_value] = initial + change * hands
                    end,
                })
            end
        end
        if (context.joker_main or context.forcetrigger) and card.ability.extra.xmult ~= 1 then
            return { xmult = card.ability.extra.xmult }
        end
    end
}

HPR.StellarJoker {
    key = "mask",
    config = { extra = { xmult = 2, chips = 100, dollar = 4 }},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.chips, card.ability.extra.dollar }}
    end,
    blueprint_compat = true,
    demicoloncompat = true,
    calculate = function (self, card, context)
        if context.repetition and context.other_card:is_face() then
            return { repetitions = 1 }
        end
        if context.individual and context.cardarea == G.play and context.other_card:is_face() then
            local res = pseudorandom("hpr_mask_effect",1,3)
            if res == 1 then return { xmult = card.ability.extra.xmult } end
            if res == 2 then return { chips = card.ability.extra.chips } end
            if res == 3 then
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollar
                return {
                    dollars = card.ability.extra.dollar,
                    func = HPR.event_presets.reset_dollar_buffer
                }
            end
        end
    end
}

HPR.StellarJoker {
    key = "numeric",
    blueprint_compat = true,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and not context.other_card:is_face() and not SMODS.has_no_rank(context.other_card) then
            local base_chips = HPR.get_base_chips(context.other_card)
            for _, c in ipairs(context.full_hand) do
                if c ~= context.other_card and base_chips then
                    c.ability.perma_bonus = c.ability.perma_bonus + base_chips
                    c.ability.perma_mult = c.ability.perma_mult + base_chips
                    SMODS.calculate_effect({ message = localize("k_upgrade_ex"), message_card = c }, card)
                end
            end
            return nil, true
        end
    end
}

HPR.StellarJoker {
    key = "payload",
    config = { extra = { cap = 5, per = 5, scale = 1 } },
    calc_dollar_bonus = function (self, card)
        local amt = math.floor(G.GAME.dollars/card.ability.extra.per)
        amt = math.min(amt, card.ability.extra.cap)
        SMODS.scale_card(card, {
            ref_table = card.ability.extra,
            ref_value = "cap",
            scalar_value = "scale",
            message_colour = G.C.MONEY
        })
        if amt > 0 then return amt end
    end,
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.cap, card.ability.extra.per, card.ability.extra.scale }}
    end
}

HPR.StellarJoker {
    key = "destroyer",
    blueprint_compat = true,
    config = { extra = { xmult = 1 }},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.xmult  }}
    end,
    calculate = function (self, card, context)
        if context.setting_blind and not context.blueprint and card.area and card.rank and card.area.cards[card.rank+1] and not SMODS.is_eternal(card.area.cards[card.rank+1], card) and not card.area.cards[card.rank+1].getting_sliced then
            local target = card.area.cards[card.rank+1]
            target.getting_sliced = true
            G.GAME.joker_buffer = G.GAME.joker_buffer - 1
            G.E_MANAGER:add_event(Event{
                func = function ()
                    G.GAME.joker_buffer = 0
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "xmult",
                        scalar_table = target,
                        scalar_value = "sell_cost",
                        message_key = "a_xmult",
                        message_colour = G.C.MULT
                    })
                    target:start_dissolve({G.C.HPR_STLR}, nil, 1.6)
                    return true
                end
            })
            return nil, true
        end
        if context.joker_main and card.ability.extra.xmult ~= 1 then
            return { xmult = card.ability.extra.xmult }
        end
    end
}

HPR.StellarJoker {
    key = "ascendant",
    blueprint_compat = true,
    config = { extra = 0.05 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra }}
    end,
    calculate = function (self, card, context)
        if context.individual and not context.end_of_round then
            if context.cardarea == G.play or context.cardarea == 'unscored' then
                context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult + card.ability.extra
            end
            if context.cardarea == G.hand then
                context.other_card.ability.perma_h_x_mult = context.other_card.ability.perma_h_x_mult + card.ability.extra
            end
        end
    end
}

HPR.StellarJoker {
    key = "mimic",
    blueprint_compat = true,
    calculate = function (self, card, context)
        if context.retriggger_joker_check and not context.retrigger_joker and card.area and card.rank then
            if context.other_card == card.area.cards[card.rank+1] or context.other_card == card.area.cards[card.rank-1] then
                return { repetitions = 1 }
            end
        end
    end
}

HPR.StellarJoker {
    key = "lucky",
    config = { extra = 4 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra }}
    end,
    calculate = function (self, card, context)
        if context.mod_probability and not context.blueprint then
            if context.trigger_obj and context.trigger_obj.config and context.trigger_obj.config.blind then
                return { numerator = 0 }
            end
        end
        if context.hpr_retrigger_probability and not (context.trigger_obj and context.trigger_obj.config and context.trigger_obj.config.blind) then
            return { hpr_retriggers = card.ability.extra }
        end
    end,
    add_to_deck = function (self, card, from_debuff)
        G.GAME.common_mod = (G.GAME.common_mod or 1) * 0.5
        G.GAME.rare_mod = (G.GAME.rare_mod or 1) * 2
        if next(SMODS.find_mod("entr")) and G.GAME.modifiers.entr_meteorite then
            G.GAME.modifiers.entr_meteorite = G.GAME.modifiers.entr_meteorite / 3
        end
    end,
    remove_from_deck = function (self, card, from_debuff)
        G.GAME.common_mod = (G.GAME.common_mod or 1) / 0.5
        G.GAME.rare_mod = (G.GAME.rare_mod or 1) / 2
        if next(SMODS.find_mod("entr")) and G.GAME.modifiers.entr_meteorite then
            G.GAME.modifiers.entr_meteorite = G.GAME.modifiers.entr_meteorite * 3
        end
    end
}