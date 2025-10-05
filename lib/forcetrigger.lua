HPR.forcetrigger = function(card, context) --evaluates a card with the `context = { forcetrigger = true }`
    if not HPR.check_ft_vanilla(card) and card.ability.set == "Joker" and (card.config.center.demicoloncompat or card.config.center.forcetrigger_compat or card.config.center.demicolon_compat) then
        local new_context
        for k, v in pairs(context) do
            new_context[k] = v
        end
        new_context.forcetrigger = true
        ret = eval_card(card, new_context)
    elseif HPR.check_ft_vanilla(card) then
        ret = HPR.forcetrigger_vanilla(card, context) --context is needed for supernova
    end
end



HPR.check_ft_vanilla = function(card)
    for _, name in ipairs(HPR.ft_vanilla_compat) do
        if card.ability.name == name then
            return true
        end
    end
    return false
end

--#region vanilla forcetrigger table
HPR.ft_vanilla_compat = { --fill out later
    "Joker",

}
--#endregion

--#region vanilla forcetriggers (Generally only does one effect of the joker, as opposed to cryptid's implementation, which does all effects)
HPR.forcetrigger_vanilla = function(card, context)
    local ret
    --first page
    if card.ability.name == "Joker" then
        ret = { mult = card.ability.mult }
    end
    if card.ability.name == "Greedy Joker" or card.ability.name == "Wrathful Joker"
        or card.ability.name == "Lusty Joker" or card.ability.name == "Gluttonous Joker" then
        ret = { mult = card.ability.s_mult }
    end
    if card.ability.name == "Jolly Joker" or card.ability.name == "Zany Joker"
        or card.ability.name == "Mad Joker" or card.ability.name == "Crazy Joker"
        or card.ability.name == "Droll Joker" then
        ret = { mult = card.ability.t_mult }
    end
    if card.ability.name == "Sly Joker" or card.ability.name == "Wily Joker"
        or card.ability.name == "Clever Joker" or card.ability.name == "Crafty Joker"
        or card.ability.name == "Devious Joker" then
        ret = { chips = card.ability.t_chips }
    end
    --second page (Four Fingers, Mime, Credit Card, Dusk, Chaos The Clown are incompatible)
    if card.ability.name == "Half Joker" then
        ret = { mult = card.ability.mult }
    end
    if card.ability.name == "Joker Stencil" then
        ret = { xmult = card.ability.x_mult }
    end
    if card.ability.name == "Ceremonial Dagger" then
        ret = { mult = card.ability.mult }
    end
    if card.ability.name == "Banner" then
        ret = { chips = card.ability.extra * G.GAME.current_round.discards_left }
    end
    if card.ability.name == "Mystic Summit" then
        ret = { mult = card.ability.extra.mult }
    end
    if card.ability.name == "Marble Joker" then
        G.E_MANAGER:add_event(Event({
            func = function()
                local stone_card = SMODS.add_card { set = "Base", enhancement = "m_stone", area = G.deck }
                ret = {
                    message = localize('k_plus_stone'),
                    colour = G.C.SECONDARY_SET.Enhanced,
                    func = function()
                        SMODS.calculate_context({ playing_card_added = true, cards = { stone_card } })
                    end
                }
            end
        }))
    end
    if card.ability.name == "Loyalty Card" then
        ret = { xmult = card.ability.extra.Xmult }
    end
    if card.ability.name == "8 Ball" then
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
        ret = {
            extra = {
                message = localize('k_plus_tarot'),
                message_card = card,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            SMODS.add_card {
                                set = 'Tarot',
                                key_append = '8ba'
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end)
                    }))
                end
            },
        }
    end
    if card.ability.name == "Misprint" then
        ret = { mult = pseudorandom("misprint", card.ability.extra.min, card.ability.extra.max)}
    end
    if card.ability.name == "Raised Fist" and G.hand and #G.hand.cards > 0 then
        local lowest_id, nominal = math.huge, math.huge
        local message_card
        for i = 1, #G.hand.cards do
            if lowest_id > G.hands.cards[i].base.id and not SMODS.has_no_rank(G.hand.cards[i]) then
                lowest_id = G.hand.cards[i].base.id
                nominal = G.hand.cards[i].base.nominal
                message_card = G.hand.cards[i]
            end
        end
        if lowest_id ~= math.huge and nominal ~= math.huge then
            ret = { mult = nominal*2, message_card = message_card }
        end
    end
    --third page (Hack, Pareidolia are incompatible)
    if card.ability.name == "Fibonacci" then
        ret = { mult = card.ability.extra }
    end
    if card.ability.name == "Steel Joker" then
        local steels = 0
        for _, c in ipairs(G.playing_cards) do
            if SMODS.has_enhancement(c, "m_steel") then steels = steels + 1 end
        end
        ret = { xmult = 1+card.ability.extra*steels}
    end
    if card.ability.name == "Scary Face" then
        ret = { chips = card.ability.extra }
    end
    if card.ability.name == "Abstract Joker" then
        ret = { mult = card.ability.extra*#G.jokers.cards}
    end
    if card.ability.name == "Delayed Gratification" then
        ret = { dollars = card.ability.extra*G.GAME.current_round.discards_left}
    end
    if card.ability.name == "Gros Michel" then
        ret = { mult = card.ability.extra.mult }
    end
    if card.ability.name == "Even Steven" then
        ret = { mult = card.ability.extra }
    end
    if card.ability.name == "Odd Todd" then
        ret = { chips = card.ability.extra }
    end
    if card.ability.name == "Scholar" then
        ret = { chips = card.ability.extra.chips, mult = card.ability.extra.mult }
    end
    if card.ability.name == "Business Card" then
        ret = { dollars = 2 }
    end
    if card.ability.name == "Supernova" and context.scoring_name then
        ret = { mult = G.GAME.hands[context.scoring_name].played}
    end
    if card.ability.name == "Ride the Bus" then
        ret = { mult = card.ability.mult }
    end
    if card.ability.name == "Space Joker" and context.scoring_name then
        ret = { level_up = true }
    end
    --page 4
    ret.card = card
end
--#endregion
