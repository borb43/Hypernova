
SMODS.Rarity {
    badge_colour = HPR.stellar_gradient,
    key = "stellar"
}

HPR.StellarJoker = SMODS.Joker:extend({
    atlas = "hpr_placeholder",
    pos = { x = 0, y = 1 },
    soul_pos = { x = 1, y = 1 },
    rarity = "hpr_stellar",
    cost = 30
})

SMODS.Consumable {
    key = "ascender",
    atlas = "placeholder",
    pos = { x = 2, y = 2 },
    --soul_pos,
    set = "Spectral",
    cost = 4,
    hidden = true,
    can_use = function (self, card)
        return G.jokers and #G.jokers.highlighted == 1 and HPR.get_ascension(G.jokers.highlighted[1])
    end,
    use = function (self, card, area, copier)
        G.E_MANAGER:add_event(Event{
            trigger = 'after',
            delay = 0.4,
            func = function ()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        })
        G.E_MANAGER:add_event(Event{
            trigger = 'after',
            delay = 0.15,
            func = function ()
                G.jokers.highlighted[1]:flip()
                play_sound('card1')
                return true
            end
        })
        delay(0.2)
        G.E_MANAGER:add_event(Event{
            trigger = 'after',
            delay = 0.15,
            func = function ()
                G.jokers.highlighted[1]:set_ability(HPR.get_ascension(G.jokers.highlighted[1]))
                G.jokers.highlighted[1]:flip()
                return true
            end
        })
        delay(0.5)
    end
}

HPR.vanilla_ascensions = {
    j_supernova = "j_hpr_observatorium",
    j_constellation = "j_hpr_observatorium",
    j_space = "j_hpr_observatorium",
    j_misprint = "j_hpr_missing"
}

HPR.error_ops = { '+', '-', '=', '..', 'X', '/', '^', '%', '==', '~=', '>', '<', '>=', '<=', 'or', 'and', 'not', '#', 'ln', 'log', 'sin', 'cos', 'tan' }
HPR.error_numbers = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '21', '41', '61', '67', '69', '84', '404', '420', 'nan', 'inf', 'i', 'e', 'pi', 'huge', '666', '999', '-1', '23', '80085' }
HPR.error_other = {
    { string = "Chips", colour = G.C.CHIPS },
    { string = "Mult", colour = G.C.MULT },
    { string = "$", colour = G.C.MONEY },
    { string = "Hand size", colour = G.C.FILTER },
    { string = "Hands", colour = G.C.BLUE },
    { string = "Discards", colour = G.C.RED },
    { string = "Probabilities", colour = G.C.GREEN },
    { string = "Pinned", colour = G.C.ORANGE },
    { string = "Vouchers", colour = G.C.SECONDARY_SET.Voucher },
    { string = "Boosters", colour = G.C.SECONDARY_SET.Booster },
    { string = "Slots", colour = G.C.DARK_EDITION },
    { string = "Eternal", colour = G.C.ETERNAL },
    { string = "Perishable", colour = G.C.PERISHABLE },
    { string = "Rental", colour = G.C.RENTAL },
    { string = "Hearts", colour = G.C.SUITS.Hearts },
    { string = "Diamonds", colour = G.C.SUITS.Diamonds },
    { string = "Spades", colour = G.C.SUITS.Spades },
    { string = "Clubs", colour = G.C.SUITS.Clubs },
    { string = "Tarots", colour = G.C.SECONDARY_SET.Tarot },
    { string = "Planets", colour = G.C.SECONDARY_SET.Planet },
    { string = "Spectrals", colour = G.C.SECONDARY_SET.Spectral },
    { string = "Common", colour = G.C.RARITY[1] },
    { string = "Uncommon", colour = G.C.RARITY[2] },
    { string = "Rare", colour = G.C.RARITY[3] },
    { string = "Legendary", colour = G.C.RARITY[4] },
    { string = "Blind Size", colour = G.C.FILTER },
    { string = "Rerolls", colour = G.C.GREEN },
    { string = "Levels", colour = G.C.SECONDARY_SET.Planet },
    { string = "Enhanced", colour = G.C.SECONDARY_SET.Enhanced },
    { string = "Tags", colour = G.C.FILTER },
    { string = "Faces", colour = G.C.FILTER },
    { string = "Score", colour = HEX('7b559c') }
}

HPR.StellarJoker {
    key = "missing",
    blueprint_compat = true,
    demicoloncompat = true,
    loc_vars = function (self, info_queue, card)
        local active = false --change this later
        return {
            main_start = {
                {
                    n = G.UIT.O,
                    config = {
                        object = DynaText({
                            string = HPR.error_ops,
                            colours = { HPR.gay },
                            pop_in_rate = 9999999,
                            silent = true,
                            random_element = true,
                            pop_delay = 0.3,
                            scale = 0.32,
                            min_cycle_time = 0
                        })
                    },
                },
                {
                    n = G.UIT.O,
                    config = {
                        object = DynaText({
                            string = HPR.error_numbers,
                            colours = { HPR.gay },
                            pop_in_rate = 9999999,
                            silent = true,
                            random_element = true,
                            pop_delay = 0.351,
                            scale = 0.32,
                            min_cycle_time = 0
                        })
                    },
                },
                {
                    n = G.UIT.O,
                    config = {
                        object = DynaText({
                            string = HPR.error_other,
                            colours = { G.C.UI.TEXT_DARK },
                            pop_in_rate = 9999999,
                            silent = true,
                            random_element = true,
                            pop_delay = 0.299,
                            scale = 0.32,
                            min_cycle_time = 0
                        })
                    },
                },
            },
            main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = active and G.C.PURPLE or G.C.FILTER, r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. localize(active and 'k_incompatible' or 'ph_no_boss_active') .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.9 } },
                            }
                        }
                    }
                }
            }
        }
    end
}

HPR.StellarJoker {
    key = "observatorium",
    config = { extra = { chips = 0, mult = 0 }},
    blueprint_compat = true,
    demicoloncompat = true,
    perishable_compat = false,
    calculate = function (self, card, context)
        if context.hpr_level_up_hand then
            card.ability.extra.chips = card.ability.extra.chips + context.chips
            card.ability.extra.mult = card.ability.extra.mult + context.mult
            for _, c in pairs(G.playing_cards) do
                c.ability.perma_bonus = c.ability.perma_bonus + context.chips
                c.ability.perma_mult = c.ability.perma_mult + context.mult
            end
            if not context.instant then
                return {
                    message = localize("k_upgrade_ex")
                }
            end
        end
        if context.joker_main or context.forcetrigger then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.chips
            }
        end
    end,
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.asc }}
    end,
}