--#region normal vouchers
SMODS.Voucher { --stacking, gives cards a chance to spawn with perma chips and mult effects
    key = "stacking",
    atlas = "voucher",
    pos = { x = 0, y = 0 },
    hpr_credits = {
        code = {"Eris"},
        idea = {"Eris"},
        art = {"Eris"}
    }
}

SMODS.Voucher { --mass production, lets xmult and xchip bonuses spawn
    key = "massprod",
    atlas = "placeholder",
    pos = { x = 4, y = 1 },
    requires = { "v_hpr_stacking" },
    hpr_credits = {
        code = {"Eris"},
        idea = {"Eris"},
        art = {"Eris"}
    }
}
--#endregion
--#region branched T3 vouchers
HPR.BranchingVoucher = SMODS.Voucher:extend{
    atlas = "hpr_placeholder",
    pos = { x = 5, y = 1 },
    --soul_pos = {},
    in_pool = function (self, args)
        if G.shop_vouchers and G.load_shop_vouchers.cards then
            for _, v in ipairs(G.shop_vouchers.cards) do
                if v.config.center.key == self.exclusive then return false end
            end
        end
        return not G.GAME.used_vouchers[self.exclusive or ""]
    end
}

HPR.BranchingVoucher{
    key = "multistock",
    config = { extra = 1 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra }}
    end,
    requires = {"v_overstock_plus"},
    exclusive = "v_hpr_overstuffed",
    redeem = function (self, card)
        SMODS.change_booster_limit(card.ability.extra)
        SMODS.change_voucher_limit(card.ability.extra)
    end,
    unredeem = function (self, card)
        SMODS.change_booster_limit(-card.ability.extra)
        SMODS.change_voucher_limit(-card.ability.extra)
    end
}

HPR.BranchingVoucher{
    key = "overstuffed",
    config = { extra = 2 },
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra}}
    end,
    requires = {"v_overstock_plus"},
    exclusive = "v_hpr_multistock",
    redeem = function (self, card)
        G.GAME.modifiers.booster_choice_mod = (G.GAME.modifiers.booster_choice_mod or 0) + card.ability.extra
    end,
    unredeem = function (self, card)
        G.GAME.modifiers.booster_choice_mod = (G.GAME.modifiers.booster_choice_mod or 0) - card.ability.extra
    end
}

HPR.BranchingVoucher{
    key = "samples",
    requires = { "v_liquidation" },
    exclusive = "v_hpr_monopoly",
}

HPR.BranchingVoucher{
    key = "monopoly",
    requires = {"v_liquidation"},
    exclusive = "v_hpr_samples",
    config = { extra = 1 },
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra}}
    end,
    redeem = function (self, card)
        G.GAME.hpr_cost_reduction = (G.GAME.hpr_cost_reduction or 0) + card.ability.extra
    end
}