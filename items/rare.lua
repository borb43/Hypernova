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
                    if k == "dollars" or k == "p_dollars" or k == "h_dollars" then
                        other_ret[k] = math.floor(other_ret[k])
                    end
                    upgrade = true
                elseif type(v) == "table" and not v.config then
                    HPR.growth_recursive(card, v)
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
        if type(table[k]) == "number" and k ~= "numerator" and k ~= "denominator" and type(k) ~= "number" and k ~= "level_up" then
            table[k] = table[k] * card.ability.extra.eff_mod
            if k == "dollars" or k == "p_dollars" or k == "h_dollars" then
                table[k] = math.floor(table[k])
            end
            upgrade = true
        elseif type(v) == "table" and not v.config and type(k) ~= "number" then
            HPR.growth_recursive(card, v)
        end
    end
end

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
                return {
                    level_up = 1,
                    message = localize("k_upgrade_ex"),
                    colour = G.C.GREEN
                }
            end
        end
        if context.after and not context.blueprint then
            local _handname, _played = 'High Card', -1
            for hand_key, hand in pairs(G.GAME.hands) do
                if hand.played > _played then
                    _played = hand.played
                    _handname = hand_key
                end
            end
            if context.scoring_name ~= _handname then
                local destroy = {}
                for i = 1, math.min(card.ability.extra.destroyed, #context.full_hand) do
                    local eligible = true
                    for _, card in ipairs(destroy) do
                        if card == context.full_hand[i] then eligible = false end
                    end
                    if eligible then destroy[#destroy+1] = context.full_hand[i] end
                end
                SMODS.destroy_cards(destroy)
            end
        end
    end
}
