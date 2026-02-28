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
    boss_key = "bl_ox"
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
    boss_key = "bl_house"
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
        end
    end,
    boss_key = "bl_wall",
    forcetrigger_compat = true,
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
    boss_key = "bl_wheel"
}

HPR.BossJoker {
    key = "arm",
    pos = { x = 5, y = 0 },
    config = { extra = { chips = 0, mult = 0 }},
    loc_vars = function (self, info_queue,card)
        return {vars = { card.ability.extra.chips, card.ability.extra.mult }}
    end,
    calculate = function (self, card, context)
        if context.before and G.GAME.hands[context.scoring_name].level > 1 then
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
        if context.debuff_card and context.debuff_card:is_suit("Clubs") and HPR.should_boss_downside() then return { debuff = true } end
    end,
    boss_key = "bl_club",
    forcetrigger_compat = true,
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
        if context.hand_drawn or context.setting_blind then card.ability.prepped = nil end
    end,
    boss_key = "bl_fish"
}

HPR.BossJoker{
    key = "psychic",
    pos = { x = 2, y = 1 },
    config = { extra = 5 },
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra}}
    end,
    calculate = function (self, card, context)
        if context.debuff_hand and #context.full_hand ~= card.ability.extra and HPR.should_boss_downside() then
            return {
                debuff = true,
                debuff_text = localize{ type = "variable", vars = {card.ability.extra}, key = "play_x_cards"},
                no_juice = context.check
            }
        end
        if context.repetition and context.cardarea == G.play then return { repetitions = 1 } end
    end,
    boss_key = "bl_psychic"
}

HPR.BossJoker {
    key = "goad",
    pos = { x = 3, y = 1 },
    config = { extra = 50 },
    loc_vars = function (self, info_queue, card)
        return{ vars = {card.ability.extra}}
    end,
    calculate = function (self, card, context)
        if context.debuff_card and context.debuff_card:is_suit("Spades") and HPR.should_boss_downside() then
            return { debuff = true }
        end
        if context.individual and context.cardarea == G.play or context.forcetrigger then
            return { chips = card.ability.extra}
        end
    end,
    boss_key = "bl_goad",
    forcetrigger_compat = true
}