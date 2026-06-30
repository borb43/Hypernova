
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
function HPR.StellarJoker(args)
    args.stellar_num = HPR.STELLAR_INDEX
    HPR.STELLAR_INDEX = HPR.STELLAR_INDEX + 1
    return HPR.new_stellar(args)
end
HPR.new_stellar = SMODS.Joker:extend({
    atlas = "hpr_stellar",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    rarity = "hpr_stellar",
    cost = 30,
})

SMODS.Consumable {
    key = "ascender",
    set = "Spectral",
    atlas = "placeholder",
    pos = { x = 2, y = 2 },
    hidden = true,
    can_use = function (self, card)
        return G.jokers and G.jokers.highlighted and #G.jokers.highlighted == 1 and HPR.get_ascension(G.jokers.highlighted[1]) ~= nil
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
}

HPR.error_ops = { '+', '-', '=', '..', 'X', '/', '^', '%' }
HPR.error_numbers = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '21', '41', '61', '67', '69', '84', '404', '420', 'nan', 'inf', 'i', 'e', 'pi'}
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
    config = { extra = { uses = 4 }},
    loc_vars = function (self, info_queue, card)
        local error_other = {
            { string = localize("k_chips"), colour = G.C.CHIPS },
            { string = localize("k_mult"),  colour = G.C.MULT },
            { string = localize("k_glop"),  colour = G.C.GREEN },
            { string = localize("k_score"), colour = G.C.PURPLE },
            { string = localize("k_uses"),  colour = G.C.FILTER },
        }
        local use_effects = {
            { string = localize("k_enhance"), colour = G.C.SECONDARY_SET.Enhanced },
            { string = localize("k_seal"), colour = G.C.FILTER },
            { string = localize("k_edition"), colour = G.C.DARK_EDITION },
            { string = localize("k_debuff"), colour = G.C.RED },
            { string = localize("k_destroy"), colour = G.C.FILTER },
            { string = localize("k_suit"), colour = G.C.FILTER },
            { string = localize("k_rank"), colour = G.C.FILTER },
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
            --cycling use effect
            {
                n = G.UIT.O,
                config = {
                    object = DynaText({
                        string = use_effects,
                        colours = { G.C.UI.TEXT_DARK },
                        pop_in_rate = 9999999,
                        silent = true,
                        random_element = true,
                        pop_delay = 0.310,
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
            local res = pseudorandom("hpr_error_effect", 1, 6)
            if res == 1 then return { xchips = pseudorandom("hpr_error_amt",15,25)/10 } end
            if res == 2 then return { xmult = pseudorandom("hpr_error_amt",15,25)/10 } end
            if res == 3 then return { echips = pseudorandom("hpr_error_amt",105,115)/100 } end
            if res == 4 then return { emult = pseudorandom("hpr_error_amt",110,120)/100 } end
            if res == 5 then return { xscore = pseudorandom("hpr_error_amt",20, 30)/10 } end
            if res == 6 then
                local v = pseudorandom("hpr_error_amt",1,5)
                card.ability.extra.uses = card.ability.extra.uses + v
                return { message = "+"..v }
            end
        end
    end,
    can_use = function (self, card)
        local cards = Spectrallib.get_highlighted_cards({ G.hand }, card, 1, card.ability.extra.uses)
        return card.ability.extra.uses > 0 and #cards > 0 and #cards <= card.ability.extra.uses
    end,
    use = function (self, card)
        local cards = Spectrallib.get_highlighted_cards({ G.hand }, card, 1, card.ability.extra.uses)
        card.ability.extra.uses = math.max(card.ability.extra.uses - #cards, 0)
        local effect = pseudorandom_element({"enh","seal","ed","debf","dstry","suit","rank"}, "hpr_error_use_effect")
        if effect == "enh" then
            local enhancement = SMODS.poll_enhancement{ guaranteed = true, type_key = "hpr_error_use_val"}
            Spectrallib.flip_then(cards, function (c)
                c:set_ability(enhancement)
            end)
        elseif effect == "seal" then
            local seal = SMODS.poll_seal{ guaranteed = true, type_key = "hpr_error_use_val" }
            Spectrallib.flip_then(cards, function (c)
                c:set_seal(seal, nil, true)
            end)
        elseif effect == "ed" then
            local edition = SMODS.poll_edition{ guaranteed = true, type_key = "hpr_error_use_val" }
            Spectrallib.flip_then(cards, function (c)
                c:set_edition(edition, true)
            end)
        elseif effect == "debf" then
            Spectrallib.flip_then(cards, function (c)
                SMODS.debuff_card(c, true, "HPR_ERROR_DEBUFF")
            end)
        elseif effect == "dstry" then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    SMODS.destroy_cards(cards)
                    return true
                end
            }))
        elseif effect == "suit" then
            local suit = pseudorandom_element(SMODS.Suit.obj_buffer, "hpr_error_use_val")
            Spectrallib.flip_then(cards, function (c)
                assert(SMODS.change_base(c, suit))
            end)
        elseif effect == "rank" then
            local rank = pseudorandom_element(SMODS.Rank.obj_buffer, "hpr_error_use_val")
            Spectrallib.flip_then(cards, function (c)
                assert(SMODS.change_base(c, nil, rank))
            end)
        end
    end,
    use_button_config = {
        key = "lalala this key doesnt exist so itll say error" --(fitting isnt it)
    },
    attributes = { "xchips", "xmult", "emult", "echips", "xscore", "destroy_card", "modify_card", "enhancement", "seal", "edition" },
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
    attributes = { "space", "chips", "mult", "modify_card" },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.asc }}
    end,
}

HPR.StellarJoker {
    key = "master",
    forcetrigger_compat = true,
    config = { extra = { rank = "Ace", hand_type = "High Card", consumable = nil, multiuse = 1, scale = 1 } },
    loc_vars = function (self, info_queue, card)
        local consumable = card.ability.extra.consumable and G.P_CENTERS[card.ability.extra.consumable] or nil
        local loc_name = consumable and localize{ type = "name_text", key = consumable.key, set = consumable.set } or localize("k_none")
        local col = consumable and G.C.SECONDARY_SET[consumable.set] or G.C.RED
        local main_end = {
            n = G.UIT.C,
            config = { align = "bm", padding = 0.02 },
            nodes = {
                {
                    n = G.UIT.C,
                    config = { align = "m", colour = col, r = 0.05, padding = 0.05 },
                    nodes = {
                        { n = G.UIT.T, config = { text = ' ' .. loc_name .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true } },
                    }
                }
            }
        }
        local loc_rank = localize(card.ability.extra.rank, "ranks")
        local loc_hand = localize(card.ability.extra.hand_type, "poker_hands")
        if consumable then info_queue[#info_queue+1] = consumable end
        info_queue[#info_queue+1] = { set = "Edition", key = "e_negative_consumable", config = { extra = 1 } }
        return { vars = { loc_rank, loc_hand, card.ability.extra.multiuse, card.ability.extra.scale, elements = { main_end } }}
    end,
    calculate = function (self, card, context)
        if context.joker_main and card.ability.extra.consumable then
            local check = false
            if next(context.poker_hands[card.ability.extra.hand_type]) then
                check = true
            end
            for _, c in ipairs(context.scoring_hand) do
                if c:get_id() == SMODS.Ranks[card.ability.extra.rank].id then
                    check = true break
                end
            end
            if check then
                local consumable = G.P_CENTERS[card.ability.extra.consumable]
                G.E_MANAGER:add_event(Event{
                    func = function (n)
                        local c = SMODS.add_card{
                            key = consumable.key,
                            set = consumable.set,
                            key_append = "hpr_master_card",
                            edition = "e_negative"
                        }
                        c.ability.cry_multiuse = (c.ability.cry_multiuse or 0) + card.ability.extra.multiuse
                        return true
                    end
                })
                return {
                    message = localize{ type = "variable", key = "hpr_plus_any", vars = { localize{ type = "name_text", key = consumable.key, set = consumable.set } }},
                    colour = G.C.SECONDARY_SET[consumable.set],
                }
            end
        end
        if context.end_of_round and context.main_eval then
            local c = pseudorandom_element(SMODS.Ranks, f and "false_hpr_master" or "hpr_master_reset_rank")
            if c then
                card.ability.extra.rank = c.key
            end
            card.ability.extra.hand_type = HPR.get_random_hand(nil, "hpr_master_reset_hand", function(v) return v ~= card.ability.extra.hand_type end)
            if context.beat_boss and card.ability.extra.consumable then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "multiuse",
                    scalar_value = "scale",
                })
                return nil, true
            end
        end
    end,
    set_ability = function (self, card, from_debuff)
        local f = HPR.false_area(card.area)
        local c = pseudorandom_element(SMODS.Ranks, f and "false_hpr_master" or "hpr_master_reset_rank")
        if c then
            card.ability.extra.rank = c.key
        end
        card.ability.extra.hand_type = HPR.get_random_hand(nil, f and "false_hpr_master" or "hpr_master_reset_hand")
    end,
    can_use = function (self, card)
        return #Spectrallib.get_highlighted_cards({ G.consumeables }, card, 1, 1) == 1
    end,
    use = function (self, card)
        local cards = Spectrallib.get_highlighted_cards({ G.consumeables }, card, 1, 1, nil, "hpr_master_forcetrigger")
        local c = cards[1]
        if c then
            card.ability.extra.consumable = c.config.center_key
            card.ability.extra.multiuse = 1
            SMODS.destroy_cards(c)
        end
    end,
    attributes = { "rank", "generation", "hand_type" },
}

HPR.StellarJoker {
    key = "potassium",
    forcetrigger_compat = true,
    config = { extra = { emult = 1.5, odds1 = 6, odds2 = 10 }},
    loc_vars = function (self, info_queue, card)
        local e = card.ability.extra
        local numerator, denominator = SMODS.get_probability_vars(card, 1, e.odds1, self.key)
        local numerator2, denominator2 = SMODS.get_probability_vars(card, 1, e.odds2, self.key.."2")
        return { vars = { e.emult, numerator, denominator, numerator2, denominator2 }}
    end,
    calculate = function (self, card, context)
        if context.joker_main or context.forcetrigger then
            return { emult = card.ability.extra.emult }
        end
        if context.destroy_card and not context.blueprint and context.cardarea == G.play and SMODS.pseudorandom_probability(card, self.key, 1, card.ability.extra.odds1) then
            return { destroy = true }
        end
        if context.end_of_round and context.main_eval and not context.blueprint then
            local any
            for _, c in ipairs(G.jokers.cards) do
                if c.config.center_key ~= self.key then
                    any = true
                    if SMODS.pseudorandom_probability(card, self.key.."2", 1, card.ability.extra.odds2) then
                        G.GAME.banned_keys[c.config.center_key] = true
                        SMODS.destroy_cards(c, { pinch_anim = true })
                        SMODS.calculate_effect({ message = localize("k_extinct_ex"), message_card = c }, card)
                    else
                        SMODS.calculate_effect({ message = localize("k_safe_ex"), message_card = c }, card)
                    end
                end
            end
            if any then return nil, true end
        end
    end,
    attributes = { "emult", "destroy_card", "chance", },
}

HPR.StellarJoker {
    key = "crazy",
    pos = { x = 3, y = 0 },
    soul_pos = {
        x = 4, y = 0,
        extra = { x = 5, y = 0 }
    },
    config = { extra = { mult = 1 }},
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
            local m = card.ability.extra.mult
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.MULT,
                func = function ()
                    SMODS.upgrade_poker_hands{
                        from = card,
                        parameters = {"mult"},
                        level_up = false,
                        hands = hands,
                        func = function (base, hand, param)
                            return base + count*m
                        end
                    }
                end
            }
        end
    end,
    --attributes = { "mult", },
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
    config = { extra = { chips = 5 }},
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
            local m = card.ability.extra.chips
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.MULT,
                func = function ()
                    SMODS.upgrade_poker_hands{
                        from = card,
                        parameters = {"chips"},
                        level_up = false,
                        hands = hands,
                        func = function (base, hand, param)
                            return base + count*m
                        end
                    }
                end
            }
        end
    end,
    --attributes = { "chips", },
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
        if context.repetition and context.cardarea == G.play then
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
    attributes = { "emult", "xmult", "joker_slot", },
    forcetrigger_compat = true,
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
        if context.forcetrigger then
            local d = self:calc_dollar_bonus(card)
            if d ~= 0 then
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + d
                return { dollars = d, func = HPR.event_presets.reset_dollar_buffer }
            end
        end
    end,
    calc_dollar_bonus = function (self, card)
        local total = 0
        for _, c in ipairs(G.playing_cards) do
            if c:get_id() == 9 then total = total + c:get_p_dollars() + c:get_h_dollars() end
        end
        return total
    end,
    attributes = { "economy", "rank", "nine", "modify_card", }, --this joker is probably getting cut but doing this anyway
    forcetrigger_compat = true,
}

HPR.StellarJoker { --literally everything this does is a hook lmfao
    key = "shorthand",
    blueprint_compat = false,
    attributes = { "passive", "hand_type" },
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
    config = { extra = { xmult = 1, gain = 0.25, packs = 2 }},
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.p_standard_mega_1
        return { vars = { card.ability.extra.xmult, card.ability.extra.gain, card.ability.extra.packs }}
    end,
    calculate = function (self, card, context)
        if context.starting_shop or (context.forcetrigger and G.STATE == G.STATES.SHOP) then --i hope this is safe?
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
        if (context.joker_main or context.forcetrigger) and card.ability.extra.xmult ~= 1 then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
    attributes = { "generation", "xmult", "scaling", },
    forcetrigger_compat = true,
}

HPR.StellarJoker {
    key = "circus",
    config = { extra = 1 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra } }
    end,
    add_to_deck = function (self, card, from_debuff)
        G.hand:change_size(card.ability.extra)
        G.consumeables:change_size(card.ability.extra)
        ease_hands_played(card.ability.extra)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra
        ease_discard(card.ability.extra)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra
        SMODS.change_play_limit(card.ability.extra)
        SMODS.change_discard_limit(card.ability.extra)
        change_shop_size(card.ability.extra)
        ease_ante(-card.ability.extra)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - card.ability.extra
    end,
    remove_from_deck = function (self, card, from_debuff)
        G.hand:change_size(-card.ability.extra)
        G.consumeables:change_size(-card.ability.extra)
        ease_hands_played(-card.ability.extra)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra
        ease_discard(-card.ability.extra)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra
        SMODS.change_play_limit(-card.ability.extra)
        SMODS.change_discard_limit(-card.ability.extra)
        change_shop_size(-card.ability.extra)
        ease_ante(card.ability.extra)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + card.ability.extra
    end,
    attributes = { "hand_size", "hands", "discard", "reroll", },
    blueprint_compat = false,
}

HPR.StellarJoker {
    key = "unity",
    pos = { x = 9, y = 0 },
    soul_pos = {
        x = 10, y = 0,
        --extra = { x = 11, y = 0 }
    },
    config = { extra = { xmult = 1, scale = 0.1}},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.scale }}
    end,
    forcetrigger_compat = true,
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
    end,
    attributes = { "xmult", "scaling", },
    hpr_badge_info = {
        { key = "credits_code", vars = {"Eris"} },
        { key = "credits_art", vars = {"Eris"}},
        { key = "credits_idea", vars = {"Eris"}},
    },
}

HPR.StellarJoker {
    key = "mask",
    config = { extra = { xmult = 1.5, dollar = 3, reps = 3 }},
    loc_vars = function (self, info_queue, card)
        local key = self.key
        if next(SMODS.find_mod("paperback")) then
            local a = false
            for _, v in ipairs(G.playing_cards or {}) do
                if PB_UTIL.is_rank(v, 'paperback_Apostle') then a = true end --thank you paperback
            end
            if a then
                key = key.."_pb"
            end
        end
        return { vars = { card.ability.extra.xmult, card.ability.extra.dollar, card.ability.extra.reps }, key = key }
    end,
    forcetrigger_compat = true,
    calculate = function (self, card, context)
        if context.individual and not context.end_of_round and not context.other_card.debuff then
            local id = context.other_card:get_id()
            local a = Spectrallib.safe_get(SMODS.Ranks,"paperback_Apostle","id")
            if context.cardarea == G.discard and (id == 11 or id == a) then
                return { xmult = card.ability.extra.xmult }
            end
            if context.cardarea == G.hand and (id == 12 or id == a) then
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
            if id == 13 or id == Spectrallib.safe_get(SMODS.Ranks,"paperback_Apostle","id") then
                return { repetitions = card.ability.extra.reps }
            end
        end
    end,
    attributes = { "xmult", "econ", "face", },
    hpr_loc_keys = { "j_hpr_mask", "j_hpr_mask_pb" }
}

HPR.StellarJoker {
    key = "numeric",
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
    end,
    attributes = { "chips", "mult", "modify_card", },
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
    end,
    forcetrigger = function (self, card, context)
        local d = math.floor(G.GAME.dollars/card.ability.extra.per)
        d = math.min(d, card.ability.extra.cap)
        if d ~= 0 then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + d
            return { dollars = d, func = HPR.event_presets.reset_dollar_buffer }
        end
    end,
    attributes = { "economy", "scaling", },
    blueprint_compat = true,
}

HPR.StellarJoker {
    key = "destroyer",
    config = { extra = { echips = 1, chip_mod = 0.01, uses = 0 }},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.echips, card.ability.extra.chip_mod, card.ability.extra.uses }}
    end,
    calculate = function (self, card, context)
        if (context.setting_blind or context.forcetrigger) and not context.blueprint and card.area and card.rank and card.area.cards[card.rank+1] and not SMODS.is_eternal(card.area.cards[card.rank+1], card) and not card.area.cards[card.rank+1].getting_sliced then
            local target = card.area.cards[card.rank+1]
            target.getting_sliced = true
            G.GAME.joker_buffer = G.GAME.joker_buffer - 1
            G.E_MANAGER:add_event(Event{
                func = function ()
                    G.GAME.joker_buffer = 0
                    card.ability.extra.uses = card.ability.extra.uses + target.sell_cost
                    target:start_dissolve({G.C.HPR_STLR}, nil, 1.6)
                    play_sound('slice1', 0.96 + math.random() * 0.08)
                    return true
                end
            })
            if not context.forcetrigger then
                return nil, true
            else
                return { message = "+"..target.sell_cost }
            end
        end
        if (context.joker_main or context.forcetrigger) and card.ability.extra.echips ~= 1 then
            return {
                echips = card.ability.extra.echips,
            }
        end
    end,
    can_use = function (self, card)
        local blacklist = function (c)
            return not SMODS.is_eternal(c)
        end
        local cards = Spectrallib.get_highlighted_cards({ G.hand }, card, 1, card.ability.extra.uses, blacklist)
        return card.ability.extra.uses > 0 and #cards > 0 and #cards <= card.ability.extra.uses
    end,
    use = function (self, card)
        local blacklist = function (c)
            return not SMODS.is_eternal(c)
        end
        local cards = Spectrallib.get_highlighted_cards({ G.hand }, card, 1, card.ability.extra.uses, blacklist)
        local amt = #cards
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                SMODS.destroy_cards(cards)
                return true
            end
        }))
        SMODS.scale_card(card, {
            ref_table = card.ability.extra,
            ref_value = "echips",
            scalar_value = "chip_mod",
            operation = function (ref_table, ref_value, initial, change)
                ref_table[ref_value] = initial + change*amt
            end,
            message_colour = Spectrallib.echips
        })
    end,
    attributes = { "destroy_card", "echips", "scaling", },
    forcetrigger_compat = true,
}

HPR.StellarJoker {
    key = "ascendant",
    config = { extra = { xchips = 0.025, xmult = 0.05 } },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.xchips, card.ability.extra.xmult }}
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play then
            context.other_card.ability.perma_x_chips = context.other_card.ability.perma_x_chips + card.ability.extra.xchips
            return { message = localize("k_upgrade_ex"), colour = G.C.BLUE }
        end
        if context.before and #context.full_hand == 1 and G.GAME.current_round.hands_played == 0 then
            local c = context.full_hand[1]
            c.ability.perma_repetitions = c.ability.perma_repetitions + 1
            return {
                message = localize("k_upgrade_ex"),
                message_card = c
            }
        end
        if context.discard then
            context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult + card.ability.extra.xmult
            return { message = localize("k_upgrade_ex"), colour = G.C.RED }
        end
    end,
    attributes = { "modify_card", "retrigger", "xmult", "xchips", },
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
    config = { immutable = 1, extra = 1, },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.immutable, card.ability.extra }}
    end,
    calculate = function (self, card, context)
        if context.mod_probability then
            return { numerator = context.numerator * card.ability.immutable }
        end
        if context.end_of_round and context.main_eval and context.beat_boss then
            local new_val = pseudorandom("hpr_lucky_d6",1,6)
            card.ability.immutable = new_val
            if new_val == 1 then -- +1 consumable slot
                G.consumeables:change_size(card.ability.extra)
                return { colour = G.C.FILTER, message = localize{ key = "a_consumable_slot", type = "variable", vars = {card.ability.extra} }}
            elseif new_val == 2 then -- +1 discard
                G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra
                ease_discard(card.ability.extra)
                return { colour = G.C.RED, message = localize{ key = "a_discards", type = "variable", vars = {card.ability.extra} } }
            elseif new_val == 3 then -- +1 hand
                G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra
                ease_hands_played(card.ability.extra)
                return { colour = G.C.BLUE, message = localize{ key = "a_hands", type = "variable", vars = {card.ability.extra} }}
            elseif new_val == 4 then -- +1 hand size
                G.hand:change_size(card.ability.extra)
                return { colour = G.C.FILTER, message = localize{ key = "a_handsize", type = "variable", vars = {card.ability.extra} }}
            elseif new_val == 5 then -- -1 ante
                ease_ante(-card.ability.extra)
                return { colour = G.C.FILTER, message = localize{ key = "a_ante_minus", type = "variable", vars = {card.ability.extra} }}
            elseif new_val == 6 then -- +1 joker slot
                G.jokers:change_size(card.ability.extra)
                return { colour = G.C.DARK_EDITION, message = localize{ key = "a_joker_slot", type = "variable", vars = {card.ability.extra} }}
            end
        end
    end,
    set_ability = function (self, card)
        local f = HPR.false_area(card.area)
        card.ability.immutable = pseudorandom(f and "false_hpr_d6" or "hpr_lucky_initial_d6",1,6)
    end,
    attributes = { "modify_card", "mod_chance", },
}

HPR.StellarJoker {
    key = "guardian",
    config = { extra = { active = true }},
    loc_vars = function (self, info_queue, card)
        if not (card.edition and card.edition.negative) then
            info_queue[#info_queue+1] = G.P_CENTERS.e_negative
        end
        info_queue[#info_queue+1] = { set = "Other", key = "eternal", config = {} }
        return { vars = { localize(card.ability.extra.active and "k_active" or "k_inactive") }}
    end,
    calculate = function (self, card, context)
        if context.ante_change and SMODS.ante_end then
            card.ability.extra.active = true
        end
        if context.game_over and card.ability.extra.active and not context.blueprint and context.main_eval then
            card.ability.extra.active = false
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card{ set = "Joker", key_append = self.key, edition = "e_negative", stickers = {"eternal"}, force_stickers = true, }
                    G.hand_text_area.blind_chips:juice_up()
                    G.hand_text_area.game_chips:juice_up()
                    play_sound('tarot1')
                    return true
                end
            }))
            return {
                message = localize("k_blessed_ex"),
                saved = "ph_hpr_stellar_revive",
                colour = G.C.RARITY.hpr_stellar
            }
        end
    end,
    forcetrigger = function (self, card, context)
        G.E_MANAGER:add_event(Event({
            func = function()
                for _ = 1, card.ability.extra.cards do
                    SMODS.add_card{ set = "Joker", key_append = self.key }
                end
                G.hand_text_area.blind_chips:juice_up()
                G.hand_text_area.game_chips:juice_up()
                play_sound('tarot1')
                return true
            end
        }))
    end,
    attributes = { "prevents_death", "generation", "joker", },
    forcetrigger_compat = true,
    blueprint_compat = false,
}

HPR.StellarJoker {
    key = "buffoon",
    config = { extra = { cards = 2, values = {common = 3, uncommon = 2, rare = 1.5 }, scoring = {common = 10, uncommon = 1.5, rare = 1.1} }},
    loc_vars = function (self, info_queue, card)
        local cae = card.ability.extra
        local mods = card.ability.extra.values
        local mults = card.ability.extra.scoring
        return { vars = { cae.cards, mods.common, mods.uncommon, mods.rare, mults.common, mults.uncommon, mults.rare }}
    end,
    calculate = function (self, card, context)
        if (context.setting_blind or context.forcetrigger) and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            local mods = card.ability.extra.values
            local to_create = math.min(card.ability.extra.cards, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
            G.GAME.joker_buffer = G.GAME.joker_buffer + to_create
            G.E_MANAGER:add_event(Event{
                func = function ()
                    local cards = {}
                    for _ = 1, to_create do
                        cards[#cards+1] = SMODS.add_card{
                            set = "Joker",
                            edition = SMODS.poll_edition{ guaranteed = true, key_append = self.key.."_edition" },
                            key_append = self.key
                        }
                    end
                    for _, c in ipairs(cards) do
                        local rarity = HPR.rarity_to_string(c.config.center.rarity)
                        local weight = rarity and SMODS.Rarities[rarity] and SMODS.Rarities[rarity].default_weight or 0
                        if rarity == "Common" or weight >= SMODS.Rarities.Common.default_weight then
                            Spectrallib.manipulate(c, { value = mods.common, type = "X" })
                        elseif rarity == "Uncommon" or weight >= SMODS.Rarities.Uncommon.default_weight then
                            Spectrallib.manipulate(c, { value = mods.uncommon, type = "X"})
                        elseif rarity == "Rare" or weight >= SMODS.Rarities.Rare.default_weight then
                            Spectrallib.manipulate(c, { value = mods.rare, type = "X" })
                        end
                    end
                    G.GAME.joker_buffer = 0
                    return true
                end
            })
            return {
                message = localize("k_plus_joker"),
            }
        end
        if context.other_joker and context.other_joker ~= card then
            local mults = card.ability.extra.scoring
            local rarity = HPR.rarity_to_string(context.other_joker.config.center.rarity)
            local weight = rarity and (SMODS.Rarities[rarity].default_weight or 0) or math.huge
            if weight >= SMODS.Rarities.Common.default_weight then
                return { mult = mults.common }
            elseif weight >= SMODS.Rarities.Uncommon.default_weight then
                return { xmult = mults.uncommon }
            else
                return { emult = mults.rare }
            end
        end
    end,
    attributes = { "joker", "mult", "xmult", "emult", "modify_card", },
}
--[[
HPR.StellarJoker {
    key = "hunter",
    config = { extra = 2 },
    forcetrigger_compat = true,
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra}}
    end,
    calculate = function (self, card, context)
        if context.setting_blind and not context.blueprint and context.blind.boss then
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
        end
        if context.post_trigger and context.other_card.is_rarity and context.other_card:is_rarity("hpr_boss") then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra
            return { dollars = card.ability.extra, func = HPR.event_presets.reset_dollar_buffer }
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        if G.GAME.blind and G.GAME.blind.boss and not G.GAME.blind.disabled then
            G.GAME.blind:disable()
            play_sound('timpani')
            SMODS.calculate_effect({ message = localize('ph_boss_disabled') }, card)
        end
    end,
    attributes = { "economy", }, --this one def needs a rework but whatever 
}
]]