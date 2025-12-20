
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
        },
        b_hpr_cosmic = {
            name = "Cosmic Deck",
            text = {
                "Start the run with",
                "an {T:c_hpr_ascender,C:spectral}#1#{} card"
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
                "Multiplies all {C:chips}Chips{} and",
                "{C:mult}Mult{} effects by {X:dark_edition,C:white}#1#X",
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
        j_hpr_missing = {
            name = "S{C:hpr_super_gay}??? ?{}ERR{C:hpr_super_gay}??{}OR",
            text = {
                ""
            }
        },
        j_hpr_master = {
            name = "S002 MASTER",
            text = {
                "All {C:attention}consumables{} and {C:attention}Booster",
                "{C:attention}Packs{} in the shop are {C:attention}free",
                "Creates a {C:dark_edition}Negative {C:attention}Consumable",
                "when blind is selected"
            }
        },
        j_hpr_potassium = {
            name = "S003 POTASSIUM",
            text = {
                "Scored cards give {X:red,C:white}X#1#{} Mult and have",
                "a {C:green}#2# in #3#{} chance to be {C:red}banished",
                "Adjacent jokers have a {C:green}#4# in #5#{} chance",
                "to be {C:red}banished{} at the end of round"
            }
        },
        j_hpr_crazy = {
            name = "S004 CRAZY",
            text = {
                "This joker gains {C:mult}+#2#{} Mult for",
                "every {C:attention}unique poker hand{} contained",
                "in played hand",
                "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
            }
        },
        j_hpr_crafty = {
            name = "S005 CRAFTY",
            text = {
                "This joker gains {C:chips}+#2#{} Chips for",
                "every {C:attention}unique poker hand{} contained",
                "in played hand",
                "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)"
            }
        },
        j_hpr_storm = {
            name = "S006 STORM",
            text = {
                "All {C:attention}played{} and {C:attention}held{} cards score",
                "{C:attention}Retrigger{} all scored cards"
            }
        },
        j_hpr_straightaway = {
            name = "S007 STRAIGHTAWAY",
            text = {
                "If played hand contains a {C:attention}Straight",
                "this Joker gains {X:mult,C:white}X#2#{} Mult and",
                "creates a {C:dark_edition}Negative {C:spectral}Spectral{} card",
                "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
            }
        },
        j_hpr_void = {
            name = "S008 VOID",
            text = {
                "{X:mult,C:white}X#1#{} Mult for each {C:attention}unused space{} in",
                "{C:attention}Joker{} slots, {C:attention}Consumable{} slots and",
                "{C:attention}played{} hand, {C:attention}multiplied{} by the",
                "amount of cards below {C:attention}#3#{} in",
                "your {C:attention}full deck",
                "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
            }
        },
        j_hpr_nimbus = {
            name = "S009 NIMBUS",
            text = {
                "Scored and held in hand {C:attention}9s{} gain",
                "{C:money}$#1#{} respective to their {C:attention}area{}",
                "Earn the {C:money}net value{} of all {C:attention}9s{} in",
                "your {C:attention}full deck{} at the end of round",
                "{C:inactive}(Currently {C:money}$#2#{C:inactive})"
            }
        },
        j_hpr_shorthand = {
            name = "S010 SHORTHAND",
            text = {
                {"All {C:attention}Flushes{} and {C:attention}Straights{}",
                "can be made with {C:attention}3{} cards"},
                {"{C:attention}Pairs{} and {C:attention}X of a Kind{} hands",
                "can be made with {C:attention}1{} fewer card"},
                {"{C:attention}Straights{} may have gaps of {C:attention}1",
                "card and may {C:attention}wrap around"}
            }
        },
        j_hpr_diamond = {
            name = "S011 DIAMOND",
            text = {
                "{C:diamonds}Diamond{} cards {C:attention}permanently{} gain",
                "{C:mult}+#1#{} Mult and {C:money}$#2#{} when scored"
            }
        },
        j_hpr_heart = {
            name = "S012 HEART",
            text = {
                "{C:hearts}Heart{} cards give {X:mult,C:white}X1.5{} Mult and",
                "{C:attention}permanently{} gain {C:mult}+3{} Mult when scored"
            }
        },
        j_hpr_spade = {
            name = "S013 SPADE",
            text = {
                "{C:spades}Spade{} cards {C:attention}permanently{} gain",
                "{C:mult}+#1#{} Mult and {C:chips}+#2#{} chips when scored"
            }
        },
        j_hpr_club = {
            name = "S014 CLUB",
            text = {
                "{C:clubs}Club{} cards permanently gain",
                "{C:mult}Mult{} equal to {X:mult,C:white}#1#X{} their {C:attention}rank's",
                "base {C:chips}Chips{} when scored"
            }
        },
        j_hpr_executive_card = {
            name = "Executive Card",
            text = {
                "Choose {C:attention}any{} number of cards",
                "from {C:attention}Booster Packs"
            }
        },
        j_hpr_7_ball = {
            name = "7 Ball",
            text = {
                "{C:green}#1# in #2#{} chance for each",
                "played {C:attention}7{} to create a",
                "{C:spectral}Spectral{} card when scored",
                "{C:inactive}(Must have room)",
            }
        },
        j_hpr_double_dice = {
            name = "Double Dice",
            text = {
                "Each played card {C:attention}permanently{} gains",
                "{C:chips}#1#-#2#{} Chips and {C:mult}#3#-#4#{} Mult when scored"
            }
        },
        j_hpr_green_card = {
            name = "Green Card",
            text = {
                "Increases all {C:attention}listed {C:green}numerators",
                "and {C:green}denominators{} by {C:green}0",
                "Increases by {C:green}0.25{} when a",
                "{C:attention}Booster Pack{} is skipped",
                "{C:inactive}(e.g. {C:green}1 in 3{C:inactive} -> {C:green}#3# in #4#{C:inactive})"
            }
        },
        j_hpr_ghost = {
            name = "Ghost Joker",
            text = {
                "Creates a {C:spectral}#1#{} when",
                "{C:attention}Boss Blind{} is defeated"
            }
        },
        j_hpr_takeout_box = {
            name = "Takeout Box",
            text = {
                "Creates a {C:dark_edition}Negative{C:attention} Food Joker",
                "when {C:attention}Boss Blind{} is defeated"
            }
        },
        j_hpr_wild = {
            name = "S015 WILD",
            text = {
                "Each played {V:1}#2#{} card becomes",
                "{C:attention}Wild{} and {C:dark_edition}Polychrome{} and gives",
                "{X:mult,C:white}X#1#{} Mult when scored",
                "{s:0.8}suit changes at end of round",
            }
        },
        j_hpr_stone = {
            name = "S016 STONE",
            text = {
                {"Creates a {C:attention}Stone{} card and converts",
                "a random card in deck to {C:attention}Stone",
                "when blind is selected"},
                {"Played {C:attention}Stone{} cards gain a",
                "random {C:attention}Seal{} and {C:dark_edition}Edition"},
                {"{X:chips,C:white}X#2#{} Chips for each {C:attention}Stone{}",
                "card in your {C:attention}full deck",
                "{C:inactive}(Currently {X:chips,C:white}X#1#{C:inactive} Chips)"}
            }
        },
        j_hpr_conjurer = {
            name = "S017 CONJURER",
            text = {
                "Adds {C:attention}#3# free Mega Standard Packs{} to each shop",
                "This Joker gains {X:mult,C:white}X#2#{} Mult when",
                "a {C:attention}playing card{} is added to your deck",
                "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
            }
        },
        j_hpr_slot_machine = {
            name = "#3# Slot Machine",
            text = {
                "Lose {C:red}$#1#{} when hand is played",
                "Earn {C:money}$#2#{} at the end of round",
                "{C:green}#4# in #5#{} chance to earn",
                "{X:money,C:white}67X{} the amount",
                "{s:0.8,C:inactive}Sponsored by {s:0.8,C:gold}Gold Stake"
            }
        },
        j_hpr_circus = {
            name = "S018 CIRCUS",
            text = {
                "{C:attention}+#1#{} Hands and Discards",
                "{C:attention}+#2#{} Hand Size and",
                "Consumable Slots",
                "{C:attention}+#3#{} Card Selection Limit"
            }
        },
        j_hpr_unity = {
            name = "S019 UNITY",
            text = {
                "This joker gains {X:mult,C:white}X#2#{} Mult for",
                "every {C:attention}unique poker hand{} contained",
                "in played hand",
                "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
            }
        },
        j_hpr_derivative = {
            name = "Derivative",
            text = {
                "The first {X:mult,C:white}XMult{} effect",
                "each hand becomes {C:mult}+Mult{}",
                "with {C:attention}#1#X{} the amount"
            }
        },
        j_hpr_antiderivative = {
            name = "Antiderivative",
            text = {
                "All {C:mult}+Mult{} effects become",
                "{X:mult,C:white}XMult{} with {C:attention}1+#1#X{} the amount"
            }
        },
        j_hpr_new_meme = {
            name = "#1#-#2# New Meme",
            text = {
                "If scoring hand contains a",
                "{C:attention}#1#{} and a {C:attention}#2#{}, creates a",
                "random {C:attention}Joker{} card,",
                "{s:0.8}ranks change each round",
                "{C:inactive}(Must have room)"
            }
        },
        j_hpr_tiny_chad = {
            name = "Tiny Hanging Chad",
            text = {
                "First scoring {C:attention}2{} gains",
                "{C:attention}1{} permanent retrigger"
            }
        },
        j_hpr_hype_moments = {
            name = "Hype Moments and Aura",
            text = {
                "Creates an {C:spectral}#1#{} card when",
                "{C:attention}Boss Blind{} is defeated",
                "in only {C:attention}1{} hand"
            }
        },
        j_hpr_plarva = {
            name = "Pluripotent Larva",
            text = {
                "{C:attention}Prevents death{} and {C:attention}destroys{} all held",
                "{C:attention}Consumables{}, then fills Consumable",
                "slots with {C:attention}Eternal {C:spectral}Spectral{} cards",
                "{C:red}Must have room to activate",
                "{C:red}self destructs"
            }
        },
        j_hpr_mask = {
            name = "S020 MASK",
            text = {
                "Played {C:attention}face{} cards randomly give",
                "{X:mult,C:white}X#1#{} Mult, {C:chips}+#2#{} Chips or {C:money}$#3#{} when scored",
                "Retriggers all {C:attention}face{} cards"
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
                "{X:dark_edition,C:white}X#1#{} {C:chips}Chips{}, {C:mult}Mult{} and {C:money}${} effects",
                "from this card"
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
        },
        hpr_num_bonus = {
            text = {
                "Permanent {C:green}+#1#{} numerator"
            }
        },
        hpr_denom_bonus = {
            text = {
                "Permanent {C:green}+#1#{} denominator"
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
            name = "Ascension",
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
                "Permanently adds {C:green}+#1#{} numerator",
                "to {C:attention}#2#{} selected card"
            }
        },
        c_hpr_dysnomia = {
            name = "Dysnomia",
            text = {
                "Permanently boosts the {C:chips}Chips{}, {C:mult}Mult{} and {C:money}${}",
                "effects of {C:attention}#2#{} selected card by {X:dark_edition,C:white}X#1#{}"
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
        k_hpr_stellar = "Stellar",
        hpr_generic_q = "?????",
        k_plus_aura = "+1 Aura",
        k_saved_q = "Saved?",
        ph_hpr_plarva = "Saved by Pluripotent Larva"
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
