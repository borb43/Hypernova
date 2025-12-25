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
HPR.prophecy { --ignorance, reverse the fool
    key = "ignorance",
    loc_vars = function(self, info_queue, card)
        local center = G.GAME.hpr_ignorance_card and G.P_CENTERS[G.GAME.hpr_ignorance_card] or nil
        local last_tarot_planet = center and localize { type = 'name_text', key = center.key, set = center.set } or
            localize('k_none')
        local colour = (not center or center.key == 'c_hpr_ignorance') and G.C.RED or G.C.GREEN

        if not (not center or center.key == 'c_hpr_ignorance') then
            info_queue[#info_queue + 1] = center
        end

        local main_end = {
            {
                n = G.UIT.C,
                config = { align = "bm", padding = 0.02 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "m", colour = colour, r = 0.05, padding = 0.05 },
                        nodes = {
                            { n = G.UIT.T, config = { text = ' ' .. last_tarot_planet .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true } },
                        }
                    }
                }
            }
        }
        return { vars = { last_tarot_planet }, main_end = main_end }
    end,
    can_use = function (self, card)
        return (#G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables) and G.GAME.hpr_ignorance_card and G.GAME.hpr_ignorance_card ~= "c_hpr_ignorance"
    end,
    use = function (self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    play_sound('timpani')
                    SMODS.add_card({ key = G.GAME.hpr_ignorance_card })
                    card:juice_up(0.3, 0.5)
                end
                return true
            end
        }))
        delay(0.6)
    end
}

HPR.prophecy { --tome, reverse ectoplasm
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
HPR.prophecy { --ascension, reverse the soul
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
    end
}

HPR.prophecy { --pulsar, reverse black hole
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