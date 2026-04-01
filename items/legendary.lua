SMODS.Joker {
    key = "eris",
    atlas = "joker",
    pos = { x = 0, y = 1 },
    soul_pos = { x = 1, y = 1 },
    rarity = 4,
    cost = 20,
    blueprint_compat = false,
    forcetrigger_compat = true,
    config = { extra = { red = 4, blue = 30, yellow = 5 }},
    loc_vars = function (self, info_queue, card)
        local c = G.GAME.hpr_eris_card or { value = "Jack", suit = "Spades" }
        local key = self.key
        if c.effect then
            if c.effect == "magenta" then
                info_queue[#info_queue+1] = { key = "e_negative_consumable", config = { extra = 1 }, set = "Edition" }
            end
            key = key.."_"..c.effect
        end
        return {
            vars = {
                localize(c.value, "ranks"),
                localize(c.suit, "suits_plural"),
                card.ability.extra.red,
                card.ability.extra.blue,
                card.ability.extra.yellow,
                colours = { G.C.SUITS[c.suit] }
            },
            key = key,
        }
    end,
    calculate = function (self, card, context)
        if context.individual and (context.cardarea == G.play or context.cardarea == G.hand) and context.other_card:get_id() == G.GAME.hpr_eris_card.id and context.other_card:is_suit(G.GAME.hpr_eris_card.suit) then
            if not context.end_of_round then
                if G.GAME.hpr_eris_card.effect == "red" then
                    context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra.red
                    return { message = localize("k_upgrade_ex"), colour = G.C.RED }
                elseif G.GAME.hpr_eris_card.effect == "blue" then
                    context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + card.ability.extra.blue
                elseif G.GAME.hpr_eris_card.effect == "yellow" and context.cardarea == G.play then
                    G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.yellow
                    HPR.reset_dollar_buffer()
                    return { dollars = card.ability.extra.yellow }
                end
            elseif context.cardarea == G.hand and G.GAME.hpr_eris_card.effect == "cyan" and G.GAME.last_hand_played ~= "NULL" then
                return {
                    level_up = true,
                    level_up_hand = G.GAME.last_hand_played
                }
            end
        end
        if context.discard and G.GAME.hpr_eris_card.effect == "magenta" and context.other_card:get_id() == G.GAME.hpr_eris_card.id and context.other_card:is_suit(G.GAME.hpr_eris_card.suit) then
            G.E_MANAGER:add_event(Event{
                func = function ()
                    SMODS.add_card{
                        set = "Tarot",
                        edition = "e_negative",
                        key_append = "hpr_eris_magenta"
                    }
                    return true
                end
            })
            return { message = localize("k_plus_tarot"), colour = G.C.SECONDARY_SET.Tarot }
        end
        if context.mod_probability and G.GAME.hpr_eris_card.effect == "green" then
            local p = false
            if context.trigger_obj and Object.is(context.trigger_obj, Card) and context.trigger_obj.playing_card and context.trigger_obj:get_id() == G.GAME.hpr_eris_card.id and context.trigger_obj:is_suit(G.GAME.hpr_eris_card.suit) then
                p = true
            end
            if not p and context.from_roll then
                local cont = SMODS.get_previous_context() or {}
                if cont.other_card and cont.other_card:get_id() == G.GAME.hpr_eris_card.id and cont.other_card:is_suit(G.GAME.hpr_eris_card.suit) then
                    p = true
                end
            end
            if p then
                return {
                    numerator = context.denominator
                }
            end
        end
    end,
    attributes = { "suit", "rank", "mod_chance", "discard", "tarot", "mult", "chips", "modify_card", "economy" }, --le mayo
    pronouns = "any_all",
    hpr_badge_info = {
        { key = "credits_code", vars = {"Eris"} },
        { key = "credits_art", vars = {"Eris" }},
        { key = "credits_idea", vars = {"Eris" }},
    },
}