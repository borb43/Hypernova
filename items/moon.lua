SMODS.ConsumableType {
    key = "hpr_moons",
    default = "c_hpr_deimos",
    primary_colour = HEX("707b8c"),
    secondary_colour = HEX("5d15d1"),
}

SMODS.UndiscoveredSprite {
    key = "hpr_moons",
    atlas = "moons",
    pos = { x = 6, y = 1 }
}

HPR.moon = SMODS.Consumable:extend({
    set = "hpr_moons",
    atlas = "hpr_moons", --default atlas, change later
    pos = { x = 0, y = 0 },
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
    end,
    bulk_use = function (self, card, area, copier, number)
        G.E_MANAGER:add_event(Event({
            func = function ()
                play_sound("tarot1")
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local _card = G.hand.highlighted[i]
            for _ = 1, number do
                HPR.apply_moon_bonus(_card, card)
            end
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
            trigger = "after",
            delay = 0.2,
            func = function ()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end,
    force_use = function (self, card, area)
        local cards = Cryptid and Cryptid.get_highlighted_cards({ G.hand }, card, 1, card.ability.max_highlighted, function(card) return not card.edition and not card.will_be_editioned end )
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound("tarot1")
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #cards do
            local _card = cards[i]
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
    end,
    hpr_credits = {
        code = "Eris",
        idea = "Eris"
    }
})

HPR.moon {
    key = "deimos",
    config = { moon_mult = 12, max_highlighted = 2 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.moon_mult, card.ability.max_highlighted }}
    end,
    pos = { x = 0, y = 0 },
    hpr_credits = {
        idea = "Eris",
        code = "Eris",
        art = "LFMoth"
    }
}

HPR.moon {
    key = "io",
    config = { moon_bonus = 90, max_highlighted = 2 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.moon_bonus, card.ability.max_highlighted }}
    end,
    pos = { x = 1, y = 0 }
}

HPR.moon {
    key = "moon",
    config = { moon_h_chips = 90, max_highlighted = 3 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.moon_h_chips, card.ability.max_highlighted }}
    end,
    pos = { x = 2, y = 0 }
}

HPR.moon {
    key = "phobos",
    config = { moon_h_mult = 12, max_highlighted = 3 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.moon_h_mult, card.ability.max_highlighted }}
    end,
    pos = { x = 3, y = 0 },
    hpr_credits = {
        idea = "Eris",
        code = "Eris",
        art = "LFMoth"
    }
}

HPR.moon {
    key = "europa",
    config = { moon_x_mult = 0.5, max_highlighted = 1 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.moon_x_mult, card.ability.max_highlighted }}
    end,
    pos = { x = 4, y = 0 },
    hpr_credits = {
        idea = "Eris",
        code = "Eris",
        art = "LFMoth"
    }
}

HPR.moon {
    key = "hyperion",
    config = { moon_x_chips = 0.5, max_highlighted = 1 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.moon_x_chips, card.ability.max_highlighted }}
    end,
    pos = { x = 5, y = 0 }
}

HPR.moon {
    key = "titania",
    config = { moon_h_x_mult = 0.5, max_highlighted = 2 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.moon_h_x_mult, card.ability.max_highlighted }}
    end,
    pos = { x = 0, y = 1 }
}

HPR.moon {
    key = "triton",
    config = { moon_h_x_chips = 0.5, max_highlighted = 2 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.moon_h_x_chips, card.ability.max_highlighted }}
    end,
    pos = { x = 1, y = 1 }
}

HPR.moon {
    key = "styx",
    config = { moon_h_dollars = 3, max_highlighted = 1 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.moon_h_dollars, card.ability.max_highlighted }}
    end,
    pos = { x = 2, y = 1 }
}

HPR.moon {
    key = "nibiru",
    config = { moon_p_dollars = 3, max_highlighted = 1 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.moon_p_dollars, card.ability.max_highlighted }}
    end,
    pos = { x = 3, y = 1 },
    set_card_type_badge = function (self, card, badges)
        badges[#badges+1] = create_badge(localize("k_hpr_moon_q"),
        get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.hpr_moons.text_colour,
        1.2)
    end
}

HPR.moon {
    key = "asteroid",
    config = { moon_repetitions = 1, max_highlighted = 1 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.moon_repetitions, card.ability.max_highlighted }}
    end,
    pos = { x = 4, y = 1 },
    set_card_type_badge = function (self, card, badges)
        badges[#badges+1] = create_badge(localize("k_hpr_moon_q"),
        get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.hpr_moons.text_colour,
        1.2)
    end
}

HPR.moon {
    key = "dysnomia",
    config = { moon_eff_mod = 0.25, max_highlighted = 1 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.moon_eff_mod, card.ability.max_highlighted }}
    end,
    pos = { x = 5, y = 1 }
}

SMODS.Consumable {
    key = "pulsar",
    set = "Spectral",
    atlas = "moons",
    pos = { x = 6, y = 0 },
    cost = 4,
    config = { max_highlighted = 1 },
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = { key = "e_negative_playing_card", set = "Edition", config = { extra = 1 }}
        return { vars = { card.ability.max_highlighted }}
    end,
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
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    _card:set_edition("e_negative")
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
    force_use = function (self, card, area)
        local cards = Cryptid and Cryptid.get_highlighted_cards({ G.hand }, card, 1, card.ability.max_highlighted, function(card) return not card.edition and not card.will_be_editioned end )
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound("tarot1")
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #cards do
            local _card = cards[i]
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    _card:set_edition("e_negative")
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
    hidden = true,
    soul_set = "hpr_moons"
}