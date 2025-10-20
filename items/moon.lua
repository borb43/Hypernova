SMODS.ConsumableType {
    key = "hpr_moons",
    default = "c_hpr_deimos",
    primary_colour = HEX("5d15d1"),
    secondary_colour = HEX("707b8c"),
}

HPR.moon = SMODS.Consumable:extend({
    set = "hpr_moons",
    atlas = "placeholder", --default atlas, change later
    pos = { x = 3, y = 2 },
    cost = 4,
    use = function (self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound("tarot1")
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local _card = G.hand.highlighted[i]
            _card.ability.perma_bonus = _card.ability.perma_bonus + (card.ability.moon_bonus or 0)
            _card.ability.perma_h_chips = _card.ability.perma_h_chips + (card.ability.moon_h_chips or 0)
            _card.ability.perma_mult = _card.ability.perma_mult + (card.ability.moon_mult or 0)
            _card.ability.perma_h_mult = _card.ability.perma_h_mult + (card.ability.moon_h_mult or 0)
            _card.ability.perma_x_chips = _card.ability.perma_x_chips + (card.ability.moon_x_chips or 0)
            _card.ability.perma_h_x_chips = _card.ability.perma_h_x_chips + (card.ability.moon_h_x_chips or 0)
            _card.ability.perma_x_mult = _card.ability.perma_x_mult + (card.ability.moon_x_mult or 0)
            _card.ability.perma_h_x_mult = _card.ability.perma_h_x_mult + (card.ability.moon_h_x_mult or 0)
            _card.ability.perma_p_dollars = _card.ability.perma_p_dollars + (card.ability.moon_p_dollars or 0)
            _card.ability.perma_h_dollars = _card.ability.perma_h_dollars + (card.ability.moon_h_dollars or 0)
            _card.ability.perma_repetitions = _card.ability.perma_repetitions + (card.ability.moon_repetitions or 0)
            _card.ability.perma_eff_mod = _card.ability.perma_eff_mod + (card.ability.moon_eff_mod or 0)
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
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
    end
})

HPR.moon {
    key = "deimos",
    config = { moon_mult = 8, max_highlighted = 2 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.moon_mult, card.ability.max_highlighted }}
    end
}

HPR.moon {
    key = "io",
    config = { moon_bonus = 60, max_highlighted = 2 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.moon_bonus, card.ability.max_highlighted }}
    end
}

HPR.moon {
    key = "moon",
    config = { moon_h_chips = 60, max_highlighted = 3 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.moon_h_chips, card.ability.max_highlighted }}
    end
}

HPR.moon {
    key = "europa",
    config = { moon_h_mult = 8, max_highlighted = 3 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.moon_h_mult, card.ability.max_highlighted }}
    end
}