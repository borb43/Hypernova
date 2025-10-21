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
        if context.other_consumeable and context.other_consumeable.ability.set == "hpr_moons" then
            local ret = HPR.get_moon_scoring(context.other_consumeable)
            ret.message_card = context.other_consumeable
            return ret
        end
        if context.post_trigger and context.other_card.ability.set == "Joker" and not context.blueprint then
            local other_ret = context.other_ret.jokers or {}
            for _, c in ipairs(G.consumeables.cards) do
                if c.ability.set == "hpr_moons" and c.ability.moon_eff_mod then
                    HPR.manipulate_ret(other_ret, c.ability.moon_eff_mod+1)
                end
            end
        end
    end,
    pronouns = "any_all",
    hpr_credits = {
        code = "Eris"
    }
}