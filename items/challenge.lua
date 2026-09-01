
SMODS.Challenge {
    key = "horse",
    rules = {
        custom = {
            { id = "hpr_the_horse_is_here" }
        }
    },
    jokers = {
        { id = "j_hpr_genius_horse", eternal = true, }
    },
    restrictions = {
        banned_cards = {
            { id = "j_luchador" }, { id = "j_chicot", }, { id = "j_hpr_hunter" },
            { id = "v_directors_cut" }, { id = "v_retcon", },
        },
        banned_tags = {
            { id = "tag_boss", }
        },
    },
    button_colour = HEX("DF73FF"),
}