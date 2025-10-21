SMODS.Joker {
    key = "eris",
    atlas = "placeholder",
    pos = { x = 3, y = 0 },
    soul_pos = { x = 4, y = 0 },
    rarity = 4,
    cost = 20,
    blueprint_compat = true,
    demicoloncompat = true,
    calculate = function (self, card, context)
        if context.setting_blind then
            G.E_MANAGER:add_event(Event({
                func = function ()
                    SMODS.add_card({
                        set = "hpr_moons",
                        edition = 'e_negative'
                    })
                end
            }))
        end
    end,
    pronouns = "any_all",
    hpr_credits = {
        code = "Eris",
        idea = "Eris"
    }
}