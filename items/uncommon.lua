SMODS.Joker { --fusion reactor, balances before scoring
    key = "fusion",
    atlas = "placeholder",
    pos = { x = 1, y = 0 },
    rarity = 2,
    cost = 7,
    blueprint_compat = true,
    demicoloncompat = true,
    calculate = function (self, card, context)
        if context.initial_scoring_step or context.forcetrigger then
            return {
                balance = true
            }
        end
    end
}