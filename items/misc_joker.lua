SMODS.Joker { --fusion reactor, balances before scoring
    key = "fusion",
    atlas = "placeholder",
    pos = { x = 1, y = 0 },
    rarity = 2,
    cost = 7,
    blueprint_compat = true,
    demicoloncompat = true,
    calculate = function(self, card, context)
        if context.initial_scoring_step or context.forcetrigger then
            return {
                balance = true
            }
        end
    end,
    hpr_credits = {
        idea = {"Eris"}
    }
}

SMODS.Joker { --growth, increases potency of other joker effects
    key = "growth",
    atlas = "joker",
    pos = { x = 3, y = 0 },
    config = { extra = { eff_mod = 1, scale = 0.05 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.eff_mod, card.ability.extra.scale } }
    end,
    rarity = 3,
    cost = 10,
    perishable_compat = false,
    demicoloncompat = true,
    calculate = function(self, card, context)
        if (context.end_of_round and context.main_eval and not context.blueprint) or context.forcetrigger then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "eff_mod",
                scalar_value = "scale"
            })
        end
    end,
    hpr_credits = {
        code = {"Eris"},
        idea = {"Eris"},
        art = {"Eris"}
    },
}


SMODS.Joker { -- solar flare, levels up not most played hands and destroys some cards
    key = "solar",
    atlas = "joker",
    pos = { x = 0, y = 0 },
    config = { extra = { destroyed = 2 } },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.destroyed } }
    end,
    rarity = 3,
    cost = 10,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.before and G.GAME.current_round.hands_played == 0 then
            local _handname, _played = 'High Card', -1
            for hand_key, hand in pairs(G.GAME.hands) do
                if hand.played > _played then
                    _played = hand.played
                    _handname = hand_key
                end
            end
            if context.scoring_name ~= _handname then
                local options = {}
                for _, c in ipairs(G.play.cards) do
                    if not SMODS.is_eternal(c) then options[#options+1] = c end
                end
                for _ = 1, math.min(card.ability.extra.destroyed, #options) do
                    local roll, pos = pseudorandom_element(options, "hpr_solar")
                    roll.hpr_solar_destroy = true
                    table.remove(options, pos)
                end
                return {
                    level_up = 1,
                    message = localize("k_upgrade_ex"),
                    colour = G.C.GREEN
                }
            end
        end
        if context.destroy_card and not context.blueprint and G.GAME.current_round.hands_played == 0 then
            local _handname, _played = 'High Card', -1
            for hand_key, hand in pairs(G.GAME.hands) do
                if hand.played > _played then
                    _played = hand.played
                    _handname = hand_key
                end
            end
            if context.scoring_name ~= _handname and context.destroy_card.hpr_solar_destroy then
                return { remove = true }
            end
        end
    end,
    hpr_credits = {
        art = {"Codifyd"},
        code = {"Eris"},
        idea = {"Codifyd"}
    }
}

SMODS.Joker { --tipping scales, increases numerator and denominator of probabilities
    key = "scales",
    atlas = "placeholder",
    pos = { x = 0, y = 0 },
    config = { extra = { mod = 1 } },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.mod } }
    end,
    rarity = 1,
    cost = 5,
    calculate = function (self, card, context)
        if context.mod_probability and not context.blueprint then
            return {
                numerator = context.numerator + card.ability.extra.mod,
                denominator = context.denominator + card.ability.extra.mod
            }
        end
    end,
    hpr_credits = {
        code = {"Eris"},
        idea = {"Eris"}
    }
}


SMODS.Joker { --gambling addict, scales from probability rolls
    key = "gambler",
    atlas = "placeholder",
    pos = { x = 2, y = 0 },
    config = { extra = { chips = 0, mult = 0, multiplier = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.multiplier } }
    end,
    rarity = 3,
    cost = 10,
    blueprint_compat = true,
    demicoloncompat = true,
    perishable_compat = false,
    calculate = function(self, card, context)
        if context.pseudorandom_result then
            if not context.result then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "chips",
                    scalar_value = "multiplier",
                    operation = function(ref_table, ref_value, initial, change)
                        ref_table[ref_value] = initial + change * context.denominator
                    end,
                    message = {
                        colour = G.C.CHIPS,
                        message_key = "a_chips"
                    }
                })
            elseif context.result then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "mult",
                    scalar_value = "multiplier",
                    operation = function(ref_table, ref_value, initial, change)
                        ref_table[ref_value] = initial + change * context.denominator
                    end,
                    message = {
                        colour = G.C.MULT,
                        message_key = "a_mult"
                    }
                })
            end
        end
        if context.joker_main or context.forcetrigger then
            return {
                chips = card.ability.extra.chips ~= 0 and card.ability.extra.chips or nil,
                mult = card.ability.extra.mult ~= 0  and card.ability.extra.mult or nil
            }
        end
    end,
    hpr_credits = {
        code = {"Eris"},
        idea = {"Eris"}
    }
}

SMODS.Joker { --fortune cookie, guarantees 6 probabilities and then creates a negative tarot
    key = "fortune",
    atlas = "placeholder",
    pos = { x = 1, y = 0 },
    config = { extra = 6 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra } }
    end,
    rarity = 2,
    cost = 6,
    demicoloncompat = true,
    eternal_compat = false,
    pools = { ["Food"] = true },
    calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint then
            if context.from_roll then
                card.ability.extra = card.ability.extra - 1
                if card.ability.extra <= 0 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card { set = 'Tarot', edition = 'e_negative' }
                            SMODS.destroy_cards(card, nil, nil, true)
                            return true
                        end
                    }))
                end
            end
            return {
                numerator = context.denominator
            }
        end
        if context.forcetrigger then
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card { set = 'Tarot', edition = 'e_negative' }
                end
            }))
        end
    end,
    hpr_credits = {
        code = {"Eris"},
        idea = {"Eris"}
    }
}

SMODS.Joker {
    key = "bungus",
    atlas = "placeholder",
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 5,
    demicoloncompat = true,
    blueprint_compat = true,
    calculate = function (self, card, context)
        if (context.after or context.forcetrigger) and #G.hand.cards > 0 then
            local _card = pseudorandom_element(G.hand.cards, "hpr_bungus") or {}
            assert(SMODS.modify_rank(_card, 1, true))
            return {
                message = localize("k_upgrade_ex"),
                func = function ()
                    G.E_MANAGER:add_event(Event({
                        func = function ()
                            if _card.juice_up then _card:juice_up() end
                            if _card.set_sprites then _card:set_sprites(_card.config.center, _card.config.card) end
                            return true
                        end
                    }))
                end
            }
        end
    end,
    hpr_credits = {
        code = {"Eris"},
        idea = {"Eris"}
    }
}

SMODS.Joker {
    key = "cavepaint",
    atlas = "placeholder",
    pos = { x = 1, y = 0 },
    rarity = 2,
    cost = 5,
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_stone
        local c = G.GAME.current_round.hpr_cavepaint_card
        if c and c.suit and c.rank and c.id then
            return { vars = { localize(c.rank, "ranks"), localize(c.suit, "suits_plural"), colours = { G.C.SUITS[c.suit] }}}
        else
            return { key = self.key .. "_none" }
        end
    end,
    hpr_credits = {
        code = {"Eris"},
        idea = {"Eris"}
    }
}

SMODS.Joker {
    key = "executive_card",
    atlas = "placeholder",
    pos = { x = 2, y = 0 },
    rarity = 3,
    cost = 10,
    add_to_deck = function (self, card, from_debuff)
        G.GAME.modifiers.booster_choice_mod = (G.GAME.modifiers.booster_choice_mod or 0) + 1000
    end,
    remove_from_deck = function (self, card, from_debuff)
        G.GAME.modifiers.booster_choice_mod = (G.GAME.modifiers.booster_choice_mod or 0) - 1000
    end,
    hpr_credits = {
        code = {"Eris"},
        idea = {"Eris"}
    }
}

SMODS.Joker {
    key = "7_ball",
    atlas = "joker",
    pos = { x = 2, y = 0 },
    rarity = 2,
    cost = 7,
    blueprint_compat = true,
    config = { extra = 7 },
    pools = { Meme = true },
    loc_vars = function (self, info_queue, card)
        local n, d = SMODS.get_probability_vars(card, 1, card.ability.extra, "hpr_7_ball")
        return { vars = { n, d }}
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and
            #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if (context.other_card:get_id() == 7) and SMODS.pseudorandom_probability(card, 'hpr_7_ball', 1, card.ability.extra) then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                return {
                    extra = {
                        message = localize('k_plus_spectral'),
                        colour = G.C.SECONDARY_SET.Spectral,
                        message_card = card,
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                func = (function()
                                    SMODS.add_card {
                                        set = 'Spectral',
                                        key_append = 'hpr_7_ball'
                                    }
                                    G.GAME.consumeable_buffer = 0
                                    return true
                                end)
                            }))
                        end
                    },
                }
            end
        end
    end,
    hpr_credits = {
        code = {"Eris"},
        idea = {"Eris"}
    }
}

SMODS.Joker {
    key = "double_dice",
    atlas = "placeholder",
    pos = { x = 2, y = 0 },
    rarity = 3,
    cost = 9,
    blueprint_compat = true,
    config = { extra = { chip_min = 1, chip_max = 20, mult_min = 1, mult_max = 6 }},
    loc_vars = function (self, info_queue, card)
        local e = card.ability.extra
        return { vars = { e.chip_min, e.chip_max, e.mult_min, e.mult_max }}
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play then
            local e = card.ability.extra
            context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + pseudorandom("hpr_dice", e.chip_min, e.chip_max)
            context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + pseudorandom("hpr_dice", e.mult_min, e.mult_max)
            return { message = localize("k_upgrade_ex")}
        end
    end
}

SMODS.Joker {
    key = "green_card",
    atlas = "joker",
    pos = { x = 1, y = 0 },
    rarity = 3,
    cost = 8,
    perishable_compat = false,
    config = { extra = { bonus = 0, gain = 0.25 }},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.bonus, card.ability.extra.gain, 1+card.ability.extra.bonus, 3+card.ability.extra.bonus }}
    end,
    calculate = function (self, card, context)
        if context.mod_probability and not context.blueprint then
            return {
                numerator = context.numerator + card.ability.extra.bonus,
                denominator = context.denominator + card.ability.extra.bonus
            }
        end
        if context.skipping_booster and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "bonus",
                scalar_value = "gain",
                message_colour = G.C.GREEN
            })
            return nil, true
        end
    end,
    hpr_credits = {
        code = {"Eris"},
        idea = {"Eris"}
    }
}

SMODS.Joker {
    key = "ghost",
    atlas = "placeholder",
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    demicoloncompat = true,
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_TAGS.tag_ethereal
        return { vars = { localize { type = 'name_text', set = 'Tag', key = 'tag_ethereal' } } }
    end,
    calculate = function (self, card, context)
        if context.end_of_round and context.beat_boss and context.main_eval then
            G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag(Tag('tag_ethereal'))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end)
            }))
            return nil, true
        end
    end,
    hpr_credits = {
        code = {"Eris"},
        idea = {"Eris"}
    }
}

SMODS.Joker {
    key = "takeout_box",
    atlas = "placeholder",
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    demicoloncompat = true,
    calculate = function (self, card, context)
        if context.end_of_round and context.main_eval and context.beat_boss then
            G.E_MANAGER:add_event(Event{
                func = function ()
                    SMODS.add_card{
                        set = "Food",
                        edition = "e_negative",
                        area = G.jokers
                    }
                    return true
                end
            })
            return { message = localize("k_plus_joker")}
        end
    end,
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.e_negative
    end,
    hpr_credits = {
        code = {"Eris"},
        idea = {"Eris"}
    }
}

SMODS.Joker {
    key = "slot_machine",
    atlas = "placeholder",
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 5,
    blueprint_compat = true, --why would you even want this?
    demicoloncompat = true,
    pools = { Meme = true },
    config = { extra = { loss = 2, dollars = 5, funny = 67 }},
    loc_vars = function (self, info_queue, card)
        local stake_id = G.GAME.stake
        local stake_key = stake_id and G.P_CENTER_POOLS.Stake[stake_id] and G.P_CENTER_POOLS.Stake[stake_id].key or "stake_white"
        local stake_colour = stake_id and G.P_CENTER_POOLS.Stake[stake_id] and G.P_CENTER_POOLS.Stake[stake_id].colour or G.C.UI.TEXT_DARK
        stake_colour = stake_colour ~= G.C.WHITE and stake_colour or G.C.UI.TEXT_DARK
        local name = stake_key and localize{ type = "name_text", set = "Stake", key = stake_key } or localize("k_none")
        local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.funny, "hpr_slot_machine")
        return { vars = { card.ability.extra.loss, card.ability.extra.dollars, card.ability.extra.funny, num, denom, name, colours = { stake_colour } }}
    end,
    calculate = function (self, card, context)
        if context.before then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.loss
            return {
                dollars = -card.ability.extra.loss,
                func = function() -- This is for timing purposes, it runs after the dollar manipulation
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
    calc_dollar_bonus = function (self, card)
        local amt = card.ability.extra.dollars
        if SMODS.pseudorandom_probability(card, "hpr_slot_machine", 1, card.ability.extra.funny) then
            amt = amt*card.ability.extra.funny
        end
        return amt
    end
}

SMODS.Joker {
    key = "derivative",
    atlas = "placeholder",
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 5,
    config = { extra = { multiplier = 10, active = true }},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.multiplier }}
    end,
    calculate = function (self, card, context)
        if context.before or context.after then
            card.ability.extra.active = true
        end
    end,
}

SMODS.Joker {
    key = "antiderivative",
    atlas = "placeholder",
    pos = { x = 2, y = 0 },
    rarity = 3,
    cost = 6,
    config = { extra = 0.05 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra }}
    end,
}

SMODS.Joker {
    key = "new_meme",
    atlas = "placeholder",
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 6,
    blueprint_compat = true,
    pools = { Meme = true },
    config = { extra = { rank1 = "6", rank2 = "7" }},
    loc_vars = function (self, info_queue, card)
        return { vars = { localize(card.ability.extra.rank1, "ranks"), localize(card.ability.extra.rank2, "ranks")}}
    end,
    set_ability = function (self, card, initial, delay_sprites)
        if initial then
            card.ability.extra.rank1 = pseudorandom_element(SMODS.Ranks, "hpr_meme_rank1").key
            card.ability.extra.rank2 = pseudorandom_element(SMODS.Ranks, "hpr_meme_rank2").key
        end
    end,
    calculate = function (self, card, context)
        if context.before then
            local rank1, rank2
            for _, c in ipairs(context.full_hand) do
                if c:get_id() == SMODS.Ranks[card.ability.extra.rank1].id then rank1 = true end
                if c:get_id() == SMODS.Ranks[card.ability.extra.rank2].id then rank2 = true end
            end
            if rank1 and rank2 and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                SMODS.add_card {
                                    set = 'Joker',
                                    key_append = 'hpr_new_meme'
                                }
                                G.GAME.joker_buffer = 0
                                return true
                            end
                        }))
                        SMODS.calculate_effect({ message = localize('k_plus_joker'), colour = G.C.FILTER },
                            context.blueprint_card or card)
                        return true
                    end)
                }))
                return nil, true
            end
        end
        if context.end_of_round and context.main_eval then
            card.ability.extra.rank1 = pseudorandom_element(SMODS.Ranks, "hpr_meme_rank1").key
            card.ability.extra.rank2 = pseudorandom_element(SMODS.Ranks, "hpr_meme_rank2").key
            return { message = localize("k_reset")}
        end
    end
}

SMODS.Joker {
    key = "tiny_chad",
    pos = { x = 9, y = 6 },
    display_size = { w = 71 * 0.7, h = 95 * 0.7 },
    rarity = 3,
    cost = 9,
    immutable = true,
    calculate = function (self, card, context)
        if context.before and G.GAME.current_round.hands_played == 0 and #context.full_hand == 1 and context.full_hand[1]:get_id() == 2 then
            local c = context.full_hand[1]
            c.ability.perma_repetitions = c.ability.perma_repetitions + 1
            return {
                message = localize("k_upgrade_ex"),
                message_card = c
            }
        end
    end,
    pools = { wee = true }
}

SMODS.Joker {
    key = "hype_moments",
    atlas = "placeholder",
    pos = { x = 1, y = 0 },
    rarity = 2,
    cost = 7,
    blueprint_compat = true,
    calculate = function (self, card, context)
        if context.end_of_round and context.main_eval and context.beat_boss and SMODS.last_hand_oneshot then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = (function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card {
                                set = 'Spectral',
                                key_append = 'hpr_hyper_moments',
                                key = "c_aura"
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                    SMODS.calculate_effect({ message = localize('k_plus_aura'), colour = G.C.SECONDARY_SET.Spectral },
                        context.blueprint_card or card)
                    return true
                end)
            }))
            return nil, true
        end
    end,
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_aura
        return { vars = { localize{ type = "name_text", key = "c_aura", set = "Spectral"}}}
    end
}

SMODS.Joker {
    key = "plarva",
    atlas = "placeholder",
    pos = { x = 1, y = 0 },
    rarity = 2,
    cost = 6,
    eternal_compat = false,
    calculate = function (self, card, context)
        if context.game_over and not context.blueprint and context.main_eval then
            local all_eternal = true
            for _, c in ipairs(G.consumeables.cards) do
                if not SMODS.is_eternal(c) then all_eternal = false end
            end
            if all_eternal and #G.consumeables.cards >= G.consumeables.config.card_limit then return end
            SMODS.destroy_cards(G.consumeables.cards)
            G.E_MANAGER:add_event(Event{
                func = function ()
                    for _ = 1, G.consumeables.config.card_limit - #G.consumeables.cards - G.GAME.consumeable_buffer do
                        SMODS.add_card{
                            set = "Spectral",
                            stickers = {"eternal"},
                            key_append = "hpr_plarva",
                            force_stickers = true
                        }
                    end
                    card:start_dissolve({G.C.HPR_STLR})
                    return true
                end
            })
            return {
                message = localize("k_saved_q"),
                saved = "ph_hpr_plarva",
                colour = G.C.HPR_STLR
            }
        end
    end,
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = { key = "eternal", set = "Other"}
    end,
    inversion = "j_mr_bones"
}

SMODS.Joker {
    key = "diamond_shape_with_a_dot_inside",
    atlas = "placeholder",
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 6,
    blueprint_compat = true,
    config = { extra = 1.2 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra }}
    end,
    calculate = function (self, card, context)
        if context.individual and context.other_card:is_suit("Diamonds") and context.cardarea == G.play then
            return {
                xmult = card.ability.extra
            }
        end
    end
}

SMODS.Joker {
    key = "ult_meal",
    atlas = "placeholder",
    pos = { x = 2, y = 0 },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    config = { extra = 3 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra }}
    end,
    calculate = function (self, card, context)
        if context.hpr_retrigger_probability then
            return { repetitions = card.ability.extra }
        end
    end,
    hpr_ascension_key = "j_hpr_lucky",
}

SMODS.Joker {
    key = "tiny_graph",
    pos = { x = 2, y = 13 },
    pixel_size = { h = 95 / 1.2 },
    display_size = { w = 71 * 0.7, h = 95/1.2 * 0.7 },
    rarity = 1,
    cost = 3,
    blueprint_compat = true,
    config = { extra = 2 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra }}
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 2 then
            local p = false
            for _, c in ipairs(context.scoring_hand) do
                if c:get_id() == 2 then
                    p = c == context.other_card
                    break
                end
            end
            if p then return { xmult = card.ability.extra } end
        end
    end,
    pools = { wee = true }
}

SMODS.Joker {
    key = "copier",
    atlas = "placeholder",
    pos = { x = 2, y = 0 },
    rarity = 3,
    cost = 10,
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.e_negative
        info_queue[#info_queue+1] = { set = 'Other', key = 'perishable', vars = { G.GAME.perishable_rounds, G.GAME.perishable_rounds }}
    end,
    calculate = function (self, card, context)
        if context.end_of_round and context.main_eval and context.beat_boss then
            local c = G.jokers.cards[#G.jokers.cards]
            if c and c.config.center.key ~= "j_hpr_copier" then
                G.E_MANAGER:add_event(Event{
                    func = function ()
                        local copy = copy_card(c)
                        copy:set_edition('e_negative', true)
                        copy:add_sticker('perishable', true)
                        copy:add_to_deck()
                        G.jokers:emplace(copy)
                        return true
                    end
                })
                return { message = localize("k_duplicated_ex") }
            end
        end
    end
}

SMODS.Joker {
    key = "rent",
    atlas = "placeholder",
    pos = { x = 1, y = 0 },
    rarity = 2,
    cost = 7,
    eternal_compat = false,
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = { set = "Other", key = "perishable", vars = { G.GAME.perishable_rounds, G.GAME.perishable_rounds }}
        info_queue[#info_queue+1] = { set = "Other", key = "rental", vars = { G.GAME.rental_rate }}
    end,
    calculate = function (self, card, context)
        if context.selling_self and (#G.jokers.cards + G.GAME.joker_buffer) < G.jokers.config.card_limit then
            G.GAME.joker_buffer = (G.GAME.joker_buffer or 0) + 1
            G.E_MANAGER:add_event(Event{
                func = function ()
                    SMODS.add_card{
                        rarity = "Rare",
                        set = "Joker",
                        stickers = {"rental", "perishable"},
                        force_stickers = true,
                        key_append = "hpr_rent_joker"
                    }
                    G.GAME.joker_buffer = 0
                    return true
                end
            })
            return { message = localize("k_plus_joker"), colour = G.C.RARITY[3] }
        end
    end
}

SMODS.Joker {
    key = "genius_horse",
    atlas = "placeholder",
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    calculate = function (self, card, context)
        if context.joker_main then
            return {
                mult = (hand_chips or 0)^(1/3)
            }
        end
    end
}

SMODS.Joker {
    key = "fossil",
    atlas = "placeholder",
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 5,
    add_to_deck = function (self, card, from_debuff)
        ease_ante(-1)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - 1
    end,
    remove_from_deck = function (self, card, from_debuff)
        ease_ante(1)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + 1
    end
}

SMODS.Joker {
    key = "good_bomb",
    atlas = "placeholder",
    pos = { x = 1, y = 0 },
    rarity = 2,
    cost = 7,
    eternal_compat = false,
    config = { extra = { rounds = 3, cards = 5 }},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.rounds, card.ability.extra.cards }}
    end,
    calculate = function (self, card, context)
        if context.end_of_round and context.main_eval and not context.retrigger_joker then
            card.ability.extra.rounds = card.ability.extra.rounds - 1
            if card.ability.extra.rounds <= 0 then
                for _ = 1, card.ability.extra.cards do
                    local c = pseudorandom_element(G.playing_cards, "hpr_good_bomb", { in_pool = function(v,args) return not v.edition and not v.will_be_editioned end})
                    if c and c.set_edition then
                        c.will_be_editioned = true
                        local ed = SMODS.poll_edition{ key = "hpr_bomb_edition", guaranteed = true, no_negative = true }
                        c:set_edition(ed, nil, true, true)
                        c.will_be_editioned = nil
                    end
                end
                G.E_MANAGER:add_event(Event{
                    func = function ()
                        card:start_dissolve()
                        return true
                    end
                })
            else
                return { message = localize{ type = "variable", key = "a_remaining", vars = { card.ability.extra.rounds} }}
            end
        end
    end
}

SMODS.Joker {
    key = "paint_bucket",
    atlas = "placeholder",
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 6,
    eternal_compat = false,
    config = { extra = 3 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra }}
    end,
    calculate = function (self, card, context)
        if context.before and not context.blueprint then
            local enh = 0
            for _, c in ipairs(context.scoring_hand) do
                if next(SMODS.get_enhancements(c)) and not c.debuff and not c.vampired then
                    enh = enh+1
                    c.vampired = true
                    c:set_ability("c_base", nil, true)
                    G.E_MANAGER:add_event(Event{
                        func = function ()
                            c:juice_up()
                            c.vampired = nil
                            return true
                        end
                    })
                end
            end
            if enh ~= 0 then
                return { message = localize("k_hpr_painted_ex") }
            else
                SMODS.destroy_cards(card, nil, nil, true)
                return { message = localize("k_drank_ex") }
            end
        end
    end,
    add_to_deck = function (self, card, from_debuff)
        G.hand:change_size(card.ability.extra)
    end,
    remove_from_deck = function (self, card, from_debuff)
        G.hand:change_size(-card.ability.extra)
    end,
    pools = { Food = true },
    hpr_credits = {
        idea = {"Eris"},
        code = {"Eris"},
    }
}

SMODS.Joker {
    key = "benthic",
    atlas = "placeholder",
    pos = { x = 1, y = 0 },
    rarity = 2,
    cost = 7,
    config = { extra = 0.5 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra }}
    end,
    add_to_deck = function (self, card, from_debuff)
        G.GAME.common_mod = (G.GAME.common_mod or 1) * card.ability.extra
    end,
    remove_from_deck = function (self, card, from_debuff)
        G.GAME.common_mod = (G.GAME.common_mod or 1) / card.ability.extra
    end,
    inversion = "j_oops"
}

SMODS.Joker {
    key = "blue_wee",
    pos = { x = 7, y = 10 },
    display_size = { w = 71 * 0.7, h = 95 * 0.7 },
    rarity = 2,
    cost = 7,
    blueprint_compat = true,
    config = { extra = 10 },
    loc_vars = function (self, info_queue, card)
        local two = 0
        if G.playing_cards then
            for _, c in ipairs(G.playing_cards) do
                if c:get_id() == 2 then two = two+1 end
            end
        else
            two = 4
        end
        return { vars = { card.ability.extra, card.ability.extra*two }}
    end,
    calculate = function (self, card, context)
        if context.joker_main then
            local two = 0
            for _, c in ipairs(G.playing_cards) do
                if c:get_id() == 2 then two = two+1 end
            end
            if two ~= 0 then
                return { chips = card.ability.extra*two }
            end
        end
    end,
    pools = { wee = true }
}

SMODS.Joker {
    key = "petit_michel",
    blueprint_compat = true,
    eternal_compat = false,
    rarity = 1,
    cost = 5,
    pos = { x = 7, y = 6 },
    display_size = { w = 71 * 0.7, h = 95 * 0.7 },
    config = { extra = { mult = 10, odds = 3 }},
    loc_vars = function (self, info_queue, card)
        local n, d = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, self.key)
        return { vars = { card.ability.extra.mult, n, d }}
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 2 then
            return { mult = card.ability.extra.mult }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, self.key, 1, card.ability.extra.odds) then
                SMODS.destroy_cards(card, nil, nil, true)
                G.GAME.pool_flags.hpr_wee_michel_extinct = true
                return {
                    message = localize('k_extinct_ex')
                }
            else
                return {
                    message = localize('k_safe_ex')
                }
            end
        end
    end,
    in_pool = function (self, args)
        return not G.GAME.pool_flags.hpr_wee_michel_extinct
    end,
    pools = { wee = true, Food = true }
}

SMODS.Joker {
    key = "averagedish",
    blueprint_compat = true,
    eternal_compat = false,
    rarity = 3,
    cost = 8,
    pos = { x = 5, y = 11 },
    display_size = { w = 71 * 0.7, h = 95 * 0.7 },
    config = { extra = { odds = 6, xmult = 2 }},
    loc_vars = function (self, info_queue, card)
        local n, d = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, self.key)
        return { vars = { card.ability.extra.xmult, n, d }}
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 2 then
            return { xmult = card.ability.extra.xmult }
        end
        if context.destroy_card and context.cardarea == G.play and context.destroy_card:get_id() == 2 and SMODS.pseudorandom_probability(card, self.key, 1, card.ability.extra.odds ) then
            return { remove = true }
        end
    end,
    in_pool = function (self, args)
        return G.GAME.pool_flags.hpr_wee_michel_extinct
    end,
    pools = { wee = true, Food = true }
}

SMODS.Joker {
    key = "mealy_apple",
    blueprint_compat = true,
    eternal_compat = false,
    rarity = 1,
    cost = 5,
    atlas = "placeholder",
    pos = {x=0,y=0},
    config = { extra = { mult = 1, discards = 5 }},
    loc_vars = function (self, info_queue, card)
        return{ vars = { card.ability.extra.mult, card.ability.extra.discards, card.ability.extra.discards ~= 1 and "s" or "" }}
    end,
    calculate = function (self, card, context)
        if context.discard then
            context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra.mult
            local c=context.other_card
            SMODS.calculate_effect({ message = localize("k_upgrade_ex"), message_card = c, juice_card = card, colour = G.C.MULT }, card)
            if context.other_card == context.full_hand[#context.full_hand] then
                card.ability.extra.discards = card.ability.extra.discards - 1
                if card.ability.extra.discards <= 0 then
                    SMODS.destroy_cards(card, nil, nil, true)
                    SMODS.calculate_effect({message = localize("k_eaten_ex")}, card)
                end
            end
            return nil, true
        end
    end,
    pools = { Food = true }
}

SMODS.Joker {
    key = "2_ball",
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    atlas = "joker",
    pos = { x = 4, y = 0 },
    display_size = { w = 71 * 0.7, h = 95 * 0.7 },
    config = { extra = 4 },
    loc_vars = function (self, info_queue, card)
        local n,d=SMODS.get_probability_vars(card,1,card.ability.extra,self.key)
        info_queue[#info_queue+1] = G.P_CENTERS.e_hpr_green
        info_queue[#info_queue+1] = G.P_CENTERS.c_hpr_green
        return{vars={n,d}}
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 2 and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and SMODS.pseudorandom_probability(card,self.key,1,card.ability.extra) then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            return {
                extra = {
                    message = localize{ type = "variable", key = "a_hpr_green", vars={1}},
                    colour = G.C.HPR_ULTRAGREEN,
                    func = function ()
                        G.E_MANAGER:add_event(Event{
                            func = function ()
                                SMODS.add_card{
                                    set = "Tarot",
                                    key_append = "hpr_2_ball",
                                    edition = "e_hpr_green"
                                }
                                G.GAME.consumeable_buffer = 0
                                return true
                            end
                        })
                    end
                }
            }
        end
    end,
    pools = { wee = true, Meme = true }
}

SMODS.Joker {
    key = "apostrophe_m",
    rarity = 3,
    cost = 10,
    atlas = "placeholder",
    pos = { x = 2, y = 0 },
    loc_vars = function (self, info_queue, card)
        local ctypes = {}
        for k, v in pairs(SMODS.ConsumableTypes) do
            if not v.no_collection then ctypes[#ctypes+1] = {string=localize("b_"..k:lower().."_cards"), colour = v.secondary_colour or G.C.UI.TEXT_DARK } end
        end
        local main_start = {
            {
                n = G.UIT.O,
                config = {
                    object = DynaText{
                        string = ctypes,
                        colours = G.C.UI.TEXT_DARK,
                        pop_in_rate = 9999999,
                        silent = true,
                        random_element = true,
                        pop_delay = 0.3,
                        scale = 0.32,
                        min_cycle_time = 0
                    }
                }
            }
        }
        local main_end = {
            {
                n = G.UIT.O,
                config = {
                    object = DynaText{
                        string = ctypes,
                        colours = G.C.UI.TEXT_DARK,
                        pop_in_rate = 9999999,
                        silent = true,
                        random_element = true,
                        pop_delay = 0.3,
                        scale = 0.32,
                        min_cycle_time = 0
                    }
                }
            }
        }
        return { main_start = main_start, main_end = main_end }
    end,
    hpr_ascension_key = "j_hpr_missing"
}

SMODS.Joker {
    key = "glass_shard",
    blueprint_compat = true,
    rarity = 1,
    cost = 6,
    atlas = "placeholder",
    pos = { x = 0, y = 0 },
    config = { extra = { xmult = 2, odds = 4 }},
    loc_vars = function (self, info_queue, card)
        local n,d = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, self.key)
        return{ vars = {card.ability.extra.xmult, n, d }}
    end,
    calculate = function (self, card, context)
        if context.joker_main then
            return { xmult = card.ability.extra.xmult }
        end
        if context.destroy_card and not context.blueprint and context.destroy_card == context.scoring_hand[1] and SMODS.pseudorandom_probability(card, self.key, 1, card.ability.extra.odds) then
            context.destroy_card.hpr_force_shatter = true
            return { remove = true }
        end
    end
}

SMODS.Joker {
    key = "ceramic",
    blueprint_compat = true,
    eternal_compat = false,
    rarity = 1,
    cost = 5,
    atlas = "placeholder",
    pos = { x = 0, y = 0 },
    config = { extra = { chips = 100, discards = 40 }},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.discards } }
    end,
    calculate = function (self, card, context)
        if context.joker_main then
            return { chips = card.ability.extra.chips }
        end
        if context.discard and not context.blueprint then
            card.ability.extra.discards = card.ability.extra.discards - 1
            if card.ability.extra.discards <= 0 then
                G.GAME.pool_flags.hpr_ceramic_shattered = true
                SMODS.destroy_cards(card)
            end
        end
    end,
    no_pool_flag = "hpr_ceramic_shattered"
}

SMODS.Joker {
    key = "fine_china",
    blueprint_compat = true,
    eternal_compat = false,
    rarity = 1,
    cost = 8,
    atlas = "placeholder",
    pos = { x = 0, y = 0 },
    config = { extra = { xchip = 4, max_discard = 4 }},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.xchip, card.ability.extra.max_discard }}
    end,
    calculate = function (self, card, context)
        if context.joker_main then
            return { xchips = card.ability.extra.xchip }
        end
        if context.pre_discard and #context.full_hand > card.ability.extra.max_discard then
            SMODS.destroy_cards(card)
        end
    end,
    yes_pool_flag = "hpr_ceramic_shattered"
}

SMODS.Joker {
    key = "butterfinger",
    eternal_compat = false,
    rarity = 2,
    cost = 7,
    atlas = "placeholder",
    pos = { x = 1, y = 0 },
    config = { extra = 1 },
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra, card.ability.extra ~= 1 and "s" or ""}}
    end,
    calculate = function (self, card, context)
        if context.end_of_round and context.main_eval then
            card.ability.extra = card.ability.extra + 1
            if card.ability.extra >= 5 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize("k_eaten_ex")
                }
            else
                return { message = localize{ type = "variable", vars = {card.ability.extra}, key = "hpr_n_cards"}}
            end
        end
    end
}

SMODS.Joker {
    key = "superfluid",
    blueprint_compat = true, --i guess bro
    rarity = 2,
    cost = 8,
    atlas = "placeholder",
    pos = { x = 1, y = 0 },
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play then
            local starting_chips = context.other_card:get_chip_bonus()
            local starting_mult = context.other_card:get_chip_mult()
            local target = (starting_chips+starting_mult)/2
            context.other_card.ability.perma_bonus = -starting_chips+target
            context.other_card.ability.perma_mult = -starting_mult+target
            return {
                message = localize("k_balanced"),
                sound = "gong",
                volume = 0.3,
                pitch = 0.94,
                colour = {0.8, 0.45, 0.85, 1}
            }
        end
    end
}

SMODS.Joker {
    key = "cloud_2",
    rarity = 2,
    cost = 7,
    atlas = "joker",
    pos = { x = 5, y = 0 },
    display_size = { w = 71 * 0.7, h = 95 * 0.7 },
    config = { extra = { dollars = 1 } },
    loc_vars = function(self, info_queue, card)
        local two_tally = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card:get_id() == 2 then two_tally = two_tally + 1 end
            end
        end
        return { vars = { card.ability.extra.dollars, card.ability.extra.dollars * two_tally } }
    end,
    calc_dollar_bonus = function(self, card)
        local two_tally = 0
        for _, playing_card in ipairs(G.playing_cards) do
            if playing_card:get_id() == 2 then two_tally = two_tally + 1 end
        end
        return two_tally > 0 and card.ability.extra.dollars * two_tally or nil
    end,
    pools = { wee = true }
}

SMODS.Joker {
    key = "wee_remote",
    rarity = 2,
    cost = 4,
    pos = { x = 8, y = 15 },
    display_size = { w = 71 * 0.7, h = 95 * 0.7 },
    config = { extra = { xmult = 1.2, xchip = 1.2 }},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xchip }}
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 2 then
            return {
                xmult = card.ability.extra.xmult,
                xchips = card.ability.extra.xchip
            }
        end
    end
}

SMODS.Joker {
    key = "night",
    rarity = 3,
    cost = 8,
    atlas = "placeholder",
    pos = { x = 2, y = 0 },
    config = { extra = 2 },
    loc_vars = function (self, info_queue, card)
        local n,d = SMODS.get_probability_vars(card, 1, card.ability.extra, self.key)
        return { vars = {n,d}}
    end,
    calculate = function (self, card, context)
        if context.retrigger_joker_check and not context.retrigger_joker and not (G.GAME.blind and G.GAME.blind.in_blind) and SMODS.pseudorandom_probability(card, self.key, 1, card.ability.extra) then
            return { repetitions = 1 }
        end
    end
}

SMODS.Joker {
    key = "sprout",
    rarity = 3,
    cost = 9,
    eternal_compat = false,
    atlas = "placeholder",
    pos = { x = 2, y = 0 },
    config = { extra = { h_size = 1, rounds = 2, current = 0 }},
    pools = { Food = true },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.h_size, card.ability.extra.rounds, card.ability.extra.current }}
    end,
    calculate = function (self, card, context)
        if context.end_of_round and not context.game_over and context.main_eval then
            card.ability.extra.current = card.ability.extra.current + 1
            if card.ability.extra.current >= card.ability.extra.rounds then
                local eval = function(card) return not card.REMOVED end
                juice_card_until(card, eval, true)
            end
            return {
                message = (card.ability.extra.current < card.ability.extra.rounds) and
                    (card.ability.extra.current .. '/' .. card.ability.extra.rounds) or
                    localize('k_active_ex'),
                colour = G.C.FILTER
            }
        end
        if context.selling_self then
            G.hand:change_size(card.ability.extra.h_size)
            return { message = localize{type = "variable", key = "a_handsize", vars = {card.ability.extra.h_size}}}
        end
    end
}

SMODS.Joker {
    key = "softball",
    rarity = 2,
    cost = 7,
    pos = { x = 6, y = 14 },
    display_size = { w = 71 * 0.7, h = 95 * 0.7 },
    config = { extra = 1.5 },
    pools = { wee = true },
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra} }
    end,
    calculate = function (self, card, context)
        if context.other_joker and context.other_joker ~= card then
            local p = context.other_joker.config.center.pools
            if p and p.wee then
                return {
                    xmult = card.ability.extra
                }
            end
        end
    end
}