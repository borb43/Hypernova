SMODS.Joker { --growth, increases potency of other joker effects
    key = "growth",
    atlas = "placeholder",
    pos = { x = 2, y = 0 },
    config = { extra = { eff_mod = 1, scale = 0.2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.eff_mod, card.ability.extra.scale } }
    end,
    rarity = 3,
    cost = 10,
    perishable_compat = false,
    calculate = function(self, card, context)
        if context.post_trigger and not context.blueprint then
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
    calc_scaling = function(self, card, other_card, scaling_value, scalar_value, args)
        if card ~= other_card then
            return {
                override_scalar_value = {
                    value = scalar_value * card.ability.extra.eff_mod
                }
            }
        end
    end
}


SMODS.Joker {
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
        if context.before then
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
        if context.destroy_card and not context.blueprint then
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
    end
}
