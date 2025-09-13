local moon_drain_txt = {
    "Drains levels from played",
    "{C:attention}#1# to gain {C:attention}charge{}"
}

return {
    descriptions = {
        Back={
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
        Blind={},
        Edition={},
        Enhanced={},
        Joker={ 
            j_hpr_growth = {
                name = "Growth",
                text = {
                    "Increase potency of most",
                    "other joker effects by {C:attention}#1#X{}",
                    "Increases by {C:attention}#2#X{} at the end of round",
                    "{C:inactive}(Note: might be a bit weird at times)"
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
                    "If played hand is {C:attention}not your most played,",
                    "{C:attention}upgrade{} it and {C:red}destroy {C:attention}#1#{} played cards",
                    "{s:0.8,C:dark_edition,E:1}Art and idea by Codifyd"
                }
            }
        },
        Other={
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
            }
        },
        Planet={},
        Spectral={},
        Stake={},
        Sleeve={
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
        Tag={},
        Tarot={},
        Voucher={
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
                    moon_drain_txt,
                    {
                        "Permanently adds {C:mult}+#2#{} Mult to",
                        "up to {C:attention}#4#{} selected cards",
                        "Increases by {c:attention}#3#{} for each charge"
                    }
                }
            },
            c_hpr_io = {
                name = "Io",
                text = {
                    moon_drain_txt,
                    {
                        "Applies random enhancements",
                        "to up to {C:attention}#2#{} selected cards",
                        "Increases by {C:attention}#3#{} per charge"
                    }
                }
            },
            c_hpr_moon = {
                name = "Luna",
                text = {
                    moon_drain_txt,
                    {
                        "Creates #2# random joker cards",
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
                        "cards to {V:1}#4#",
                        "{C:attention}+#3#{} selected card per charge",
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
                        "up to {C:attention}#2#{} selected cards",
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
                        "cards to {C:attention}#4#s",
                        "{C:attention}+#3#{} selected card per charge",
                        "changes rank to that of the",
                        "last drained {C:attention}#1#"
                    }
                }
            }
        }
    },
    misc = {
        achievement_descriptions={},
        achievement_names={},
        blind_states={},
        challenge_names={},
        collabs={},
        dictionary={
            b_hpr_moons_cards = "Moon Cards",
            k_hpr_moons = "Moon",
            k_lunar_pack = "Lunar Pack"
        },
        high_scores={},
        labels={
            hpr_moons = "Moon"
        },
        poker_hand_descriptions={},
        poker_hands={},
        quips={},
        ranks={},
        suits_plural={},
        suits_singular={},
        tutorial={},
        v_dictionary={},
        v_text={},
    },
}