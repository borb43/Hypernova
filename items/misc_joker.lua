SMODS.Joker { --fusion reactor, balances before scoring
    key = "fusion",
    atlas = "placeholder",
    pos = { x = 1, y = 0 },
    rarity = 2,
    cost = 7,
    blueprint_compat = true,
    demicoloncompat = true,
    calculate = function(self, card, context)
        if context.initial_scoring_step or context.forcetrigger then
            return {
                balance = true
            }
        end
    end,
    hpr_credits = {
        code = "Eris"
    }
}

SMODS.Joker { --growth, increases potency of other joker effects
    key = "growth",
    atlas = "placeholder",
    pos = { x = 2, y = 0 },
    config = { extra = { eff_mod = 1, scale = 0.1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.eff_mod, card.ability.extra.scale } }
    end,
    rarity = 3,
    cost = 10,
    perishable_compat = false,
    calculate = function(self, card, context)
        if context.post_trigger and not context.blueprint and context.other_card.ability.set == "Joker" then
            local other_ret = context.other_ret.jokers or {}
            HPR.manipulate_ret(other_ret, card.ability.extra.eff_mod)
        end
        if (context.end_of_round and context.main_eval and not context.blueprint) or context.forcetrigger then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "eff_mod",
                scalar_value = "scale"
            })
        end
    end,
    hpr_credits = {
        code = "Eris",
        idea = "Eris"
    }
}


SMODS.Joker { -- solar flare, levels up not most played hands and destroys some cards
    key = "solar",
    atlas = "joker",
    pos = { x = 0, y = 0 },
    config = { extra = { destroyed = 2 } },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.destroyed } }
    end,
    rarity = 3,
    cost = 10,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.before and G.GAME.current_round.hands_played == 0 then
            local _handname, _played = 'High Card', -1
            for hand_key, hand in pairs(G.GAME.hands) do
                if hand.played > _played then
                    _played = hand.played
                    _handname = hand_key
                end
            end
            if context.scoring_name ~= _handname then
                local options = {}
                for _, c in ipairs(G.play.cards) do
                    if not SMODS.is_eternal(c) then options[#options+1] = c end
                end
                for _ = 1, math.min(card.ability.extra.destroyed, #options) do
                    local roll, pos = pseudorandom_element(options, "hpr_solar")
                    roll.hpr_solar_destroy = true
                    table.remove(options, pos)
                end
                return {
                    level_up = 1,
                    message = localize("k_upgrade_ex"),
                    colour = G.C.GREEN
                }
            end
        end
        if context.destroy_card and not context.blueprint and G.GAME.current_round.hands_played == 0 then
            local _handname, _played = 'High Card', -1
            for hand_key, hand in pairs(G.GAME.hands) do
                if hand.played > _played then
                    _played = hand.played
                    _handname = hand_key
                end
            end
            if context.scoring_name ~= _handname and context.destroy_card.hpr_solar_destroy then
                return { remove = true }
            end
        end
    end,
    hpr_credits = {
        art = "Codifyd",
        code = "Eris",
        idea = "Codifyd"
    }
}

SMODS.Joker { --tipping scales, increases numerator and denominator of probabilities
    key = "scales",
    atlas = "placeholder",
    pos = { x = 0, y = 0 },
    config = { extra = { mod = 1 } },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.mod } }
    end,
    rarity = 1,
    cost = 5,
    calculate = function (self, card, context)
        if context.mod_probability and not context.blueprint then
            return {
                numerator = context.numerator + card.ability.extra.mod,
                denominator = context.denominator + card.ability.extra.mod
            }
        end
    end,
    hpr_credits = {
        code = "Eris",
        idea = "Eris"
    }
}


SMODS.Joker { --gambling addict, scales from probability rolls
    key = "gambler",
    atlas = "placeholder",
    pos = { x = 1, y = 0 },
    config = { extra = { chips = 0, mult = 0, multiplier = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
    end,
    rarity = 3,
    cost = 7,
    blueprint_compat = true,
    demicoloncompat = true,
    calculate = function(self, card, context)
        if context.pseudorandom_result then
            if not context.result then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "chips",
                    scalar_value = "multiplier",
                    operation = function(ref_table, ref_value, initial, change)
                        ref_table[ref_value] = initial + change * context.denominator
                    end,
                    message = {
                        colour = G.C.CHIPS,
                        message_key = "a_chips"
                    }
                })
            elseif context.result then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "mult",
                    scalar_value = "multiplier",
                    operation = function(ref_table, ref_value, initial, change)
                        ref_table[ref_value] = initial + change * context.denominator
                    end,
                    message = {
                        colour = G.C.MULT,
                        message_key = "a_mult"
                    }
                })
            end
        end
        if context.joker_main or context.forcetrigger then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end
    end,
    hpr_credits = {
        code = "Eris",
        idea = "Eris"
    }
}

SMODS.Joker { --fortune cookie, guarantees 6 probabilities and then creates a negative tarot
    key = "fortune",
    atlas = "placeholder",
    pos = { x = 1, y = 0 },
    config = { extra = 6 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra } }
    end,
    rarity = 2,
    cost = 6,
    demicoloncompat = true,
    blueprint_compat = true,
    pools = { ["Food"] = true },
    calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint then
            if context.from_roll then
                card.ability.extra = card.ability.extra - 1
                if card.ability.extra <= 0 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card { set = 'Tarot', edition = 'e_negative' }
                            SMODS.destroy_cards(card, nil, nil, true)
                            return true
                        end
                    }))
                end
            end
            return {
                numerator = context.denominator
            }
        end
        if context.forcetrigger then
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card { set = 'Tarot', edition = 'e_negative' }
                end
            }))
        end
    end,
    hpr_credits = {
        code = "Eris",
        idea = "Eris"
    }
}
