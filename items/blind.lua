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
        if not blind.disabled and context.debuff_card and context.debuff_card.area == G.jokers then
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