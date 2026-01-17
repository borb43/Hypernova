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
    atlas = "hpr_moons",
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
            if self.apply_bonus then self:apply_bonus(card, _card) end
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
                if self.apply_bonus then self:apply_bonus(card, _card) end
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
            if self.apply_bonus then self:apply_bonus(card, _card) end
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
        code = {"Eris"},
        idea = {"Eris"}
    }
})

HPR.moon {
    key = "deimos",
    config = { extra = 8, max_highlighted = 2 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra, card.ability.max_highlighted }}
    end,
    pos = { x = 0, y = 0 },
    hpr_credits = {
        idea = {"Eris"},
        code = {"Eris"},
        art = {"LFMoth"}
    },
    apply_bonus = function (self, card, other_card)
        other_card.ability.perma_mult = other_card.ability.perma_mult + card.ability.extra
    end
}

HPR.moon {
    key = "io",
    config = { extra = 45, max_highlighted = 2 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra, card.ability.max_highlighted }}
    end,
    pos = { x = 1, y = 0 },
    apply_bonus = function (self, card, other_card)
        other_card.ability.perma_bonus = other_card.ability.perma_bonus + card.ability.extra
    end
}

HPR.moon {
    key = "moon",
    config = { extra = 45, max_highlighted = 3 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra, card.ability.max_highlighted }}
    end,
    pos = { x = 2, y = 0 },
    apply_bonus = function (self, card, other_card)
        other_card.ability.perma_h_chips = other_card.ability.perma_h_chips + card.ability.extra
    end
}

HPR.moon {
    key = "phobos",
    config = { extra = 8, max_highlighted = 3 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra, card.ability.max_highlighted }}
    end,
    pos = { x = 3, y = 0 },
    hpr_credits = {
        idea = {"Eris"},
        code = {"Eris"},
        art = {"LFMoth"}
    },
    apply_bonus = function (self, card, other_card)
        other_card.ability.perma_h_mult = other_card.ability.perma_h_mult + card.ability.extra
    end
}

HPR.moon {
    key = "europa",
    config = { extra = 0.25, max_highlighted = 1 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra, card.ability.max_highlighted }}
    end,
    pos = { x = 4, y = 0 },
    hpr_credits = {
        idea = {"Eris"},
        code = {"Eris"},
        art = {"LFMoth"}
    },
    apply_bonus = function (self, card, other_card)
        other_card.ability.perma_x_mult = other_card.ability.perma_x_mult + card.ability.extra
    end
}

HPR.moon {
    key = "hyperion",
    config = { extra = 0.25, max_highlighted = 1 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra, card.ability.max_highlighted }}
    end,
    pos = { x = 5, y = 0 },
    apply_bonus = function (self, card, other_card)
        other_card.ability.perma_x_chips = other_card.ability.perma_x_chips + card.ability.extra
    end
}

HPR.moon {
    key = "titania",
    config = { extra = 0.25, max_highlighted = 2 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra, card.ability.max_highlighted }}
    end,
    pos = { x = 0, y = 1 },
    apply_bonus = function (self, card, other_card)
        other_card.ability.perma_h_x_mult = other_card.ability.perma_h_x_mult + card.ability.extra
    end
}

HPR.moon {
    key = "triton",
    config = { extra = 0.25, max_highlighted = 2 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra, card.ability.max_highlighted }}
    end,
    pos = { x = 1, y = 1 },
    apply_bonus = function (self, card, other_card)
        other_card.ability.perma_h_x_chips = other_card.ability.perma_h_x_chips + card.ability.extra
    end
}

HPR.moon {
    key = "styx",
    config = { extra = 2, max_highlighted = 1 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra, card.ability.max_highlighted }}
    end,
    pos = { x = 2, y = 1 },
    apply_bonus = function (self, card, other_card)
        other_card.ability.perma_h_dollars = other_card.ability.perma_h_dollars + card.ability.extra
    end
}

HPR.moon {
    key = "nibiru",
    config = { extra = 1, max_highlighted = 1 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra, card.ability.max_highlighted }}
    end,
    pos = { x = 3, y = 1 },
    set_card_type_badge = function (self, card, badges)
        badges[#badges+1] = create_badge(localize("k_hpr_moon_q"),
        get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.hpr_moons.text_colour,
        1.2)
    end,
    apply_bonus = function (self, card, other_card)
        other_card.ability.perma_p_dollars = other_card.ability.perma_p_dollars + card.ability.extra
    end
}

HPR.moon {
    key = "asteroid",
    config = { extra = 1, max_highlighted = 1 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra, card.ability.max_highlighted }}
    end,
    pos = { x = 4, y = 1 },
    set_card_type_badge = function (self, card, badges)
        badges[#badges+1] = create_badge(localize("k_hpr_moon_q"),
        get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.hpr_moons.text_colour,
        1.2)
    end,
    apply_bonus = function (self, card, other_card)
        other_card.ability.hpr_num_bonus = other_card.ability.hpr_num_bonus + card.ability.extra
    end
}

HPR.moon {
    key = "dysnomia",
    config = { extra = 0.2, max_highlighted = 1 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra, card.ability.max_highlighted }}
    end,
    pos = { x = 5, y = 1 },
    apply_bonus = function (self, card, other_card)
        other_card.ability.perma_eff_mod = other_card.ability.perma_eff_mod + card.ability.extra
    end
}

SMODS.Consumable {
    key = "pulsar",
    set = "Spectral",
    atlas = "moons",
    pos = { x = 6, y = 0 },
    soul_pos = { x= 7, y = 0 },
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
    soul_set = "hpr_moons",
    hpr_credits = {
        idea = {"Eris"},
        code = {"Eris"}
    }
}