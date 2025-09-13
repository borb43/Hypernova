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
            SMODS.smart_level_up_hand(card, context.scoring_name, nil, -1)
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
    can_use = function(self, card)
        return card.ability.extra.mult ~= 0 and #G.hand.highlighted > 0 and
            #G.hand.highlighted < card.ability.extra.max_highlighted
    end
}


SMODS.Consumable { --3oak moon, applies random enhancements
    key = "io",
    set = "hpr_moons",
    atlas = "placeholder",
    pos = { x = 3, y = 2 },
    config = { extra = { hand_type = "Three of a Kind", per_charge = 1 }, max_highlighted = 0 },
    loc_vars = function(self, info_queue, card)
        return { vars = { localize(card.ability.extra.hand_type, "poker_hands"), card.ability.max_highlighted, card.ability.extra.per_charge } }
    end,
    calculate = function(self, card, context)
        if context.before and context.scoring_name == card.ability.extra.hand_type then
            SMODS.scale_card(card, {
                ref_table = card.ability,
                ref_value = "max_highlighted",
                scalar_table = card.ability.extra,
                scalar_value = "per_charge"
            })
            SMODS.smart_level_up_hand(card, context.scoring_name, nil, -1)
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

SMODS.Consumable { --full house moon, creates jokers
    key = "moon",
    set = "hpr_moons",
    atlas = "placeholder",
    pos = { x = 3, y = 2 },
    config = { extra = { hand_type = "Full House", jokers = 0, per_charge = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { localize(card.ability.extra.hand_type, "poker_hands"), card.ability.extra.jokers, card.ability.extra.per_charge } }
    end,
    calculate = function(self, card, context)
        if context.before and context.scoring_name == card.ability.extra.hand_type then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "jokers",
                scalar_value = "per_charge"
            })
            SMODS.smart_level_up_hand(card, context.scoring_name, nil, -1)
        end
    end,
    use = function(self, card, area, copier)
        local joker_amount = math.min(card.ability.extra.jokers,
            G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
        G.GAME.joker_buffer = G.GAME.joker_buffer + joker_amount
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound("timpani")
                for _ = 1, joker_amount do
                    SMODS.add_card({
                        set = "Joker",
                        key_append = "c_hpr_moon"
                    })
                end
                card:juice_up(0.3, 0.5)
                G.GAME.joker_buffer = 0
                return true
            end
        }))
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards < G.jokers.config.card_limit
    end
}

SMODS.Consumable { --4oak moon, perma xmult stuff
    key = "phobos",
    set = "hpr_moons",
    atlas = "placeholder",
    pos = { x = 3, y = 2 },
    config = { extra = { hand_type = "Four of a Kind", max_highlighted = 4, mult = 0, per_charge = 0.1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { localize(card.ability.extra.hand_type, "poker_hands"), card.ability.extra.max_highlighted, card.ability.extra.mult, card.ability.extra.per_charge } }
    end,
    calculate = function(self, card, context)
        if context.before and context.scoring_name == card.ability.extra.hand_type then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "mult",
                scalar_value = "per_charge"
            })
            SMODS.smart_level_up_hand(card, context.scoring_name, nil, -1)
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
            _card.ability.perma_x_mult = (_card.ability.perma_x_mult or 1) + card.ability.extra.mult
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
    can_use = function (self, card)
        return card.ability.extra.mult ~= 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted and #G.hand.highlighted ~= 0
    end
}

SMODS.Consumable { --flush moon, suit conv stuff
    key = "europa",
    set = "hpr_moons",
    atlas = "placeholder",
    pos = { x = 3, y = 2 },
    config = { extra = { hand_type = "Flush", per_charge = 1 }, max_highlighted = 0, suit_conv = "Spades" },
    loc_vars = function(self, info_queue, card)
        return { vars = { localize(card.ability.extra.hand_type, "poker_hands"), card.ability.max_highlighted, card.ability.extra.per_charge, localize(card.ability.suit_conv, "suits_plural") }, colours = { G.C.SUITS[card.ability.suit_conv] } }
    end,
    calculate = function(self, card, context)
        if context.before and context.scoring_name == card.ability.extra.hand_type then
            SMODS.scale_card(card, {
                ref_table = card.ability,
                ref_value = "max_highlighted",
                scalar_table = card.ability.extra,
                scalar_value = "per_charge"
            })
            local suits = {}
            for _, playing_card in ipairs(context.full_hand) do
                if not SMODS.has_no_suit(playing_card) then
                    suits[#suits + 1] = playing_card.base.suit
                end
            end
            card.ability.suit_conv = pseudorandom_element(suits) or "Spades"
            SMODS.smart_level_up_hand(card, context.scoring_name, nil, -1)
        end
    end
}

--straight moon here

--two pair moon here

SMODS.Consumable {
    key = "Triton",
    set = "hpr_moons",
    atlas = "placeholder",
    pos = { x = 3, y = 2 },
    config = { extra = { hand_type = "Straight Flush", per_charge = 1 }, max_highlighted = 0 },
    loc_vars = function (self, info_queue, card)
        return { vars = { localize(card.ability.extra.hand_type, "poker_hands"), card.ability.max_highlighted, card.ability.extra.per_charge}}
    end,
    calculate = function (self, card, context)
        if context.before and context.scoring_name == card.ability.extra.hand_type then
            SMODS.scale_card(card, {
                ref_table = card.ability,
                ref_value = "max_highlighted",
                scalar_table = card.ability.extra,
                scalar_value = "per_charge"
            })
        end
    end,
    use = function (self, card, area, copier)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.15,
                func = function ()
                    local target = G.hand.highlighted[i]
                    local edition = poll_edition("hpr_trition", nil, true, true)
                    target:set_edition(edition, true)
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end
    end
}

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
            SMODS.smart_level_up_hand(card, context.scoring_name, nil, -1)
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

SMODS.Consumable {
    key = "Nibiru",
    set = "hpr_moons",
    atlas = "placeholder",
    pos = { x = 3, y = 2 },
    config = { extra = { hand_type = "Five of a Kind", rank_conv = "Ace", per_charge = 1 }, max_highlighted = 0 },
    loc_vars = function (self, info_queue, card)
        return { vars = { localize(card.ability.extra.hand_type, "poker_hands"), card.ability.extra.rank_conv, card.ability.max_highlighted}}
    end,
    calculate = function (self, card, context)
        if context.before and context.scoring_name == card.ability.extra.hand_type then
            SMODS.scale_card(card, {
                ref_table = card.ability,
                ref_value = "max_highlighted",
                scalar_table = card.ability.extra,
                scalar_value = "per_charge"
            })
            local ranks = {}
            for _, playing_card in ipairs(context.full_hand) do
                if not SMODS.has_no_rank(playing_card) then
                    ranks[#ranks+1] = playing_card.base.value
                end
            end
            card.ability.extra.rank_conv = pseudorandom_element(ranks) or "Ace"
        end
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
                    assert(SMODS.change_base(G.hand.highlighted[i], nil, card.ability.extra.rank_conv))
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
    end
}

--flouse moon here

--flush 5 moon here
