SMODS.Joker {
    key = "bosschicken",
    atlas = "placeholder",
    pos = { x = 5, y = 0 },
    rarity = "hpr_boss",
    cost = 10,
    blueprint_compat = true,
    config = { extra = { xmult = 3 }},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.xmult }}
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
        if context.other_joker and MyDreamJournal.is_grilled_chicken(context.other_joker) then
            return { xmult = card.ability.extra.xmult }
        end
        if context.debuff_card and not MyDreamJournal.is_grilled_chicken(context.debuff_card) then
            return { debuff = true }
        end
    end,
    pools = { Food = true, ["Grilled Chicken"] = true }
}

SMODS.Joker {
    key = "stellarchicken",
    atlas = "stellar",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    rarity = "hpr_stellar",
    cost = 30,
    blueprint_compat = true,
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

SMODS.Joker {
    key = "awesomechicken",
    atlas = "placeholder",
    pos = { x = 0, y = 1 },
    soul_pos = { x = 1, y = 1 },
    cost = 10,
    rarity = "hpr_awesome",
    blueprint_compat = true,
    config = { extra = { xmult = 4 }},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.xmult }}
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
        if context.setting_blind and card.rank and card.area then
            local target = card.area.cards[card.rank+1]
            if target then
                G.E_MANAGER:add_event(Event{
                    func = function ()
                        target:set_ability(pseudorandom_element(MyDreamJournal.grilled_chicken[MyDreamJournal.ribstable[MyDreamJournal.vanilla_rarities[card.config.center.rarity] or card.config.center.rarity]] or {"j_MDJ_air_popped_grilled_chicken"}, pseudoseed("AWESOME_GRILLED")))
                        target:juice_up()
                        return true
                    end
                })
            end
        end
        if context.joker_main then
            return { xmult = card.ability.extra.xmult }
        end
    end
}