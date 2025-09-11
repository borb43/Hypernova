SMODS.ConsumableType {
    key = "hpr_moons",
    default = "c_hpr_deimos",
    primary_colour = HEX("5d15d1"),
    secondary_colour = HEX("707b8c")
}

SMODS.Consumable {
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
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.per_charge
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
--[[ --temp removed for reworking
SMODS.Consumable {
    key = "styx",
    set = "hpr_moons",
    atlas = "placeholder",
    pos = { x = 3, y = 2 },
    config = { extra = { hand_type = "High Card", copies = 0, per_charge = 1, max_highlighted = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hand_type, card.ability.extra.copies, card.ability.extra.per_charge, card.ability.extra.max_highlighted } }
    end,
    calculate = function(self, card, context)
        if context.before and context.scoring_name == card.ability.extra.hand_type then
            card.ability.extra.copies = card.ability.extra.copies + card.ability.extra.per_charge
            SMODS.smart_level_up_hand(card, card.ability.extra.hand_type, nil, -1)
            return {
                message = localize("k_upgrade_ex")
            }
        end
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = function()
                local _first_dissolve = nil
                local new_cards = {}
                for i = 1, math.floor(card.ability.extra.copies) do
                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    local _card = copy_card(G.hand.highlighted[1], nil, nil, G.playing_card)
                    _card:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, _card)
                    G.hand:emplace(_card)
                    _card:start_materialize(nil, _first_dissolve)
                    _first_dissolve = true
                    new_cards[#new_cards + 1] = _card
                end
                SMODS.calculate_context({ playing_card_added = true, cards = new_cards })
                return true
            end
        }))
    end,
    can_use = function(self, card)
        return card.ability.extra.copies > 0 and #G.hand.highlighted > 0  and #G.hand.highlighted < card.ability.extra.max_highlighted
    end
}
]]
--5oak moon here

--flouse moon here

--flush 5 moon here
