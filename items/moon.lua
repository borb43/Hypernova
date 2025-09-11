SMODS.ConsumableType {
    key = "hpr_moons",
    default = "c_hpr_deimos",
    primary_colour = HEX("5d15d1"),
    secondary_colour = HEX("707b8c")
}

SMODS.Consumable { --Pair moon, perma mult stuff
    key = "deimos",
    set = "hpr_moons",
    atlas = "placeholder",
    pos = { x = 3, y = 2 },
    config = { extra = { hand_type = "Pair", mult = 0, per_charge = 8, max_highlighted = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { localize(card.ability.extra.hand_type, "poker_hands"), card.ability.extra.mult, card.ability.extra.per_charge, card.ability.extra.max_highlighted } }
    end,
    calculate = function(self, card, context)
        if context.before and context.scoring_name == card.ability.extra.hand_type then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "mult",
                scalar_value = "per_charge"
            })
            SMODS.smart_level_up_hand(card, card.ability.extra.hand_type, nil, -1)
        end
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound("tarot1")
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local _card = G.hand.highlighted[i]
            _card.ability.perma_mult = (_card.ability.perma_mult or 0) + card.ability.extra.mult
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function ()
                    _card:juice_up()
                    return true
                end
            }))
        end
        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end,
    can_use = function (self, card)
        return card.ability.extra.mult ~= 0 and #G.hand.highlighted > 0 and #G.hand.highlighted < card.ability.extra.max_highlighted
    end
}


SMODS.Consumable {
    key = "io",
    set = "hpr_moons",
    atlas = "placeholder",
    pos = { x = 3, y = 2 },
    config = { extra = { hand_type = "Three of a Kind", per_charge = 1 }, max_highlighted = 0 },
    loc_vars = function (self, info_queue, card)
        return { vars = { localize(card.ability.extra.hand_type, "poker_hands"), card.ability.max_highlighted, card.ability.extra.per_charge }}
    end,
    calculate = function (self, card, context)
        if context.before and context.scoring_name == card.ability.extra.hand_type then
            SMODS.scale_card(card, {
                ref_table = card.ability,
                ref_value = "max_highlighted",
                scalar_table = card.ability.extra,
                scalar_value = "per_charge"
            })
            SMODS.smart_level_up_hand(card, card.ability.extra.hand_type, nil, -1)
        end
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    G.hand.highlighted[i]:set_ability(G.P_CENTERS[SMODS.poll_enhancement({ guaranteed = true })])
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
}

--full house moon here

--4oak moon here

--flush moon here

--straight moon here

--two pair moon here

--strush moon here

SMODS.Consumable { --High Card moon, gives money
    key = "styx",
    set = "hpr_moons",
    atlas = "placeholder",
    pos = { x = 3, y = 2 },
    config = { extra = { hand_type = "High Card", dollars = 0, per_charge = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { localize(card.ability.extra.hand_type, "poker_hands"), card.ability.extra.dollars, card.ability.extra.per_charge } }
    end,
    calculate = function(self, card, context)
        if context.before and context.scoring_name == card.ability.extra.hand_type then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "dollars",
                scalar_value = "per_charge"
            })
            SMODS.smart_level_up_hand(card, card.ability.extra.hand_type, nil, -1)
        end
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                card:juice_up(0.3, 0.5)
                ease_dollars(card.ability.extra.dollars)
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return card.ability.extra.dollars > 0
    end
}

--5oak moon here

--flouse moon here

--flush 5 moon here
