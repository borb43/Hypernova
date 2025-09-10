
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
            local upgrade
            for k, v in pairs(other_ret) do
                if type(other_ret[k]) == "number" and k ~= "numerator" and k ~= "denominator" and k ~= "level_up" then
                    other_ret[k] = other_ret[k] * card.ability.extra.eff_mod
                    upgrade = true
                elseif type(v) == "table" and not v.config then HPR.growth_recursive(card, v)
                end
            end
            if upgrade then
                return {
                    message = localize("k_upgrade_ex")
                }
            end
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

HPR.growth_recursive = function(card, table)
    for k, v in pairs(table) do
        if type(table[k]) == "number" and k ~= "numerator" and k ~= "denominator" and k ~= "level_up" and type(k) ~= "number" then
            table[k] = table[k] * card.ability.extra.eff_mod
            upgrade = true
        elseif type(v) == "table" and not v.config and type(k) ~= "number" then HPR.growth_recursive(card, v)
        end
    end
end
