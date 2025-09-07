SMODS.Joker { --fusion reactor, balances before scoring
    key = "fusion",
    atlas = "placeholder",
    pos = { x = 1, y = 0 },
    rarity = 2,
    cost = 7,
    calculate = function (self, card, context)
        if context.initial_scoring_step then
            return {
                balance = true
            }
        end
    end
}