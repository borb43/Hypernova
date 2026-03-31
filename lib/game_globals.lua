local function reset_hpr_eris()
    G.GAME.hpr_eris_card = { value = "Jack", suit = "Spades" }
    local faces = {}
    for _, k in pairs(SMODS.Ranks) do
        if k.face then faces[#faces+1] = k end
    end
    local new_suit = pseudorandom_element(SMODS.Suits, "hpr_eris_suit")
    local new_rank = pseudorandom_element(faces, "hpr_eris_rank")
    local new_effect = pseudorandom_element({"red", "green", "blue", "cyan", "yellow", "magenta"}) --sprite colour doesnt actually change yet because still old sprite
    if new_rank then
        G.GAME.hpr_eris_card.value = new_rank.key
        G.GAME.hpr_eris_card.id = new_rank.id
    end
    if new_suit then
        G.GAME.hpr_eris_card.suit = new_suit.key
    end
    if new_effect then
        G.GAME.hpr_eris_card.effect = new_effect
    end
end

local function reset_hpr_quiz()
    local valid_cards = {}
    for _, card in ipairs(G.playing_cards) do
        if not SMODS.has_no_suit(card) then
            valid_cards[#valid_cards+1] = card
        end
    end
    local c = pseudorandom_element(valid_cards, "hpr_quiz"..G.GAME.round_resets.ante)
    G.GAME.current_round.hpr_quiz_suit = Spectrallib.safe_get(c, "base", "suit") or "Spades"
end

local function reset_relic_card()
    G.GAME.current_round.hpr_relic_suit = (pseudorandom_element(SMODS.Suits, "hpr_relic_card"..G.GAME.round_resets.ante) or {}).key or "Spades"
end

HPR.reset_game_globals = function (run_start)
    if run_start then
        G.GAME.hpr_awesome_pack_mod = 1
    end
    reset_hpr_eris()
    reset_hpr_quiz()
    reset_relic_card()
end

HPR.stellar_gradient = SMODS.Gradient {
    key = "stellar",
    colours = {
        HEX("010052"),
        HEX("520052")
    }
}

HPR.gay = SMODS.Gradient {
    key = "gay",
    colours = {
        G.C.MULT,
        G.C.GREEN,
        G.C.CHIPS
    }
}

HPR.alt_gay = SMODS.Gradient {
    key = "alt_gay",
    colours = {
        G.P_BLINDS.bl_final_bell.boss_colour,
        G.C.MONEY,
        G.C.PURPLE
    }
}

HPR.super_gay = SMODS.Gradient {
    key = "super_gay",
    colours = {
        G.C.MULT,
        G.C.MONEY,
        G.C.GREEN,
        G.P_BLINDS.bl_final_bell.boss_colour,
        G.C.CHIPS,
        G.C.PURPLE
    }
}

HPR.awesome_gradient = SMODS.Gradient{
    key = "awesome",
    colours = {
        G.C.RARITY[1],
        G.C.RARITY[2],
        G.C.GOLD,
        G.C.RARITY[3],
        G.C.RARITY[4],
    }
}

HPR.dual_gradient = SMODS.Gradient{
    key = "dual_gradient",
    colours = {
        G.C.RED,
        G.C.BLUE
    }
}