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
        if context.press_play then
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
    boss_key = "bl_hook"
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
            if reset then
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
            return { stay_flipped = true }
        end
    end,
    boss_key = "bl_house"
}