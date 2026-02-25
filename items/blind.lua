SMODS.Blind {
    key = "final_horse",
    atlas = "blind_chip",
    pos = { x = 0, y = 2 },
    dollars = 8,
    mult = 2,
    boss = { showdown = true, min = 1 },
    boss_colour = HEX("DF73FF"),
    calculate = function (self, blind, context)
        if not blind.disabled and context.modify_hand then
            blind.triggered = true
            mult = mod_mult(mult^(1/3))
            hand_chips = mod_chips(hand_chips^(1/3))
            update_hand_text({ sound = 'chips2', modded = true }, { chips = hand_chips, mult = mult })
        end
    end
}

SMODS.Blind {
    key = "final_mist",
    atlas = "blind_chip",
    pos = { x = 0, y = 3 },
    dollars = 8,
    mult = 0.1,
    boss = { showdown = true, min = 1 },
    boss_colour = HEX("0BDA51"),
    calculate = function (self, blind, context)
        if not blind.disabled and context.debuff_card and context.debuff_card.area and context.debuff_card.area.config.type == "jokers" then
            return { debuff = true }
        end
    end
}

SMODS.Blind {
    key = "final_splash",
    atlas = "blind_chip",
    pos = { x = 0, y = 4 },
    dollars = 8,
    mult = 2,
    boss = { showdown = true, min = 1 },
    boss_colour = HEX("F4C430"),
    calculate = function (self, blind, context)
        if context.modify_scoring_hand and not next(SMODS.get_enhancements(context.other_card) or {}) then
            return { remove_from_hand = true }
        end
    end
}

SMODS.Blind {
    key = "final_globe",
    atlas = "blind_chip",
    pos = { x = 0, y = 5 },
    dollars = 8,
    mult = 2,
    boss = { showdown = true, min = 1 },
    boss_colour = HEX("DB9D00"),
    set_blind = function (self)
        G.hand:change_size(-1)
        ease_hands_played(-1)
        ease_discard(-1)
    end,
    disable = function (self)
        G.hand:change_size(1)
        ease_hands_played(1)
        ease_discard(1)
    end,
    defeat = function (self)
        if not G.GAME.blind.disabled then
            G.hand:change_size(1)
        end
    end
}

SMODS.Blind {
    key = "final_bomb",
    atlas = "blind_chip",
    pos = { x = 0, y = 6 },
    dollars = 8,
    mult = 2,
    boss = { showdown = true, min = 1 },
    boss_colour = HEX("3E2F28"),
    calculate = function (self, blind, context)
        if context.destroy_card and context.cardarea == G.hand then
            return { remove = true }
        end
    end
}
--[[
SMODS.Blind {
    key = "true_final_star_p1",
    atlas = "blind_chip",
    pos = { x = 0, y = 1 },
    dollars = 10,
    mult = 4,
    boss = { showdown = true, min = math.huge, max = math.huge },
    boss_colour = G.C.BLACK,
    hpr_no_avoid = true,
    hpr_next_phase = "bl_hpr_true_final_star_p2",
    set_blind = function (self)
        if next(G.consumeables.cards) then SMODS.destroy_cards(G.consumeables.cards) end
    end,
    in_pool = function (self)
        return false
    end
}

SMODS.Blind {
    key = "true_final_star_p2",
    atlas = "blind_chip",
    pos = { x = 0, y = 1 },
    dollars = 10,
    mult = 12,
    boss = { showdown = true, min = math.huge, max = math.huge },
    boss_colour = HEX("6caba8"),
    hpr_no_avoid = true,
    hpr_next_phase = "bl_hpr_true_final_star_p3",
    set_blind = function (self) --this gets reverted only at the end of final phase
        if next(G.consumeables.cards) then SMODS.destroy_cards(G.consumeables.cards) end
        G.hand:change_size(-1)
        ease_hands_played(-1)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1
        ease_discard(-1)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - 1
        SMODS.change_play_limit(-1)
        SMODS.change_discard_limit(-1)
        G.jokers:change_size(-1)
        G.consumeables:change_size(-1)
    end,
    in_pool = function (self)
        return false
    end
}

SMODS.Blind {
    key = "true_final_star_p3",
    atlas = "blind_chip",
    pos = { x = 0, y = 1 },
    dollars = 10,
    mult = 36,
    boss = { showdown = true, min = math.huge, max = math.huge },
    boss_colour = G.C.RED,
    hpr_no_avoid = true,
    hpr_next_phase = "bl_hpr_true_final_star_p4",
    set_blind = function (self)
        if next(G.consumeables.cards) then SMODS.destroy_cards(G.consumeables.cards) end
        local destroy_cards = {}
        for _, c in ipairs(G.playing_cards) do
            if not next(SMODS.get_enhancements(c)) and not c:get_seal() and not c.edition then
                local no_mods = true
                for key in ipairs(SMODS.Stickers) do
                    if c.ability[key] then no_mods = false break end
                end
                if no_mods then destroy_cards[#destroy_cards+1] = c end
            end
        end
        if next(destroy_cards) then SMODS.destroy_cards(destroy_cards) end
    end,
    in_pool = function (self)
        return false
    end
}

SMODS.Blind {
    key = "true_final_star_p4",
    atlas = "blind_chip",
    pos = { x = 0, y = 1 },
    dollars = 10,
    mult = 108,
    boss = { showdown = true, min = math.huge, max = math.huge },
    boss_colour = G.C.HPR_STLR,
    hpr_no_avoid = true,
    hpr_next_phase = "bl_hpr_true_final_star_p5",
    set_blind = function (self)
        if next(G.consumeables.cards) then SMODS.destroy_cards(G.consumeables.cards) end
        local destroy_cards = {}
        for _, c in ipairs(G.playing_cards) do
            if not next(SMODS.get_enhancements(c)) and not c:get_seal() and not c.edition then
                local no_mods = true
                for key in ipairs(SMODS.Stickers) do
                    if c.ability[key] then no_mods = false break end
                end
                if no_mods then destroy_cards[#destroy_cards+1] = c end
            end
        end
        if next(destroy_cards) then SMODS.destroy_cards(destroy_cards) end
    end,
    calculate = function (self, blind, context)
        if context.modify_hand then
            local hand = G.GAME.hands[context.scoring_name]
            mod_chips(hand.s_chips)
            mod_mult(hand.s_mult)
        end
    end,
    in_pool = function (self)
        return false
    end
}

SMODS.Blind {
    key = "true_final_star_p5",
    atlas = "blind_chip",
    pos = { x = 0, y = 1 },
    dollars = 10,
    mult = 1,
    boss = { showdown = true, min = math.huge, max = math.huge },
    boss_colour = G.C.HPR_STLR,
    hpr_no_avoid = true,
    set_blind = function (self)
        if next(G.consumeables.cards) then SMODS.destroy_cards(G.consumeables.cards) end
        local destroy_cards = {}
        for _, c in ipairs(G.playing_cards) do
            if not next(SMODS.get_enhancements(c)) and not c:get_seal() and not c.edition then
                local no_mods = true
                for key in ipairs(SMODS.Stickers) do
                    if c.ability[key] then no_mods = false break end
                end
                if no_mods then destroy_cards[#destroy_cards+1] = c end
            end
        end
        if next(destroy_cards) then SMODS.destroy_cards(destroy_cards) end
        G.GAME.blind.chips = math.floor(math.log10(G.GAME.blind.chips))*G.GAME.round_resets.ante^3
    end,
    calculate = function (self, blind, context)
        if context.modify_hand then
            local hand = G.GAME.hands[context.scoring_name]
            mod_chips(hand.s_chips)
            mod_mult(hand.s_mult)
        end
        if context.debuff_card then
            if context.debuff_card.area and context.debuff_card.area.config.type == "jokers" then
                return { debuff = true }
            end
            if context.debuff_card.ability and context.debuff_card.ability.hpr_played_this_round then
                return { debuff = true }
            end
        end
    end,
    in_pool = function (self)
        return false
    end,
    defeat = function (self)
        G.hand:change_size(1)
        ease_hands_played(1)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
        ease_discard(1)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + 1
        SMODS.change_play_limit(1)
        SMODS.change_discard_limit(1)
        G.jokers:change_size(1)
        G.consumeables:change_size(1)
        G.GAME.hpr_superboss_beaten = true
    end
}
]]