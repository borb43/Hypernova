SMODS.Joker {
    key = "eris",
    atlas = "joker",
    pos = { x = 0, y = 1 },
    soul_pos = { x = 1, y = 1 },
    rarity = 4,
    cost = 20,
    blueprint_compat = true,
    forcetrigger_compat = true,
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
    end,
    calculate = function (self, card, context)
        if context.setting_blind and context.blind.boss or context.forcetrigger then
            local planets = {}
            for _, c in ipairs(G.consumeables.cards) do
                if c.ability.set == "Planet" and not SMODS.is_eternal(c, card) then planets[#planets+1] = c end
            end
            if next(planets) then
                SMODS.destroy_cards(pseudorandom_element(planets))
                G.E_MANAGER:add_event(Event{
                    func = function ()
                        SMODS.add_card{
                            edition = "e_negative",
                            key_append = "hpr_eris",
                            set = "hpr_moons"
                        }
                        return true
                    end
                })
                return nil, true
            end
        end
        if context.before then
            local moon
            for _, c in ipairs(G.consumeables.cards) do
                if c.ability.set == "hpr_moons" and not SMODS.is_eternal(c, card) then
                    moon = c
                    break
                end
            end
            if moon then
                for _, c in ipairs(context.full_hand) do
                    if moon.config.center.apply_bonus then 
                        moon.config.center:apply_bonus(moon, c)
                        SMODS.calculate_effect({ message = localize("k_upgrade_ex"), message_card = c })
                    end
                end
                SMODS.destroy_cards(moon)
            end
        end
    end,
    pronouns = "any_all",
    hpr_badge_info = {
        { key = "credits_code", vars = {"Eris"} },
        { key = "credits_art", vars = {"Eris" }},
        { key = "credits_idea", vars = {"Eris" }},
    }
}