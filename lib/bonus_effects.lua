HPR.buffoon_effect_pool = {
    {key = "slib_chips", min = 40, max = 150,},
    {key = "slib_xchips", min = 15, max = 35, factor = 0.1, },
    {key = "slib_echips", min = 105, max = 125, factor = 0.01, },
    {key = "slib_mult", min = 8, max = 30, },
    {key = "slib_xmult", min = 15, max = 35, factor = 0.1, },
    {key = "slib_emult", min = 110, max = 130, factor = 0.01, },
    {key = "slib_score", get_config = function (seed)
        local ante = G.GAME.round_resets.ante or 1
        return { extra = pseudorandom(seed, 50, 150) * 2^ante }
    end},
    {key = "slib_xscore", min = 12, max = 25, factor = 0.1,},
    {key = "slib_balance"},
    {key = "slib_partial_swap", min = 10, max = 100, factor = 0.01, },
    {key = "slib_hands", min = 1, max = 3,},
    {key = "slib_discards", min = 1, max = 3,},
    {key = "slib_h_size", min = 1, max = 3,},
    {key = "slib_consumable_slot", min = 1, max = 3,},
    {key = "slib_cashout", min = 3, max = 10,},
    {key = "slib_type_chips", min = 100, max = 250,},
    {key = "slib_type_mult", min = 12, max = 50,},
    {key = "slib_type_xmult", min = 20, max = 50, factor = 0.1, },
    {key = "slib_s_mult", min = 6, max = 20,},
    {key = "hpr_odds_levelup", min = 3, max = 6,},
    {key = "hpr_consumable_on_select"},
}

function HPR.poll_buffoon_effect(seed)
    seed = seed or "hpr_buffoon"
    local eff_table = pseudorandom_element(HPR.buffoon_effect_pool, seed.."_type")
    local config = {}
    if eff_table.get_config then
        config = eff_table.get_config(seed)
    elseif eff_table.min and eff_table.max then
        config.extra = pseudorandom(seed, eff_table.min, eff_table.max) * (eff_table.factor or 1)
    end
    return eff_table.key, config
end

Spectrallib.BonusEffect{
    key = "odds_levelup",
    loc_vars = function (self, info_queue, card, eff_table)
        local n, d = SMODS.get_probability_vars(self, 1, eff_table.config.extra, "hpr_levelup_bonus")
        return { vars = { n, d }}
    end,
    calculate = function (self, card, eff_table, context)
        if context.before and SMODS.pseudorandom_probability(card, "hpr_levelup_bonus", 1, eff_table.config.extra) then
            return {
                level_up = true,
                message = localize("k_upgrade_ex")
            }
        end
    end,
    attributes = { "chance", "hand_level", }
}

Spectrallib.BonusEffect{
    key = "consumable_on_select",
    calculate = function (self, card, eff_table, context)
        if context.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = (function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card {
                                set = 'Consumeables',
                                key_append = 'hpr_consumable_bonuseffect'
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                    SMODS.calculate_effect({ message = localize('slib_plus_consumable') },
                        context.blueprint_card or card)
                    return true
                end)
            }))
            return nil, true
        end
    end
}