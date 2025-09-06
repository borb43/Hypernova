SMODS.Voucher {
    key = "stacking",
    atlas = "placeholder",
    pos = { x = 3, y = 1 },
    config = { extra = { rate = 1 } },
    redeem = function (self, voucher)
        G.GAME.hpr_perma_bonus_rate = (G.GAME.hpr_perma_bonus_rate or voucher.ability.extra.rate)
    end
}

local create_card_ref = create_card
create_card = function(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    local ret_card = create_card_ref(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    if ret_card.ability.set == "Default" or ret_card.ability.set == "Enhanced" then
        if G.GAME and G.GAME.hpr_perma_bonus_rate and G.GAME.hpr_perma_bonus_rate > 0 then
            if pseudorandom("stacking") < 0.75 * G.GAME.hpr_perma_bonus_rate then ret_card.ability.perma_bonus = (ret_card.ability.perma_bonus or 0) + pseudorandom("stacking_buff", 10, 60) end
            if pseudorandom("stacking") < 0.75 * G.GAME.hpr_perma_bonus_rate then ret_card.ability.perma_h_chips = (ret_card.ability.perma_h_chips or 0) + pseudorandom("stacking_buff", 15, 90) end
            if pseudorandom("stacking") < 0.6 * G.GAME.hpr_perma_bonus_rate then ret_card.ability.perma_mult = (ret_card.ability.perma_mult or 0) + pseudorandom("stacking_buff", 2, 10) end
            if pseudorandom("stacking") < 0.6 * G.GAME.hpr_perma_bonus_rate then ret_card.ability.perma_h_mult = (ret_card.ability.perma_h_mult or 0) + pseudorandom("stacking_buff", 3, 15) end
            if pseudorandom("stacking") < 0.35 * G.GAME.hpr_perma_bonus_rate then ret_card.ability.perma_x_chips = (ret_card.ability.perma_x_chips or 1) + (pseudorandom("stacking_buff", 1, 10)/10) end
            if pseudorandom("stacking") < 0.35 * G.GAME.hpr_perma_bonus_rate then ret_card.ability.perma_h_x_chips = (ret_card.ability.perma_h_x_chips or 1) + (pseudorandom("stacking_buff", 1, 10)/10) end
            if pseudorandom("stacking") < 0.35 * G.GAME.hpr_perma_bonus_rate then ret_card.ability.perma_x_mult = (ret_card.ability.perma_x_mult or 1) + (pseudorandom("stacking_buff", 1, 10)/10) end
            if pseudorandom("stacking") < 0.35 * G.GAME.hpr_perma_bonus_rate then ret_card.ability.perma_h_x_mult = (ret_card.ability.perma_h_x_mult or 1) + (pseudorandom("stacking_buff", 1, 10)/10) end
            if pseudorandom("stacking") < 0.25 * G.GAME.hpr_perma_bonus_rate then ret_card.ability.perma_p_dollars = (ret_card.ability.perma_p_dollars or 0) + pseudorandom("stacking_buff", 1, 4) end
            if pseudorandom("stacking") < 0.25 * G.GAME.hpr_perma_bonus_rate then ret_card.ability.perma_h_dollars = (ret_card.ability.perma_h_dollars or 0) + pseudorandom("stacking_buff", 1, 6) end
            if pseudorandom("stacking") < 0.1 * G.GAME.hpr_perma_bonus_rate then ret_card.ability.perma_repetitions = (ret_card.ability.perma_repetitions or 0) + 1 end
        end
    end
    return ret_card
end

SMODS.Voucher {
    key = "massprod",
    atlas = "placeholder",
    pos = { x = 4, y = 1 },
    config = { extra = { rate = 1.5 } },
    redeem = function (self, voucher)
        G.GAME.hpr_perma_bonus_rate = (G.GAME.hpr_perma_bonus_rate or 1) * voucher.ability.extra.rate
    end,
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.rate }}
    end
}