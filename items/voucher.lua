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
