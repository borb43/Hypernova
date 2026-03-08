SMODS.Rarity {
    key = "elite",
    badge_colour = HEX("b3006b"),
    default_weight = 0.01
}

SMODS.Joker {
    key = "cornucopia",
    rarity = "hpr_elite",
    cost = 15,
    atlas = "placeholder",
    pos = { x = 0, y = 1 },
    config = { extra = { c_size = 3, rounds = 5 }},
    loc_vars = function (self, info_queue, card)
        return{ vars = { card.ability.extra.c_size, card.ability.extra.rounds }}
    end,
    add_to_deck = function (self, card, from_debuff)
        G.consumeables:change_size(card.ability.extra.c_size)
    end,
    remove_from_deck = function (self, card, from_debuff)
        G.consumeables:change_size(-card.ability.extra.c_size)
    end,
    calculate = function (self, card, context)
        if context.setting_blind then
            card.ability.extra.rounds = card.ability.extra.rounds - 1
            local to_create = G.consumeables.config.card_limit - (#G.consumeables.cards + G.GAME.consumeable_buffer)
            if to_create > 0 then
                G.E_MANAGER:add_event(Event{
                    func = function ()
                        for _ = 1, to_create do
                            SMODS.add_card{
                                set = "Consumeables",
                                area = G.consumeables,
                                key_append = "hpr_cornucopia"
                            }
                        end
                        return true
                    end
                })
            end
            if card.ability.extra.rounds <= 0 then
                SMODS.destroy_cards(card)
                return { message = localize("k_empty_ex") }
            end
        end
    end
}