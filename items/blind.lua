SMODS.Blind {
    key = "final_horse",
    atlas = "blind_chip",
    pos = { x = 0, y = 1 },
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