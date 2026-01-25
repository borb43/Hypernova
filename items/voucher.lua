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
        if G.shop_vouchers and G.shop_vouchers.cards then
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
        SMODS.change_voucher_limit(card.ability.extra)
    end,
    unredeem = function (self, card)
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
        SMODS.change_booster_limit(card.ability.extra)
    end,
    unredeem = function (self, card)
        SMODS.change_booster_limit(card.ability.extra)
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

HPR.BranchingVoucher{
    key = "claw_arm",
    requires = {"v_nacho_tong"},
    exclusive = "v_hpr_garden_gloves",
    config = { extra = 2 },
    loc_vars = function (self, info_queue, card)
        return{vars={card.ability.extra}}
    end,
    redeem = function (self, card)
        SMODS.change_play_limit(card.ability.extra)
    end,
    unredeem = function (self, card)
        SMODS.change_play_limit(-card.ability.extra)
    end
}

HPR.BranchingVoucher{
    key = "garden_gloves",
    requires = {"v_nacho_tong"},
    exclusive = "v_hpr_claw_arm",
    config = { extra = 1 },
    loc_vars = function (self, info_queue, card)
        return{vars={card.ability.extra}}
    end,
    redeem = function (self, card)
        G.GAME.modifiers.money_per_hand = (G.GAME.modifiers.money_per_hand or 1) + card.ability.extra
    end,
    unredeem = function (self, card)
        G.GAME.modifiers.money_per_hand = (G.GAME.modifiers.money_per_hand or 1) - card.ability.extra
    end,
}

HPR.BranchingVoucher{
    key = "bulk_waste",
    requires = {"v_recyclomancy"},
    exclusive = "v_hpr_upcycling",
    config = { extra = 2 },
    loc_vars = function (self, info_queue, card)
        return{vars={card.ability.extra}}
    end,
    redeem = function (self, card)
        SMODS.change_discard_limit(card.ability.extra)
    end,
    unredeem = function (self, card)
        SMODS.change_discard_limit(-card.ability.extra)
    end,
}

HPR.BranchingVoucher{
    key = "upcycling",
    requires = {"v_recyclomancy"},
    exclusive = "v_hpr_bulk_waste",
    config = { extra = 1 },
    loc_vars = function (self,info_queue,card)
        return{vars={card.ability.extra}}
    end,
    redeem = function (self, card)
        G.GAME.modifiers.money_per_discard = (G.GAME.modifiers.money_per_discard or 0) + card.ability.extra
    end,
    unredeem = function (self, card)
        G.GAME.modifiers.money_per_discard = (G.GAME.modifiers.money_per_discard or 0) - card.ability.extra
    end,
}

HPR.BranchingVoucher{
    key = "tarot_shipment",
    requires = {"v_tarot_tycoon"},
    exclusive = "v_hpr_tarot_augment",
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_TAGS.tag_hpr_mini_charm
        local name = localize{ type = "name_text", key = "tag_hpr_mini_charm", set = "Tag" }
        return { vars = {name}}
    end,
    calculate = function (self, card, context)
        if context.ending_shop then
            G.E_MANAGER:add_event(Event({
                func = function()
                    add_tag(Tag('tag_hpr_mini_charm'))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end
            }))
        end
    end
}

HPR.BranchingVoucher{
    key = "tarot_augment",
    requires = {"v_tarot_tycoon"},
    exclusive = "v_hpr_tarot_shipment",
    config = { extra = 2 },
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
        local n, d = SMODS.get_probability_vars(card, 1, card.ability.extra, self.key)
        return{vars={n,d}}
    end,
    calculate = function (self, card, context)
        if context.using_consumeable and not (context.consumeable.edition and context.consumeable.edition.negative) and context.consumeable.ability.set == "Tarot" and SMODS.pseudorandom_probability(card,self.key,1,card.ability.extra) then
            local c = context.consumeable
            G.E_MANAGER:add_event(Event{
                func = function()
                    local copied_card = copy_card(c)
                    copied_card:set_edition("e_negative", true)
                    copied_card:add_to_deck()
                    G.consumeables:emplace(copied_card)
                    return true
                end
            })
        end
    end
}

HPR.BranchingVoucher{
    key = "planet_shipment",
    requires = {"v_planet_tycoon"},
    exclusive = "v_hpr_planet_augment",
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_TAGS.tag_hpr_mini_meteor
        local name = localize{ type = "name_text", key = "tag_hpr_mini_meteor", set = "Tag" }
        return { vars = {name}}
    end,
    calculate = function (self, card, context)
        if context.ending_shop then
            G.E_MANAGER:add_event(Event({
                func = function()
                    add_tag(Tag('tag_hpr_mini_meteor'))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end
            }))
        end
    end
}

HPR.BranchingVoucher{
    key = "planet_augment",
    requires = {"v_planet_tycoon"},
    exclusive = "v_hpr_planet_shipment",
    config = { extra = 2 },
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
        local n, d = SMODS.get_probability_vars(card, 1, card.ability.extra, self.key)
        return{vars={n,d}}
    end,
    calculate = function (self, card, context)
        if context.using_consumeable and not (context.consumeable.edition and context.consumeable.edition.negative) and context.consumeable.ability.set == "Planet" and SMODS.pseudorandom_probability(card,self.key,1,card.ability.extra) then
            local c = context.consumeable
            G.E_MANAGER:add_event(Event{
                func = function()
                    local copied_card = copy_card(c)
                    copied_card:set_edition("e_negative", true)
                    copied_card:add_to_deck()
                    G.consumeables:emplace(copied_card)
                    return true
                end
            })
        end
    end
}

HPR.BranchingVoucher{
    key = "money_orchard",
    requires = {"v_money_tree"},
    exclusive = "v_hpr_money_harvest",
    config = { extra = 1 },
    loc_vars = function (self,  info_queue, card)
        return{vars={card.ability.extra}}
    end,
    redeem = function (self, card)
        G.GAME.interest_amount = G.GAME.interest_amount + card.ability.extra
    end,
    unredeem = function (self, card)
        G.GAME.interest_amount = G.GAME.interest_amount - card.ability.extra
    end
}

HPR.BranchingVoucher{
    key = "money_harvest",
    requires = {"v_money_tree"},
    exclusive = "v_hpr_money_orchard",
    config = { extra = 10 },
    loc_vars = function (self, info_queue, card)
        return{ vars = {card.ability.extra}}
    end,
    calc_dollar_bonus = function (self, card)
        return card.ability.extra
    end
}

HPR.BranchingVoucher{
    key = "tachyon",
    requires = {"v_antimatter"},
    exclusive = "v_hpr_graviton",
    calculate = function (self, card, context)
        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card == G.jokers.cards[1] then
            return { repetitions = 1 }
        end
    end
}

HPR.BranchingVoucher{
    key = "graviton",
    requires = {"v_antimatter"},
    exclusive = "v_hpr_tachyon",
}

HPR.BranchingVoucher{
    key = "magician",
    requires = {"v_illusion"},
    exclusive = "v_hpr_conjuring",
}

HPR.BranchingVoucher{
    key = "conjuring",
    requires = {"v_illusion"},
    exclusive = "v_hpr_magician",
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_TAGS.tag_standard
        local name = localize{ type = "name_text", key = "tag_standard", set = "Tag" }
        return { vars = {name}}
    end,
    calculate = function (self, card, context)
        if context.ending_shop then
            G.E_MANAGER:add_event(Event({
                func = function()
                    add_tag(Tag('tag_standard'))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end
            }))
        end
    end
}

HPR.BranchingVoucher{
    key = "fossil",
    requires = {"v_petroglyph"},
    exclusive = "v_hpr_stasis",
    config = { extra = 1 },
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra}}
    end,
    redeem = function (self, card)
        ease_ante(-card.ability.extra)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - card.ability.extra
    end,
    unredeem = function (self, card)
        ease_ante(card.ability.extra)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + card.ability.extra
    end
}

HPR.BranchingVoucher{
    key = "stasis",
    requires = {"v_petroglyph"},
    exclusive = "v_hpr_fossil",
    config = { extra = 0.9 },
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra}}
    end,
    redeem = function (self, card)
        G.GAME.hpr_stasis = card.ability.extra
    end
}

HPR.BranchingVoucher{
    key = "staged",
    requires = {"v_retcon"},
    exclusive = "v_hpr_paid_actor",
    calculate = function (self, card, context)
        if context.hand_drawn and G.GAME.current_round.hands_left <= 1 and G.GAME.blind and G.GAME.blind.boss and not G.GAME.blind.disabled then
            return{
                message = localize("ph_boss_disabled"),
                func = function ()
                    G.GAME.blind:disable()
                end
            }
        end
    end
}

HPR.BranchingVoucher{
    key = "paid_actor",
    requires = {"v_retcon"},
    exclusive = "v_hpr_staged",
    config = { extra = 25 },
    loc_vars = function (self, info_queue, card)
        return{ vars = {card.ability.extra}}
    end,
    calc_dollar_bonus = function (self, card)
        if G.GAME.last_blind and G.GAME.last_blind.boss then
            return card.ability.extra
        end
    end
}

HPR.BranchingVoucher{
    key = "paint_bucket",
    requires = {"v_palette"},
    exclusive = "v_hpr_magic_wand",
    config = { extra = 1 },
    loc_vars = function (self, info_queue, card)
        return{vars={card.ability.extra}}
    end,
    redeem = function (self, card)
        SMODS.change_play_limit(card.ability.extra)
        SMODS.change_discard_limit(card.ability.extra)
    end,
    unredeem = function (self, card)
        SMODS.change_play_limit(-card.ability.extra)
        SMODS.change_discard_limit(-card.ability.extra)
    end,
}

HPR.BranchingVoucher{
    key = "magic_wand",
    requires = {"v_palette"},
    exclusive = "v_hpr_paint_bucket",
}

HPR.BranchingVoucher{
    key = "falsified",
    requires = {"v_hpr_massprod"},
    exclusive = "v_hpr_fool_gold",
}
HPR.BranchingVoucher{
    key = "fool_gold",
    requires = {"v_hpr_massprod"},
    exclusive = "v_hpr_falsified"
}
--#endregion