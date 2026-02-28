SMODS.Rarity {
    key = "boss",
    badge_colour = HEX("eddd22"),
}

HPR.BossJoker = SMODS.Joker:extend{
    rarity = "hpr_boss",
    cost = 10,
    atlas = "hpr_boss_joker"
}

HPR.BossJoker {
    key = "hook",
    pos = { x = 0, y = 0 },
    config = { extra = { discard = 2, reps = 2 }},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.discard, card.ability.extra.reps }}
    end,
    calculate = function (self, card, context)
        if (context.press_play or context.forcetrigger) and HPR.should_boss_downside() then
            G.E_MANAGER:add_event(Event{
                func = function ()
                    local b = false
                    for _ = 1, card.ability.extra.discard do
                        local selected = pseudorandom_element(G.hand.cards, "hpr_hook_j", {in_pool = function(v,args) return not v.highlighted end})
                        if selected then
                            G.hand:add_to_highlighted(selected,true)
                            b = true
                            play_sound("card1",1)
                        end
                    end
                    if b then G.FUNCS.discard_cards_from_highlighted(nil, true) end
                    return true
                end
            })
            delay(0.7)
            G.E_MANAGER:add_event(Event{
                trigger = "immediate",
                func = function ()
                    card:juice_up()
                    G.E_MANAGER:add_event(Event{
                        trigger = "after",
                        delay = 0.06*G.SETTINGS.GAMESPEED,
                        blockable = false,
                        blocking = false,
                        func = function ()
                            play_sound("tarot2", 0.76, 0.4) return true
                        end
                    })
                    play_sound("tarot2", 1, 0.4)
                    return true
                end
            })
            delay(0.4)
            return nil, true
        end
        if context.retrigger_joker_check and (context.other_context.discard  or context.other_context.pre_discard) then
            return { repetitions = card.ability.extra.reps }
        end
    end,
    boss_key = "bl_hook",
    forcetrigger_compat = true,
    blueprint_compat = true,
}

HPR.BossJoker {
    key = "ox",
    pos = { x = 1, y = 0 },
    calculate = function (self, card, context)
        if context.before then
            local reset = true
            local hand_played = G.GAME.hands[context.scoring_name].played
            for k, v in pairs(G.GAME.hands) do
                if k ~= context.scoring_name and v.played > hand_played and SMODS.is_poker_hand_visible(k) then
                    reset = false
                    break
                end
            end
            if reset and HPR.should_boss_downside() then
                ease_dollars(-G.GAME.dollars)
            else
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + hand_played
                return {
                    dollars = hand_played,
                    func = HPR.event_presets.reset_dollar_buffer
                }
            end
        end
    end,
    boss_key = "bl_ox",
    blueprint_compat = true,
}

HPR.BossJoker {
    key = "house",
    pos = { x = 2, y = 0 },
    config = { extra = 8 },
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra}}
    end,
    calculate = function (self, card, context)
        if context.stay_flipped and context.to_area == G.hand and G.GAME.current_round.discards_used == 0 and G.GAME.current_round.hands_played == 0 then
            context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra
            if HPR.should_boss_downside() then return { stay_flipped = true } end
        end
    end,
    boss_key = "bl_house",
    blueprint_compat = true,
}

HPR.BossJoker {
    key = "wall",
    pos = { x = 3, y = 0 },
    config = { extra = 2 },
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra}}
    end,
    calculate = function (self, card, context)
        if context.setting_blind and context.blind.boss or context.forcetrigger and G.GAME.blind.in_blind then
            if HPR.should_boss_downside() then HPR.mod_blind_amount(card.ability.extra) end
            ease_discard(G.GAME.current_round.discards_left * (card.ability.extra-1) )
            ease_hands_played(G.GAME.current_round.hands_left * (card.ability.extra - 1))
            return nil, true
        end
    end,
    boss_key = "bl_wall",
    forcetrigger_compat = true,
    blueprint_compat = true,
}

HPR.BossJoker {
    key = "wheel",
    pos = { x = 4, y = 0 },
    config = { extra = { odds = 7, xmult = 0.1 } },
    loc_vars = function (self, info_queue, card)
        local n,d = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, self.key)
        return { vars = {n,d,card.ability.extra.xmult}}
    end,
    calculate = function (self, card, context)
        if context.stay_flipped and context.to_area == G.hand and SMODS.pseudorandom_probability(card, self.key, 1, card.ability.extra.odds) then
            context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult + card.ability.extra.xmult
            if HPR.should_boss_downside() then return { stay_flipped = true } end
        end
    end,
    boss_key = "bl_wheel",
    blueprint_compat = true,
}

HPR.BossJoker {
    key = "arm",
    pos = { x = 5, y = 0 },
    config = { extra = { chips = 0, mult = 0 }},
    loc_vars = function (self, info_queue,card)
        return {vars = { card.ability.extra.chips, card.ability.extra.mult }}
    end,
    calculate = function (self, card, context)
        if context.before and G.GAME.hands[context.scoring_name].level > 1 and not context.blueprint then
            card.ability.extra.chips = card.ability.extra.chips + G.GAME.hands[context.scoring_name].l_chips
            card.ability.extra.mult = card.ability.extra.mult + G.GAME.hands[context.scoring_name].l_mult
            if HPR.should_boss_downside() then
                return {
                    level_up = -1,
                    message = localize("k_level_down"),
                    colour = G.C.RED
                }
            end
        end
        if context.joker_main or context.forcetrigger then
            local chips = card.ability.extra.chips
            local mult = card.ability.extra.mult
            return {
                chips = chips~=0 and chips or nil,
                mult = mult~=0 and mult or nil
            }
        end
    end,
    boss_key = "bl_arm",
    forcetrigger_compat = true,
    blueprint_compat = true
}

HPR.BossJoker {
    key = "club_boss",
    pos = { x = 0, y = 1 },
    config = { extra = 7 },
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra}}
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play or context.forcetrigger then
            return { mult = card.ability.extra }
        end
        if context.debuff_card and not context.blueprint and context.debuff_card:is_suit("Clubs", true) and HPR.should_boss_downside() then return { debuff = true } end
    end,
    boss_key = "bl_club",
    forcetrigger_compat = true,
    blueprint_compat = true,
}

HPR.BossJoker {
    key = "fish",
    pos = { x = 1, y = 1 },
    config = { extra = 25 },
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra}}
    end,
    calculate = function (self, card, context)
        if context.press_play then card.ability.prepped = true end
        if context.stay_flipped and card.ability.prepped then
            context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + card.ability.extra
            if HPR.should_boss_downside() then return { stay_flipped = true } end
        end
        if (context.hand_drawn or context.setting_blind) and not context.blueprint then card.ability.prepped = nil end
    end,
    boss_key = "bl_fish",
    blueprint_compat = true,
}

HPR.BossJoker{
    key = "psychic",
    pos = { x = 2, y = 1 },
    config = { extra = 5 },
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra}}
    end,
    calculate = function (self, card, context)
        if context.debuff_hand and not context.blueprint and #context.full_hand ~= card.ability.extra and HPR.should_boss_downside() then
            return {
                debuff = true,
                debuff_text = localize{ type = "variable", vars = {card.ability.extra}, key = "play_x_cards"},
                no_juice = context.check
            }
        end
        if context.repetition and context.cardarea == G.play then return { repetitions = 1 } end
    end,
    boss_key = "bl_psychic",
    blueprint_compat = true,
}

HPR.BossJoker {
    key = "goad",
    pos = { x = 3, y = 1 },
    config = { extra = 50 },
    loc_vars = function (self, info_queue, card)
        return{ vars = {card.ability.extra}}
    end,
    calculate = function (self, card, context)
        if context.debuff_card and not context.blueprint and context.debuff_card:is_suit("Spades", true) and HPR.should_boss_downside() then
            return { debuff = true }
        end
        if context.individual and context.cardarea == G.play or context.forcetrigger then
            return { chips = card.ability.extra}
        end
    end,
    boss_key = "bl_goad",
    forcetrigger_compat = true,
    blueprint_compat = true
}

HPR.BossJoker {
    key = "water",
    pos = { x = 4, y = 1 },
    config = { extra = 2 },
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra}}
    end,
    calculate = function (self, card, context)
        if context.setting_blind or context.forcetrigger then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local d_amt = G.GAME.current_round.discards_left
                    if HPR.should_boss_downside() then ease_discard(-d_amt, nil, true) end
                    ease_hands_played(d_amt * card.ability.extra)
                    SMODS.calculate_effect(
                        { message = localize { type = 'variable', key = 'a_hands', vars = { d_amt * card.ability.extra } } },
                        context.blueprint_card or card)
                    return true
                end
            }))
            return nil, true
        end
    end,
    boss_key = "bl_water",
    forcetrigger_compat = true,
    blueprint_compat = true,
}

HPR.BossJoker {
    key = "window",
    pos = { x = 5, y = 1 },
    config = { extra = 1 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra}}
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play or context.forcetrigger then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra
            return {
                dollars = card.ability.extra,
                func = HPR.event_presets.reset_dollar_buffer
            }
        end
        if context.debuff_card and not context.blueprint and context.debuff_card.is_suit and context.debuff_card:is_suit("Diamonds", true) and HPR.should_boss_downside() then
            return { debuff = true }
        end
    end,
    boss_key = "bl_window",
    forcetrigger_compat = true,
    blueprint_compat = true,
}

HPR.BossJoker {
    key = "manacle",
    pos = { x = 0, y = 2 },
    config = { extra = { h_size = 1, csl = 2}},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.h_size, card.ability.extra.csl }}
    end,
    calculate = function (self, card, context)
        local penalty, should = card.ability.extra.penalty_active, HPR.should_boss_downside()
        if penalty and not should then
            G.hand:change_size(card.ability.extra.h_size)
            card.ability.extra.penalty_active = false
        end
        if should and not penalty then
            G.hand:change_size(-card.ability.extra.h_size)
            card.ability.extra.penalty_active = true
        end
    end,
    add_to_deck = function (self, card, from_debuff)
        if HPR.should_boss_downside() and not card.ability.extra.penalty_active then
            G.hand:change_size(-card.ability.extra.h_size)
            card.ability.extra.penalty_active = true
        end
        SMODS.change_play_limit(card.ability.extra.csl)
        SMODS.change_discard_limit(card.ability.extra.csl)
    end,
    remove_from_deck = function (self, card, from_debuff)
        if card.ability.extra.penalty_active then
            G.hand:change_size(card.ability.extra.h_size)
            card.ability.extra.penalty_active = false
        end
        SMODS.change_play_limit(-card.ability.extra.csl)
        SMODS.change_discard_limit(-card.ability.extra.csl)
    end,
    boss_key = "bl_manacle"
}

HPR.BossJoker {
    key = "eye",
    pos = { x = 1, y = 2 },
    calculate = function (self, card, context)
        if context.debuff_hand and not context.blueprint and HPR.should_boss_downside() and G.GAME.hands[context.scoring_name].played_this_round > (context.check and 0 or 1) then
            return { debuff = true, debuff_text = localize("no_repeat_hands") }
        end
        if context.before then
            return {
                level_up = true,
                message = localize('k_level_up_ex')
            }
        end
    end,
    boss_key = "bl_eye",
    blueprint_compat = true,
}

HPR.BossJoker {
    key = "mouth",
    blueprint_compat = true, forcetrigger_compat = true,
    pos = { x = 2, y = 2 },
    config = { extra = { xmult = 5 }},
    loc_vars = function (self, info_queue, card)
        local hand_text = card.ability.extra.mouth_hand and localize(card.ability.extra.mouth_hand, "poker_hands") or localize("k_none")
        return { vars = { card.ability.extra.xmult, hand_text }}
    end,
    calculate = function (self, card, context)
        if context.before and HPR.should_boss_downside() and not context.blueprint then
            card.ability.extra.mouth_hand = context.scoring_name
        end
        if context.debuff_hand and not context.blueprint and card.ability.extra.mouth_hand and context.scoring_name ~= card.ability.extra.mouth_hand and HPR.should_boss_downside() then
            return { debuff = true, debuff_text = localize{ type = "variable", key = "must_play_x", vars = {localize(card.ability.extra.mouth_hand, "poker_hands")} }}
        end
        if context.joker_main or context.forcetrigger then
            return { xmult = card.ability.extra.xmult }
        end
        if (context.end_of_round and context.main_eval or context.setting_blind) and not context.blueprint then
            card.ability.extra.mouth_hand = nil
        end
    end,
    boss_key = "bl_mouth",
}

HPR.BossJoker {
    key = "plant",
    blueprint_compat = true, forcetrigger_compat = true,
    pos = { x = 3, y = 2 },
    config = { extra = 1.5 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra }}
    end,
    calculate = function (self, card, context)
        if context.debuff_card and not context.blueprint and HPR.should_boss_downside() and context.debuff_card.is_face and context.debuff_card:is_face(true) then
            return { debuff = true }
        end
        if context.individual and context.cardarea == G.play or context.forcetrigger then
            return { xmult = card.ability.extra }
        end
    end,
    boss_key = "bl_plant"
}

HPR.BossJoker {
    key = "serpent",
    pos = { x = 4, y = 2 },
    config = { extra = 3 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra }}
    end,
    calculate = function (self, card, context)
        if context.press_play or context.pre_discard then
            card.ability.prepped = true
        end
        if context.hand_drawn then card.ability.prepped = nil end
        if context.drawing_cards and card.ability.prepped then
            return { cards_to_draw = card.ability.extra }
        end
    end,
    boss_key = "bl_serpent"
}

HPR.BossJoker {
    key = "pillar",
    pos = { x = 5, y = 2 },
    calculate = function (self, card, context)
        if context.debuff_card and HPR.should_boss_downside() and context.debuff_card.ability.played_this_ante then
            return { debuff = true }
        end
        if context.before and context.full_hand[1] and G.GAME.current_round.hands_played == 0 then
            context.full_hand[1]:set_seal("Red")
        end
    end,
    boss_key = "bl_pillar"
}

HPR.BossJoker {
    key = "needle",
    pos = { x = 0, y = 3 },
    config = { extra = 2 },
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra}}
    end,
    calculate = function (self, card, context)
        if context.setting_blind or context.forcetrigger then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local h_amt = G.GAME.current_round.hands_left - 1
                    if HPR.should_boss_downside() then ease_hands_played(-h_amt) end
                    ease_discard(h_amt * card.ability.extra, nil, true)
                    SMODS.calculate_effect(
                        { message = localize { type = 'variable', key = 'a_discards', vars = { h_amt * card.ability.extra } } },
                        context.blueprint_card or card)
                    return true
                end
            }))
            return nil, true
        end
    end,
    blueprint_compat = true, forcetrigger_compat = true,
    boss_key = "bl_needle"
}

HPR.BossJoker {
    key = "head",
    pos = { x = 1, y = 3 },
    config = { extra = { xmult = 1.5, odds = 2 }},
    loc_vars = function (self, info_queue, card)
        local n,d = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, self.key)
        return { vars = { n, d, card.ability.extra.xmult }}
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.pseudorandom_probability(card, self.key, 1, card.ability.extra.odds) or context.forcetrigger then
            return { xmult = card.ability.extra.xmult }
        end
        if context.debuff_card and not context.blueprint and HPR.should_boss_downside() and context.debuff_card.is_suit and context.debuff_card:is_suit("Hearts", true) then
            return { debuff = true }
        end
    end,
    blueprint_compat = true, forcetrigger_compat = true,
    boss_key = "bl_head"
}

HPR.BossJoker {
    key = "tooth",
    pos = { x = 2, y = 3 },
    config = { extra = { dollars = 1, xchip = 0.1 }},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.dollars, card.ability.extra.xchip }}
    end,
    calculate = function (self, card, context)
        if context.before then
            local s = HPR.should_boss_downside()
            for _, c in ipairs(context.full_hand) do
                local effect = { message = localize("k_upgrade_ex"), colour = G.C.CHIPS, message_card = c }
                if s then
                    effect.extra = { dollars = -card.ability.extra.dollars, func = HPR.event_presets.reset_dollar_buffer, message_card = c }
                    G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) - card.ability.extra.dollars
                end
                c.ability.perma_x_chips = c.ability.perma_x_chips + card.ability.extra.xchip
                SMODS.calculate_effect(effect, card)
            end
        end
    end,
    boss_key = "bl_tooth",
    blueprint_compat = true,
}

HPR.BossJoker {
    key = "flint",
    pos = { x = 3, y = 3 },
    calculate = function (self, card, context)
        if (context.modify_hand or context.forcetrigger) and HPR.should_boss_downside() then
            mult = mod_mult(math.max(math.floor(mult * 0.5 + 0.5), 1))
            hand_chips = mod_chips(math.max(math.floor(hand_chips * 0.5 + 0.5), 0))
            update_hand_text({ sound = 'chips2', modded = true }, { chips = hand_chips, mult = mult })
            return nil, true --:troll:
        end
        if context.joker_main or context.forcetrigger then
            return { balance = true }
        end
    end,
    boss_key = "bl_flint",
    blueprint_compat = true,
    forcetrigger_compat = true
}

HPR.BossJoker {
    key = "mark",
    pos = { x = 4, y = 3 },
    config = { extra = 0.1 },
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra}}
    end,
    calculate = function (self, card, context)
        if context.stay_flipped and context.to_area == G.hand and context.other_card:is_face() then
            context.other_card.ability.perma_h_x_mult = context.other_card.ability.perma_h_x_mult + card.ability.extra
            if HPR.should_boss_downside() then return { stay_flipped = true } end
        end
    end,
    boss_key = "bl_mark"
}

HPR.BossJoker {
    key = "final_acorn",
    pos = { x = 0, y = 4 },
    calculate = function (self, card, context)
        if (context.setting_blind or context.forcetrigger) and HPR.should_boss_downside() and not context.blueprint then
            if #G.jokers.cards > 0 then
                G.jokers:unhighlight_all()
                for _, joker in ipairs(G.jokers.cards) do
                    joker:flip()
                end
                if #G.jokers.cards > 1 then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.2,
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.jokers:shuffle('hpr_aajk')
                                    play_sound('cardSlide1', 0.85)
                                    return true
                                end,
                            }))
                            delay(0.15)
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.jokers:shuffle('hpr_aajk')
                                    play_sound('cardSlide1', 1.15)
                                    return true
                                end
                            }))
                            delay(0.15)
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.jokers:shuffle('hpr_aajk')
                                    play_sound('cardSlide1', 1)
                                    return true
                                end
                            }))
                            delay(0.5)
                            return true
                        end
                    }))
                end
            end
        end
        if context.end_of_round and context.main_eval and HPR.should_boss_downside() then
            G.E_MANAGER:add_event(Event{
                func = function ()
                    for _, c in ipairs(G.jokers.cards) do
                        if c.facing == "back" then
                            c:flip()
                        end
                    end
                    return true
                end
            })
        end
        if context.retrigger_joker_check and context.other_card.ability and context.other_card.ability.set == "Joker" then
            return { repetitions = 1 }
        end
    end,
    forcetrigger_compat = true, -- :3
    blueprint_compat = true,
    boss_key = "bl_final_acorn"
}

HPR.BossJoker {
    key = "final_leaf",
    pos = { x = 1, y = 4 },
    config = { extra = { active = true, reps = 0 }},
    loc_vars = function (self, info_queue, card)
        local active = HPR.should_boss_downside() and card.ability.extra.active and true or false
        return { vars = { localize(active and "k_active" or "k_inactive"), card.ability.extra.reps }}
    end,
    calculate = function (self, card, context)
        if context.debuff_card and not context.blueprint and context.debuff_card.playing_card and card.ability.extra.active and HPR.should_boss_downside() then
            return { debuff = true }
        end
        if context.repetition and context.cardarea == G.play and card.ability.extra.reps > 0 and not card.ability.extra.active then
            return { repetitions = card.ability.extra.reps }
        end
        if context.selling_card and context.card ~= card and not context.blueprint and context.card.ability.set == "Joker" then
            if card.ability.extra.active and HPR.should_boss_downside() then
                card.ability.extra.active = false
                for _, c in ipairs(G.playing_cards) do
                    SMODS.recalc_debuff(c)
                end
                return { message = localize("k_disabled_ex") }
            else
                card.ability.extra.reps = card.ability.extra.reps + 1
                return { message = localize("k_upgrade_ex") }
            end
        end
        if context.end_of_round and context.main_eval and not context.blueprint then
            card.ability.extra.reps = 0
            card.ability.extra.active = true
            return { message = localize("k_reset")}
        end
    end
}