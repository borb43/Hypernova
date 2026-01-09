SMODS.ConsumableType {
    key = "hpr_prophecy",
    primary_colour = G.C.BOOSTER,
    secondary_colour = HEX("060d40"),
    default = "c_hpr_tome",
    collection_rows = { 6, 6 }
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
    config = { extra = 2 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = { set = "Other", key = "eternal" }
        local set = G.GAME.hpr_ignorance_card
        local loc = set and localize(("k_"..set):lower()) or localize("k_none")
        local colour = set and G.C.SECONDARY_SET[set] or G.C.UI.TEXT_INACTIVE
        return { vars = { loc, card.ability.extra, colours = { colour } } }
    end,
    can_use = function (self, card)
        return (#G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables) and G.GAME.hpr_ignorance_card
    end,
    use = function (self, card, area, copier)
        for _ = 1, math.min(card.ability.extra, G.consumeables.config.card_limit - #G.consumeables.cards) do
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
        end
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
        local level_sum = 0
        if G.GAME and G.GAME.hands then
            for _, t in pairs(G.GAME.hands) do
                level_sum = level_sum + (t.level - 1)
            end
        end
        return G.hand and #G.hand.cards > 0 and G.hand.highlighted and #G.hand.highlighted > 0 and level_sum >= #G.hand.highlighted
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
                    G.hand.highlighted[i]:set_ability(card.ability.mod_conv)
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
        local in_pool = function (v)
            if v and G.GAME.hands[v] and G.GAME.hands[v].level > 1 then
                return true
            end
        end
        for _ = 1, #G.hand.highlighted do
            SMODS.smart_level_up_hand(card, HPR.get_random_hand(true, self.key, in_pool))
        end
    end,
}

HPR.prophecy {
    key = "divide",
    can_use = function ()
        return G.jokers and #G.jokers.cards > 0
    end,
    use = function (self, card, area, copier)
        G.E_MANAGER:add_event(Event{
            trigger = "after",
            delay = 0.7,
            func = function ()
                local copies = {}
                for _, c in ipairs(G.jokers.cards) do
                    if not c.ability.perishable then
                        local copy = copy_card(c)
                        copy:start_materialize()
                        copy:add_to_deck()
                        copy:set_edition("e_negative")
                        copy:add_sticker("perishable", true)
                        copies[#copies+1] = copy
                    end
                end
                for _, c in ipairs(copies) do G.jokers:emplace(c) end
                G.GAME.perishable_rounds = math.max(G.GAME.perishable_rounds - 1, 1)
                return true
            end
        })
    end,
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = { set = "Other", key = "perishable", vars = { G.GAME.perishable_rounds, G.GAME.perishable_rounds }}
        info_queue[#info_queue+1] = G.P_CENTERS.e_negative
    end
}

HPR.prophecy {
    key = "tome",
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = { set = "Other", key = "rental", vars = { G.GAME.rental_rate }}
        return { vars = { G.GAME.hpr_tome_plus or 1 } }
    end,
    can_use = function (self, card)
        return G.jokers and #G.jokers.cards > 0 and #G.jokers.cards < G.jokers.config.card_limit
    end,
    use = function (self, card, area, copier)
        G.GAME.hpr_tome_plus = G.GAME.hpr_tome_plus or 1
        local to_copy = pseudorandom_element(G.jokers.cards)
        G.E_MANAGER:add_event(Event{
            trigger = "before",
            delay = 0.4,
            func = function ()
                local copy = copy_card(to_copy)
                copy:start_materialize()
                copy:add_to_deck()
                copy:add_sticker("rental", true)
                G.jokers:emplace(copy)
                return true
            end
        })
        G.GAME.rental_rate = G.GAME.rental_rate + G.GAME.hpr_tome_plus
        G.GAME.hpr_tome_plus = G.GAME.hpr_tome_plus + 1
    end
}
--#endregion