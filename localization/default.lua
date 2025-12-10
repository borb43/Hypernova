
local descriptions = {
    Back = {
        b_hpr_sealed = {
            name = "Sealed Deck",
            text = {
                "All {C:attention}Aces{} in starting deck",
                "start with different {C:attention}seals{}"
            }
        },
        b_hpr_pink = {
            name = "Pink Deck",
            text = {
                "{C:attention}+#1#{} Booster Pack in each shop"
            }
        }
    },
    Blind = {},
    Edition = {},
    Enhanced = {},
    Joker = {
        j_hpr_growth = {
            name = "Growth",
            text = {
                "Multiplies most effects",
                "of other jokers by {X:dark_edition,C:white}#1#X",
                "Increases by {X:dark_edition,C:white}#2#X{} at the end of round"
            }
        },
        j_hpr_fusion = {
            name = "Fusion Reactor",
            text = {
                "Balances {C:chips}Chips{} and {C:mult}Mult{}",
                "before scoring"
            }
        },
        j_hpr_scales = {
            name = "Tipped Scales",
            text = {
                "Increases all {C:attention}listed {C:green}numerators",
                "and {C:green}denominators{} by {C:green}#1#"
            }
        },
        j_hpr_solar = {
            name = "Solar Flare",
            text = {
                "If first hand of round {C:attention}not{} your most played,",
                "{C:attention}upgrade{} it and {C:red}destroy {C:attention}#1#{} played cards",
            }
        },
        j_hpr_gambler = {
            name = "Gambling Addict",
            text = {
                "When a {C:attention}listed {C:green}probability{} succeeds,",
                "gains {C:mult}Mult{} equal to {C:green}denominator",
                "When a {C:attention}listed {C:green}probability{} fails,",
                "gains {C:chips}Chips{} equal to {C:green}denominator",
                "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips, {C:mult}+#2#{C:inactive} Mult)"
            }
        },
        j_hpr_fortune = {
            name = "Fortune Cookie",
            text = {
                "The next {C:attention}#1# listed",
                "{C:green,E:1}probabilities{} are guaranteed",
                "Creates a {C:dark_edition}Negative {C:Tarot}Tarot{} card",
                "when destroyed"
            }
        },
        j_hpr_eris = {
            name = "Eris",
            text = {
                "Creates a {C:dark_edition}Negative {C:hpr_moons}Moon{} card",
                "if played hand is exactly {C:attention}1{}",
                "rankless or suitless card"
            }
        },
        j_hpr_bungus = {
            name = "Bustling Fungus",
            text = {
                "Increases the {C:attention}rank{} of a",
                "random card in hand",
                "after every hand"
            }
        },
        j_hpr_cavepaint = {
            name = "Cave Painting",
            text = {
                "{C:attention}Stone Cards{} mimic the rank",
                "and suit of a random card",
                "from your deck every round",
                "Currently {C:attention}#1#{} of {V:1}#2#{}"
            }
        },
        j_hpr_cavepaint_none = {
            name = "Cave Painting",
            text = {
                "{C:attention}Stone Cards{} mimic the rank",
                "and suit of a random card",
                "from your deck every round",
                "Currently None"
            }
        },
        j_hpr_observatorium = {
            name = "S001 OBSERVATORIUM",
            text = {
                "When a hand is {C:attention}leveled up,",
                "level up this joker and",
                "all cards in your deck",
                "by the same amount",
                "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips, {C:mult}+#2#{C:inactive} Mult)"
            }
        },
        j_hpr_error = {
            name = "S??? ?Err??or",
            text = {
                ""
            }
        }
    },
    Other = {
        p_hpr_lunar_pack = {
            name = "Lunar Pack",
            text = {
                "Select {C:attention}#1#{} of up to",
                "{C:attention}#2# {C:hpr_moons}Moon{} cards to",
                "be used immediately"
            }
        },
        p_hpr_lunar_pack_jumbo = {
            name = "Jumbo Lunar Pack",
            text = {
                "Select {C:attention}#1#{} of up to",
                "{C:attention}#2# {C:hpr_moons}Moon{} cards to",
                "be used immediately"
            }
        },
        p_hpr_lunar_pack_mega = {
            name = "Mega Lunar Pack",
            text = {
                "Select {C:attention}#1#{} of up to",
                "{C:attention}#2# {C:hpr_moons}Moon{} cards to",
                "be used immediately"
            }
        },
        p_hpr_erratic_pack = {
            name = "Erratic Pack",
            text = {
                "Select {C:hpr_erratic_col}#1#{} of up to",
                "{C:hpr_erratic_col}#2#{} random cards"
            }
        },
        p_hpr_erratic_pack_jumbo = {
            name = "#3# Erratic Pack",
            text = {
                "Select {C:hpr_erratic_col}#1#{} of up to",
                "{C:hpr_erratic_col}#2#{} random cards"
            }
        },
        p_hpr_erratic_pack_mega = {
            name = "#3# Erratic Pack",
            text = {
                "Select {C:hpr_erratic_col}#1#{} of up to",
                "{C:hpr_erratic_col}#2#{} random cards"
            }
        },
        card_extra_eff_mod = {
            text = {
                "{X:dark_edition,C:white}X#1#{} Joker effects from this card"
            }
        },
        undiscovered_hpr_moons = {
            name = "Not Discovered",
            text = {
                "Purchase or use",
                "this card in an",
                "unseeded run to",
                "learn what it does"
            }
        },
        hpr_undiscovered_stellar = {
            name = "Not Discovered",
            text = {
                "Obtain this {C:hpr_stellar}Ascension{}",
                "in an unseeded run",
                "to learn what it does"
            }
        }
    },
    Planet = {},
    Spectral = {
        c_hpr_pulsar = {
            name = "Pulsar",
            text = {
                "Applies {C:dark_edition}Negative{} edition",
                "to {C:attention}#1#{} selected card"
            }
        },
        c_hpr_ascender = {
            name = "name tbd ascension card",
            text = {
                "{C:hpr_stellar}Ascends{} one eligible {C:attention}Joker{} to",
                "its {C:hpr_stellar}Stellar{} counterpart"
            }
        }
    },
    Stake = {},
    Sleeve = {
        sleeve_hpr_sealed = {
            name = "Sealed Sleeve",
            text = {
                "All {C:attention}Aces{} in starting deck",
                "start with different {C:attention}seals{}"
            }
        },
        sleeve_hpr_sealed_alt = {
            name = "Sealed Sleeve",
            text = {
                "Start with an additional",
                "4 {C:attention}Aces{} in your starting deck"
            }
        },
        sleeve_hpr_pink = {
            name = "Pink Sleeve",
            text = {
                "{C:attention}+#1#{} Booster Pack in each shop"
            }
        },
        sleeve_hpr_pink_alt = {
            name = "Pink Sleeve",
            text = {
                "{C:attention}+#1#{} Voucher in each shop"
            }
        }
    },
    Tag = {},
    Tarot = {},
    Voucher = {
        v_hpr_stacking = {
            name = "Stacking",
            text = {
                "Playing cards may appear with random",
                "permanent {C:chips}Chips{} or {C:mult}Mult{} bonuses"
            }
        },
        v_hpr_massprod = {
            name = "Mass Production",
            text = {
                "Playing cards may appear with random",
                "permanent {X:chips,C:white}XChips{} or {X:mult,C:white}XMult{} bonuses"
            }
        },
        v_hpr_shrine = {
            name = "Shrine",
            text = {
                "{C:hpr_moons}Lunar Packs{} appear {C:attention}X#1#{} as often"
            }
        },
        v_hpr_blessing = {
            name = "Lunar Blessing",
            text = {
                "{C:hpr_moons}Moon{} cards may appear in the shop"
            }
        }
    },
    hpr_moons = {
        c_hpr_styx = {
            name = "Styx",
            text = {
                "Permanently adds {C:money}$#1#{} at the end of",
                "round to {C:attention}#2#{} selected card"
            }
        },
        c_hpr_deimos = {
            name = "Deimos",
            text = {
                "Permanently adds {C:mult}+#1#{} Mult to",
                "up to {C:attention}#2#{} selected cards",
            }
        },
        c_hpr_io = {
            name = "Io",
            text = {
                "Permanently adds {C:chips}+#1#{} Chips to",
                "up to {C:attention}#2#{} selected cards"
            }
        },
        c_hpr_moon = {
            name = "Luna",
            text = {
                "Permanently adds {C:chips}+#1#{} held in hand",
                "Chips to up to {C:attention}#2#{} selected cards"
            }
        },
        c_hpr_europa = {
            name = "Europa",
            text = {
                "Permanently adds {X:mult,C:white}X#1#{} Mult",
                "to up to {C:attention}#2#{} selected cards"
            }
        },
        c_hpr_phobos = {
            name = "Phobos",
            text = {
                "Permanently adds {C:mult}+#1#{} held in hand",
                "Mult to up to {C:attention}#2#{} selected cards"
            }
        },
        c_hpr_triton = {
            name = "Triton",
            text = {
                "Permanently adds {X:chips,C:white}X#1#{} held in hand",
                "Chips to up to {C:attention}#2#{} selected cards"
            }
        },
        c_hpr_nibiru = {
            name = "Nibiru",
            text = {
                "Permanently adds {C:money}$#1#{} to",
                "{C:attention}#2#{} selected card"
            }
        },
        c_hpr_asteroid = {
            name = "Asteroid",
            text = {
                "Permanently adds {C:attention}#1#{} retrigger",
                "to {C:attention}#2#{} selected card"
            }
        },
        c_hpr_dysnomia = {
            name = "Dysnomia",
            text = {
                "Permanently adds {X:dark_edition,C:white}X#1#{} Joker",
                "effects to #2# selected card"
            }
        },
        c_hpr_titania = {
            name = "Titania",
            text = {
                "Permanently adds {X:mult,C:white}X#1#{} held in hand",
                "Mult to up to {C:attention}#2#{} selected cards"
            }
        },
        c_hpr_hyperion = {
            name = "Hyperion",
            text = {
                "Permanently adds {X:chips,C:white}X#1#{} Chips",
                "to up to {C:attention}#2#{} selected cards"
            }
        },
        hpr_diy = {
            c_hpr_garbage = {
                name = "Garbage",
                text = {
                    "{C:red}+#1#{} discard"
                }
            }
        }
    }
}
local misc = {
    achievement_descriptions = {},
    achievement_names = {},
    blind_states = {},
    challenge_names = {},
    collabs = {},
    dictionary = {
        b_hpr_moons_cards = "Moon Cards",
        k_hpr_moons = "Moon",
        k_lunar_pack = "Lunar Pack",
        k_hpr_moon_q = "Moon?",
        --#region jumbo erratics
        k_big = "Big",
        k_sizable = "Sizable",
        k_large = "Large",
        k_jumbo = "Jumbo",
        k_wumbo = "Wumbo",
        k_very = "Very",
        --#endregion
        --#region mega erratics
        k_mega = "Mega",
        k_giga = "Giga",
        k_giant = "Giant",
        k_massive = "Massive",
        k_extremely = "Extremely",
        k_huge = "Huge",
        --#endregion
        k_hpr_enable_janky_manips = "Enables janky values for joker effect maniulation",
        k_level_stats = "per level",
        hpr_plus_moon = "+1 Moon",
        hpr_plus_q = "+1 ???",
        k_erratic_pack = "Erratic Pack",
        k_hpr_diy = "diy",
        b_hpr_diy_cards = "diy cards",
        k_hpr_diy_pack = "Build your deck!",
        k_hpr_stellar = "Stellar"
    },
    high_scores = {},
    labels = {
        hpr_moons = "Moon",
        hpr_diy = "DIY",
        hpr_stellar = "Stellar"
    },
    poker_hand_descriptions = {},
    poker_hands = {},
    quips = {},
    ranks = {},
    suits_plural = {},
    suits_singular = {},
    tutorial = {},
    v_dictionary = {
        hpr_credits_idea = { "Idea: #1#" },
        hpr_credits_art = { "Art: #1#" },
        hpr_credits_code = { "Code: #1#" }
    },
    v_text = {},
}

if next(SMODS.find_mod("Cryptid")) then
    descriptions.Joker.j_hpr_gambler.text[#descriptions.Joker.j_hpr_gambler.text+1] = "{C:inactive}(Currently X#3# Scaling){}"
end

return {descriptions = descriptions, misc = misc}
