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
    in_pool = function (self, args)
        if G.shop_vouchers and G.load_shop_vouchers.cards then
            for _, v in ipairs(G.shop_vouchers.cards) do
                if v.config.center.key == self.exclusive then return false end
            end
        end
        return not G.GAME.used_vouchers[self.exclusive or ""]
    end
}

