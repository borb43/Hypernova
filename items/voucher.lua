SMODS.Voucher { --stacking, gives cards a chance to spawn with perma chips and mult effects
    key = "stacking",
    atlas = "voucher",
    pos = { x = 0, y = 0 },
    hpr_credits = {
        code = "Eris",
        idea = "Eris"
    }
}

SMODS.Voucher { --mass production, lets xmult and xchip bonuses spawn
    key = "massprod",
    atlas = "placeholder",
    pos = { x = 4, y = 1 },
    requires = { "v_hpr_stacking" },
    hpr_credits = {
        code = "Eris",
        idea = "Eris"
    }
}

SMODS.Voucher {
    key = "shrine",
    atlas = "voucher",
    pos = { x = 1, y = 0 },
    config = { extra = {mod = 1.5} },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.mod }}
    end,
    redeem = function (self, voucher)
        G.GAME.hpr_moons_mult = (G.GAME.hpr_moons_mult or 1) * voucher.ability.extra.mod
    end,
    unredeem = function (self, voucher)
        G.GAME.hpr_moons_mult = (G.GAME.hpr_moons_mult or 1) / voucher.ability.extra.mod
    end,
    hpr_credits = {
        code = "Eris",
        idea = "Eris"
    }
}

SMODS.Voucher {
    key = "blessing",
    atlas = "placeholder",
    pos = { x = 4, y = 1 },
    redeem = function (self, voucher)
        G.GAME.hpr_moons_rate = 2
    end,
    unredeem = function ()
        G.GAME.hpr_moons_rate = 0
    end,
    hpr_credits = {
        code = "Eris",
        idea = "Eris"
    }
}