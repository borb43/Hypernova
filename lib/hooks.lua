local create_card_ref = create_card --hook for applying perma bonuses to cards (for stacking and mass production)
create_card = function(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    local ret_card = create_card_ref(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    if ret_card.ability.set == "Default" or ret_card.ability.set == "Enhanced" then
        if G.GAME and G.GAME.used_vouchers.v_hpr_stacking then
            if pseudorandom("stacking") < 0.5 then ret_card.ability.perma_bonus = (ret_card.ability.perma_bonus or 0) + pseudorandom("stacking_buff", 10, 60) end
            if pseudorandom("stacking") < 0.5 then ret_card.ability.perma_h_chips = (ret_card.ability.perma_h_chips or 0) + pseudorandom("stacking_buff", 15, 90) end
            if pseudorandom("stacking") < 0.4 then ret_card.ability.perma_mult = (ret_card.ability.perma_mult or 0) + pseudorandom("stacking_buff", 2, 10) end
            if pseudorandom("stacking") < 0.4 then ret_card.ability.perma_h_mult = (ret_card.ability.perma_h_mult or 0) + pseudorandom("stacking_buff", 3, 15) end
        end
        if G.GAME and G.GAME.used_vouchers.v_hpr_massprod then
            if pseudorandom("stacking") < 0.25 then ret_card.ability.perma_x_chips = (ret_card.ability.perma_x_chips or 1) + (pseudorandom("stacking_buff", 1, 10)/10) end
            if pseudorandom("stacking") < 0.25 then ret_card.ability.perma_h_x_chips = (ret_card.ability.perma_h_x_chips or 1) + (pseudorandom("stacking_buff", 1, 10)/10) end
            if pseudorandom("stacking") < 0.25 then ret_card.ability.perma_x_mult = (ret_card.ability.perma_x_mult or 1) + (pseudorandom("stacking_buff", 1, 10)/10) end
            if pseudorandom("stacking") < 0.25 then ret_card.ability.perma_h_x_mult = (ret_card.ability.perma_h_x_mult or 1) + (pseudorandom("stacking_buff", 1, 10)/10) end
        end
    end
    return ret_card
end

local loc_perma_bonus_ref = SMODS.localize_perma_bonuses
SMODS.localize_perma_bonuses = function (specific_vars, desc_nodes)
    loc_perma_bonus_ref(specific_vars, desc_nodes)
    if specific_vars and specific_vars.bonus_eff_mod then
        localize{type = "other", key = "card_extra_eff_mod", nodes = desc_nodes, vars = {specific_vars.bonus_eff_mod}}
    end
end