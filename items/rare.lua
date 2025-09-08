SMODS.Joker { --growth, increases potency of other joker effects
    key = "growth",
    atlas = "placeholder",
    pos = { x = 2, y = 0 },
    config = { extra = { eff_mod = 1, scale = 0.2 } },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.eff_mod, card.abilit.extra.scale } }
    end,
    rarity = 3,
    cost = 10,
    perishable_compat = false,
    calculate = function (self, card, context)
        if context.post_trigger and not context.blueprint then
            local other_ret = context.other_ret.jokers or {}
            local upgrade
            for k, v in pairs(other_ret) do
                if type(v) == "number" and k ~= "numerator" and k ~= "denominator" and k ~= "level_up" then
                    v = v * card.ability.extra.eff_mod
                    upgrade = true
                end
            end
            if upgrade then
                return {
                    message = localize("k_upgrade_ex")
                }
            end
        end
        if context.end_of_round and context.main_eval and not context.blueprint then
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