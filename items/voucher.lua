--#region normal vouchers
SMODS.Voucher { --stacking, gives cards a chance to spawn with perma chips and mult effects
    key = "stacking",
    atlas = "voucher",
    pos = { x = 0, y = 0 },
    hpr_badge_info = {
        { key = "credits_code", vars = {"Eris"} },
        { key = "credits_art", vars = {"Eris"}},
        { key = "credits_idea", vars = {"Eris"}},
    },
}

SMODS.Voucher { --mass production, lets xmult and xchip bonuses spawn
    key = "massprod",
    atlas = "placeholder",
    pos = { x = 4, y = 1 },
    requires = { "v_hpr_stacking" },
    hpr_badge_info = {
        { key = "credits_code", vars = {"Eris"} },
        { key = "credits_idea", vars = {"Eris"}},
    },
}

SMODS.Voucher {
    key = "recursion",
    atlas = "placeholder",
    pos = { x = 3, y = 1 },
    hpr_badge_info = {
        { key = "credits_code", vars = {"Eris"} },
        { key = "credits_idea", vars = {"Eris"}},
    },
}

SMODS.Voucher {
    key = "order_chaos",
    atlas = "placeholder",
    pos = { x = 4, y = 1 },
    requires = { "v_hpr_recursion" },
    hpr_badge_info = {
        { key = "credits_code", vars = {"Eris"} },
        { key = "credits_idea", vars = {"Eris"}},
    },
}
--#endregion