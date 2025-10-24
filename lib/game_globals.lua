local function reset_hpr_cavepaint()
    G.GAME.current_round.hpr_cavepaint_card = {}
    local valid_cards = {}
    for _, card in ipairs(G.playing_cards) do
        if not SMODS.has_no_rank(card) and not SMODS.has_no_suit(card) then
            valid_cards[#valid_cards+1] = card
        end
    end
    local cavepaint_card = pseudorandom_element(valid_cards, "hpr_cavepaint"..G.GAME.round_resets.ante)
    if cavepaint_card then
        G.GAME.current_round.hpr_cavepaint_card.rank = cavepaint_card.base.value
        G.GAME.current_round.hpr_cavepaint_card.suit = cavepaint_card.base.suit
        G.GAME.current_round.hpr_cavepaint_card.id = cavepaint_card.base.id
    end
end


HPR.reset_game_globals = function (run_start)
    if run_start then
        G.GAME.hpr_moons_mult = 1
    end
    reset_hpr_cavepaint()
end