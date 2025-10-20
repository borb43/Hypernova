SMODS.ConsumableType {
    key = "hpr_moons",
    default = "c_hpr_deimos",
    primary_colour = HEX("5d15d1"),
    secondary_colour = HEX("707b8c"),
}

HPR.moon = SMODS.Consumable:extend({
    set = "hpr_moons",
    atlas = "hpr_placeholder", --default atlas, change later
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
            HPR.apply_moon_bonus(_card, card)
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
    key = "phobos",
    config = { moon_h_mult = 8, max_highlighted = 3 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.moon_h_mult, card.ability.max_highlighted }}
    end
}

HPR.moon {
    key = "europa",
    config = { moon_x_mult = 0.2, max_highlighted = 1 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.moon_x_mult, card.ability.max_highlighted }}
    end
}

HPR.moon {
    key = "hyperion",
    config = { moon_x_chips = 0.2, max_highlighted = 1 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.moon_x_chips, card.ability.max_highlighted }}
    end
}

HPR.moon {
    key = "titania",
    config = { moon_h_x_mult = 0.2, max_highlighted = 2 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.moon_h_x_mult, card.ability.max_highlighted }}
    end
}

HPR.moon {
    key = "triton",
    config = { moon_h_x_chips = 0.2, max_highlighted = 2 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.moon_h_x_chips, card.ability.max_highlighted }}
    end
}