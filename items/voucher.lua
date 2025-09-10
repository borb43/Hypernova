SMODS.Voucher { --stacking, gives cards a chance to spawn with perma chips and mult effects
    key = "stacking",
    atlas = "placeholder",
    pos = { x = 3, y = 1 },
}

local create_card_ref = create_card --hook for applying perma bonuses to cards
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

SMODS.Voucher { --mass production, lets xmult and xchip bonuses spawn
    key = "massprod",
    atlas = "placeholder",
    pos = { x = 4, y = 1 },
    requires = { "v_hpr_stacking" }
}