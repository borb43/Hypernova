SMODS.Rarity {
    badge_colour = HPR.awesome_gradient,
    key = "awesome",
    pools = { Joker = true }
}

HPR.AwesomeJoker = SMODS.Joker:extend({
    rarity = "hpr_awesome",
    atlas = "hpr_placeholder",
    pos = { x = 0, y = 1 },
    soul_pos = { x = 1, y = 1 },
    cost = 10 --cheaper than legendary because mrrp mrrrrrow meow fuck your temperance value
})

HPR.AwesomeJoker{
    key = "voucherman",
    calculate = function (self, card, context)
        if context.buying_card and context.card.ability.set == "Voucher" then
            local res = pseudorandom(self.key, 1, 9)
            if res == 1 then --piratesoftware speech bubble
                change_shop_size(1)
                return{message=localize("k_hpr_plus_shop")}
            elseif res == 2 then
                G.consumeables:change_size(1)
                return{message=localize("k_hpr_plus_csize"),colour=G.C.DARK_EDITION}
            elseif res == 3 then
                G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
                ease_hands_played(1)
                return{message=localize("k_hpr_plus_hand"),colour=G.C.BLUE}
            elseif res == 4 then
                G.GAME.round_resets.discards = G.GAME.round_resets.discards + 1
                ease_discard(1)
                return{message=localize("k_hpr_plus_discard"),colour=G.C.RED}
            elseif res == 5 then
                G.jokers:change_size(1)
                return{message=localize("k_hpr_plus_jsize"),colour=G.C.DARK_EDITION}
            elseif res == 6 then
                ease_ante(-1)
                G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
                G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - 1
                return{message=localize("k_hpr_minus_ante")}
            elseif res == 7 then
                G.hand:change_size(1)
                return{message=localize("k_hpr_plus_hsize")}
            elseif res == 8 then
                SMODS.change_play_limit(1)
                return{message=localize("k_hpr_plus_psize")}
            elseif res == 9 then
                SMODS.change_discard_limit(1)
                return{message=localize("k_hpr_plus_dsize")}
            end
        end
    end,
}

HPR.AwesomeJoker {
    key = "true_balance",
    calculate = function (self, card, context)
        if context.setting_blind then
            local hands = G.GAME.current_round.hands_left
            local discards = G.GAME.current_round.discards_left
            local target = (hands+discards)/2
            ease_hands_played(-hands+target)
            ease_discard(-discards+target)
            return {
                message = localize("k_balanced"),
                sound = "gong",
                volume = 0.3,
                pitch = 0.94,
                colour = {0.8, 0.45, 0.85, 1}
            }
        end
        if context.individual and not context.end_of_round and HPR.is_any(context.cardarea, {G.play, G.hand, "unscored"}) then
            -- +chip/mult
            local base_chip = context.other_card:get_chip_bonus()
            local base_mult = context.other_card:get_chip_mult()
            local target = (base_chip+base_mult)/2
            context.other_card.ability.perma_bonus = -base_chip + target
            context.other_card.ability.perma_bonus = -base_mult + target
            -- held +chip/mult
            local base_h_chip = context.other_card:get_chip_h_bonus()
            local base_h_mult = context.other_card:get_chip_h_mult()
            local h_target = (base_h_chip+base_h_mult)/2
            context.other_card.ability.perma_h_chips = -base_h_chip + h_target
            context.other_card.ability.perma_h_mult = -base_h_mult + target
            return {
                message = localize("k_balanced"),
                sound = "gong",
                volume = 0.3,
                pitch = 0.94,
                colour = {0.8, 0.45, 0.85, 1}
            }
        end
        if context.joker_main then
            return { balance = true }
        end
    end
}