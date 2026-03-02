HPR.SuitPlanet = SMODS.Consumable:extend{
    set = "Planet",
    cost = 3,
    loc_vars = function (self, info_queue, card)
        if not G.GAME.SuitBuffs then G.GAME.SuitBuffs = {} end
        if not G.GAME.SuitBuffs[card.ability.level_suit] then G.GAME.SuitBuffs[card.ability.level_suit] = {} end
        return {
            vars = {
                G.GAME.SuitBuffs[card.ability.level_suit].level or 1,
                localize(card.ability.level_suit,'suits_plural'),
                card.ability.suit_chips,
                colours = {
                    to_big(G.GAME.SuitBuffs[card.ability.level_suit].level or 1) < to_big(2) and G.C.BLACK or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.SuitBuffs[card.ability.level_suit].level or 1))],
                    G.C.SUITS[card.ability.level_suit]
                }
            }
        }
    end,
    use = function (self, card, area, copier)
        Spectrallib.level_suit(card.ability.level_suit, card, 1, card.ability.suit_chips)
    end,
    can_use = function (self, card)
        return true
    end,
    set_card_type_badge = function (self, card, badges)
        badges[#badges+1] = create_badge(localize("k_hidden_realm"), get_type_colour(card.config.center or card.config, card), G.C.WHITE, 1.2)
    end,
    atlas = "hpr_placeholder",
    pos = { x = 4, y = 3 },
}

HPR.SuitPlanet {
    key = "coast",
    config = { level_suit = "Diamonds", suit_chips = 10 }
}

HPR.SuitPlanet {
    key = "neural",
    config = { level_suit = "Clubs", suit_chips = 10 }
}

HPR.SuitPlanet {
    key = "limbo",
    config = { level_suit = "Spades", suit_chips = 10 }
}

HPR.SuitPlanet {
    key = "bulwark",
    config = { level_suit = "Hearts", suit_chips = 10 }
}

SMODS.Consumable {
    key = "planetarium",
    set = "Spectral",
    atlas = "placeholder",
    pos = { x = 2, y = 2 },
    hidden = true,
    soul_set = "Planet",
    config = { extra = 3 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra }}
    end,
    use = function (self, card, area, copier)
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
            { handname = localize('k_all_suits'), chips = '...', mult = '...', level = '' })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                G.TAROT_INTERRUPT_PULSE = true
                return true
            end
        }))
        update_hand_text({ delay = 0 }, { mult = '+', StatusText = true })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                return true
            end
        }))
        update_hand_text({ delay = 0 }, { chips = '+', StatusText = true })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                G.TAROT_INTERRUPT_PULSE = nil
                return true
            end
        }))
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = '+'..number_format(card.ability.extra) })
        delay(1.3)
        for _, key in ipairs(SMODS.Suit.obj_buffer) do
            Spectrallib.level_suit(key, card, card.ability.extra, nil, true)
        end
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 }, { mult = 0, chips = 0, handname = '', level = '' })
    end,
    can_use = function (self, card)
        return true
    end,
}