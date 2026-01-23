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
    end,
    unredeem = function (self, card)
        G.GAME.hpr_cost_reduction = (G.GAME.hpr_cost_reduction or 0) - card.ability.extra
    end
}

HPR.BranchingVoucher{
    key = "dark_side",
    requires = {"v_glow_up"},
    exclusive = "v_hpr_prism",
    config = { extra = 5 },
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra}}
    end,
    redeem = function (self, card)
        G.GAME.hpr_negative_mod = (G.GAME.hpr_negative_mod or 1) * card.ability.extra
    end,
    unredeem = function (self, card)
        G.GAME.hpr_negative_mod = (G.GAME.hpr_negative_mod or 1) / card.ability.extra
    end
}

HPR.BranchingVoucher{
    key = "prism",
    requires = {"v_glow_up"},
    exclusive = "v_hpr_dark_side",
    config = { extra = 2 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra }}
    end,
    redeem = function (self, card)
        G.GAME.hpr_edition_rate = (G.GAME.hpr_edition_rate or 1) * card.ability.extra
    end,
    unredeem = function (self, card)
        G.GAME.hpr_edition_rate = (G.GAME.hpr_edition_rate or 1) / card.ability.extra
    end
}

HPR.BranchingVoucher{
    key = "reroll_overflow",
    requires = {"v_reroll_glut"},
    exclusive = "v_hpr_reroll_bargain",
    config = { extra = 2 },
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra}}
    end,
    redeem = function (self, card)
        SMODS.change_free_rerolls(card.ability.extra)
    end,
    unredeem = function (self, card)
        SMODS.change_free_rerolls(-card.ability.extra)
    end
}

HPR.BranchingVoucher{
    key = "reroll_bargain",
    requires = {"v_reroll_glut"},
    exclusive = "v_hpr_reroll_overflow",
    calculate = function (self, card, context)
        if context.reroll_shop then
            G.E_MANAGER:add_event(Event{
                func = function ()
                    for _, c in ipairs(G.shop_booster.cards) do
                        c:start_dissolve()
                    end
                    for i = 1, G.shop_booster.config.card_limit do
                        local c = SMODS.add_card{
                            area = G.shop_booster,
                            key = get_pack('shop_pack').key,
                            set = "Booster"
                        }
                        create_shop_card_ui(c, "Booster", G.shop_booster)
                        c:start_materialize()
                    end
                    return true
                end
            })
        end
    end
}

HPR.BranchingVoucher{
    key = "void_cradle",
    requires = {"v_omen_globe"},
    exclusive = "v_hpr_astrology"
}

HPR.BranchingVoucher{
    key = "astrology",
    requires = {"v_omen_globe"},
    exclusive = "v_hpr_void_cradle"
}

HPR.BranchingVoucher{
    key = "satellite",
    requires = {"v_observatory"},
    exclusive = "v_hpr_colony",
    config = { extra = 5 },
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra}}
    end,
    calculate = function (self, card, context)
        if context.using_consumeable and context.consumeable.ability.set == "Planet" then
            for _, c in ipairs(G.playing_cards) do
                c.ability.perma_bonus = c.ability.perma_bonus + card.ability.extra
            end
        end
    end
}

HPR.BranchingVoucher{
    key = "colony",
    requires = {"v_observatory"},
    exclusive = "v_hpr_satellite",
    config = { extra = 4 },
    loc_vars = function (self, info_queue, card)
        local n, d = SMODS.get_probability_vars(card, 1, card.ability.extra, self.key)
        return{vars={n,d}}
    end,
    calculate = function (self, card, context)
        if context.before then
            for _, c in ipairs(G.consumeables.cards) do
                if c.ability.consumeable and c.ability.set == "Planet" and (c.ability.consumeable.hand_type == context.scoring_name or HPR.contains(c.ability.consumeable.hand_types,context.scoring_name)) and SMODS.pseudorandom_probability(card, self.key, 1, card.ability.extra) then
                    SMODS.calculate_effect({level_up = true, message = localize("k_level_up_ex"), message_card = c})
                end
            end
        end
    end
}