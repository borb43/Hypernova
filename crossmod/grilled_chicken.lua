
SMODS.Joker {
    key = "stellarchicken",
    atlas = "stellar",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    rarity = "hpr_stellar",
    cost = 30,
    
    pools = { Food = true, ["Grilled Chicken"] = true },
    config = { extra = { threshold = 2 }},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.threshold }}
    end,
    in_pool = function (self, args)
        if G.jokers then
            for _, area in ipairs(SMODS.get_card_areas("jokers")) do
                if area.cards then
                    for _, v in area.cards do if MyDreamJournal.is_grilled_chicken(v) then return true end end
                end
            end
        end
    end,
    calculate = function (self, card, context)
        if context.retrigger_joker_check and MyDreamJournal.is_grilled_chicken(context.other_card) then
            local rep_amt = math.floor(G.GAME.round_resets.ante / card.ability.extra.threshold)
            if rep_amt > 0 then
                return { repetitions = rep_amt }
            end
        end
        if context.setting_blind and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            G.E_MANAGER:add_event(Event{
                func = function ()
                    SMODS.add_card{
                        set = "Grilled Chicken",
                        key_append = "hpr_stellarchicken",
                    }
                    return true
                end
            })
            return { message = localize("k_plus_joker") }
        end
    end
}
