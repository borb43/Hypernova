SMODS.ConsumableType {
    key = "hpr_prophecy",
    primary_colour = G.C.BOOSTER,
    secondary_colour = HEX("060d40"),
    default = "c_hpr_tome",
    collection_rows = { 5, 5 }
}

HPR.prophecy = SMODS.Consumable:extend{
    set = "hpr_prophecy",
    cost = 4,
    atlas = "hpr_placeholder",
    pos = { x = 3, y = 3 }
}

SMODS.DrawStep {
    key = "prophecy_shine",
    order = 11,
    func = function (self)
        if self.ability.set == "hpr_prophecy" and self:should_draw_base_shader() then
            self.children.center:draw_shader('booster', nil, self.ARGS.send_to_shader)
        end
    end,
    conditions = { vortex = false, facing = "front" }
}

--#region normal cards
HPR.prophecy {
    key = "ignorance",
    loc_vars = function(self, info_queue, card)
        local set = G.GAME.hpr_ignorance_card
        local loc = set and localize(("k_"..set):lower()) or localize("k_none")
        local colour = set and G.C.SECONDARY_SET[set] or G.C.UI.TEXT_INACTIVE
        return { vars = { loc, colours = { colour } } }
    end,
    can_use = function (self, card)
        return (#G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables) and G.GAME.hpr_ignorance_card
    end,
    use = function (self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    play_sound('timpani')
                    SMODS.add_card({
                        set = G.GAME.hpr_ignorance_card,
                        key_append = "hpr_ignorance",
                        stickers = { "eternal" },
                        force_stickers = true
                    })
                    card:juice_up(0.3, 0.5)
                end
                return true
            end
        }))
        delay(0.6)
    end,
    in_pool = function (self, args)
        return not args or args.source ~= "hpr_ignorance"
    end
}

HPR.prophecy {
    key = "blessing",
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_hpr_lunar
        return { vars = { localize{ type = "name_text", set = "Enhanced", key = "m_hpr_lunar" }}}
    end,
    can_use = function ()
        return G.hand and #G.hand.cards > 0
    end,
    use = function (self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event{
            trigger = "after",
            delay = 0.7,
            func = function ()
                local c = SMODS.add_card{
                    area = G.hand,
                    set = "Enhanced",
                    key = "m_hpr_lunar"
                }
                SMODS.calculate_context({playing_card_added = true, cards = {c}})
                return true
            end
        })
    end
}

HPR.prophecy {
    key = "tome",
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = { set = "Other", key = "rental", vars = { G.GAME.rental_rate }}
        local main_end = {}
        if G.jokers and G.jokers.cards then
            for _, c in ipairs(G.jokers.cards) do
                if c.edition and c.edition.negative then
                    info_queue[#info_queue+1] = G.P_CENTERS.e_negative
                    localize { type = 'other', key = 'remove_negative', nodes = main_end, vars = {} }
                    break
                end
            end
        end
        return { main_end = main_end[1] }
    end,
    can_use = function (self, card)
        return G.jokers and #G.jokers.cards > 0 and #G.jokers.cards < G.jokers.config.card_limit
    end,
    use = function (self, card, area, copier)
        local to_copy = pseudorandom_element(G.jokers.cards)
        G.E_MANAGER:add_event(Event{
            trigger = "before",
            delay = 0.4,
            func = function ()
                local copy = copy_card(to_copy, nil, nil, nil, to_copy.edition and to_copy.edition.negative)
                copy:start_materialize()
                copy:add_to_deck()
                copy:add_sticker("rental", true)
                G.jokers:emplace(copy)
                return true
            end
        })
        G.GAME.rental_rate = G.GAME.rental_rate * 2
    end
}
--#endregion
--#region hidden consumables
HPR.prophecy {
    key = "ascender",
    hidden = true,
    can_use = function (self, card)
        return G.jokers and #G.jokers.highlighted == 1 and HPR.get_ascension(G.jokers.highlighted[1])
    end,
    use = function (self, card, area, copier)
        G.E_MANAGER:add_event(Event{
            trigger = 'after',
            delay = 0.4,
            func = function ()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        })
        G.E_MANAGER:add_event(Event{
            trigger = 'after',
            delay = 0.15,
            func = function ()
                G.jokers.highlighted[1]:flip()
                play_sound('card1')
                return true
            end
        })
        delay(0.2)
        G.E_MANAGER:add_event(Event{
            trigger = 'after',
            delay = 0.15,
            func = function ()
                G.jokers.highlighted[1]:remove_from_deck()
                G.jokers.highlighted[1]:set_ability(HPR.get_ascension(G.jokers.highlighted[1]))
                G.jokers.highlighted[1]:add_to_deck()
                G.jokers.highlighted[1]:set_cost()
                G.jokers.highlighted[1]:flip()
                return true
            end
        })
        delay(0.5)
    end,
    soul_set = "Spectral"
}

HPR.prophecy {
    key = "pulsar",
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
        idea = "Eris",
        code = "Eris"
    }
}
--#endregion