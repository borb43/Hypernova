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
        return { vars = { card.ability.extra.hand_type, card.ability.extra.mult, card.ability.extra.per_charge, card.ability.extra.max_highlighted } }
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

--3oak moon here

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
        return { vars = { card.ability.extra.hand_type, card.ability.extra.dollars, card.ability.extra.per_charge } }
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
