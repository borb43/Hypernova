local moon_drain_txt = {
    "Drains levels from played",
    "{C:attention}#1# to gain {C:attention}charge{}"
}


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
                "of other jokers by {C:attention}#1#X",
                "Increases by {C:attention}#2#X{} at the end of round"
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
                "If first hand of round {C:attention}not your most played,",
                "{C:attention}upgrade{} it and {C:red}destroy {C:attention}#1#{} played cards",
                "{s:0.8,C:dark_edition,E:1}Art and idea by Codifyd"
            }
        },
        j_hpr_gambler = {
            name = "Gambling Addict",
            text = {
                "When a {C:attention}listed {C:green}probability{} succeeds,",
                "gains {C:mult}Mult{} equal to {C:green}denominator",
                "When a {C:attention}listed {C:green}probability{} fails,",
                "gains {C:chips}Chips equal to {C:green}denominator",
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
                "Retrigger all stone cards",
                "#3# times. Upgrades all stone",
                "cards in your deck at end of round",
                "({C:chips}+#1#{} Chips, {X:mult,C:white}X#2#{} Mult)"
            }
        },
    },
    Other = {
        p_hpr_lunar_pack = {
            name = "Lunar Pack",
            text = {
                "Select {C:attention}#1# of up to",
                "{C:attention}#2# {C:hpr_moons}Moon{} cards to add",
                "to your consumables"
            }
        },
        p_hpr_lunar_pack_jumbo = {
            name = "Jumbo Lunar Pack",
            text = {
                "Select {C:attention}#1# of up to",
                "{C:attention}#2# {C:hpr_moons}Moon{} cards to add",
                "to your consumables"
            }
        },
        p_hpr_lunar_pack_mega = {
            name = "Mega Lunar Pack",
            text = {
                "Select {C:attention}#1# of up to",
                "{C:attention}#2# {C:hpr_moons}Moon{} cards to add",
                "to your consumables"
            }
        },
        p_hpr_erratic_pack = {
            name = "Erratic Pack",
            text = {
                "Select {V:1}#1#{} of up to",
                "{V:1}#2#{} random cards"
            }
        },
        p_hpr_erratic_pack_jumbo = {
            name = "#3# Erratic Pack",
            text = {
                "Select {V:1}#1#{} of up to",
                "{V:1}#2#{} random cards"
            }
        },
        p_hpr_erratic_pack_mega = {
            name = "#3# Erratic Pack",
            text = {
                "Select {V:1}#1#{} of up to",
                "{V:1}#2#{} random cards"
            }
        },
        card_extra_eff_mod = {
            text = {
                "{C:attention}X#1#{} Joker effects from this card"
            }
        }
    },
    Planet = {},
    Spectral = {},
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
        }
    },
    hpr_moons = {
        c_hpr_styx = {
            name = "Styx",
            text = {
                moon_drain_txt,
                {
                    "Instantly earn {C:money}$#2#",
                    "Increases by {C:attention}#3#{} for each charge"
                }
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
                moon_drain_txt,
                {
                    "Creates #2# random joker card#4#",
                    "Increases by #3# per charge"
                }
            }
        },
        c_hpr_europa = {
            name = "Europa",
            text = {
                moon_drain_txt,
                {
                    "Converts up to {c:attention}#2#{} selected",
                    "card#4# to {V:1}#4#",
                    "{C:attention}+#3#{} selected cards per charge",
                    "changes suit to that of the",
                    "last drained {C:attention}#1#"
                }
            }
        },
        c_hpr_phobos = {
            name = "Phobos",
            text = {
                moon_drain_txt,
                {
                    "Adds {X:mult,C:white}X#3#{} Mult to up to",
                    "{C:attention}#2#{} selected cards",
                    "Increases by {X:mult,C:white}X#4#{} per charge"
                }
            }
        },
        c_hpr_triton = {
            name = "Triton",
            text = {
                moon_drain_txt,
                {
                    "Applies a random {C:dark_edition}edition{} to",
                    "up to {C:attention}#2#{} selected card#4#",
                    "Increases by {C:attention}#3#{} per charge"
                }
            }
        },
        c_hpr_nibiru = {
            name = "Nibiru",
            text = {
                moon_drain_txt,
                {
                    "Converts up to {c:attention}#2#{} selected",
                    "card#4# to {C:attention}#4#s",
                    "{C:attention}+#3#{} selected card per charge",
                    "changes rank to that of the",
                    "last drained {C:attention}#1#"
                }
            }
        },
        c_hpr_asteroid = {
            name = "Asteroid",
            text = {
                moon_drain_txt,
                {
                    "Creates {C:attention}#2#{} random tag#4#",
                    "Increases by {C:attention}#3#{} per charge"
                }
            }
        },
        c_hpr_dysnomia = {
            name = "Dysnomia",
            text = {
                moon_drain_txt,
                {
                    "Converts up to #4# selected",
                    "card#6# to {C:attention}#2#{}s of {V:1}#3#",
                    "+#5# selected card per charge",
                    "changes rank and suit to that",
                    "of the last drained {C:attention}#1#"
                }
            }
        },
        c_hpr_titania = {
            name = "Titania",
            text = {
                moon_drain_txt,
                {
                    "Creates the specified",
                    "{C:uncommon}Uncommon{} Joker",
                    "{C:attention}Rerolls{} when charged"
                }
            }
        },
        c_hpr_hyperion = {
            name = "Hyperion",
            text = {
                moon_drain_txt,
                {
                    "Adds {C:attention}#2#{} Booster Pack#4#",
                    "to the current shop",
                    "Increases by {C:attention}#3#{} per charge"
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
        k_level_stats = "per level"
    },
    high_scores = {},
    labels = {
        hpr_moons = "Moon"
    },
    poker_hand_descriptions = {},
    poker_hands = {},
    quips = {},
    ranks = {},
    suits_plural = {},
    suits_singular = {},
    tutorial = {},
    v_dictionary = {},
    v_text = {},
}


return {descriptions = descriptions, misc = misc}
