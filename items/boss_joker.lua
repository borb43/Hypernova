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