--#region normal vouchers
SMODS.Voucher { --stacking, gives cards a chance to spawn with perma chips and mult effects
    key = "stacking",
    atlas = "voucher",
    pos = { x = 0, y = 0 },
    attributes = { "shop", "perma_bonus", "chips", "mult", "playing_card" },
}

SMODS.Voucher { --mass production, lets xmult and xchip bonuses spawn
    key = "massprod",
    atlas = "placeholder",
    pos = { x = 4, y = 1 },
    requires = { "v_hpr_stacking" },
    attributes = { "shop", "perma_bonus", "xchips", "xmult", "playing_card" },
}

SMODS.Voucher {
    key = "recursion",
    atlas = "placeholder",
    pos = { x = 3, y = 1 },
    attributes = { "booster", }
}

SMODS.Voucher {
    key = "order_chaos",
    atlas = "placeholder",
    pos = { x = 4, y = 1 },
    requires = { "v_hpr_recursion" },
    attributes = { "booster", "consumable", "voucher" }
}
--#endregion