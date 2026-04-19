
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
                "a {T:c_hpr_ascender,C:spectral}#1#{} card"
            }
        },
        b_hpr_treasury = {
            name = "Treasury Deck",
            text = {
                "Start with an extra {C:money}$#1#",
                "You cannot spend below {C:money}$#1#",
            }
        },
        b_hpr_inverted = {
            name = "Inverted Deck",
            text = {
                "{C:attention}Consumable{} cards",
                "may be {C:dark_edition}Negative"
            }
        },
    },
    Blind = {
        bl_hpr_final_horse = {
            name = "Heliotrope Horse",
            text = {
                "Takes the cube root",
                "of base Chips and Mult"
            }
        },
        bl_hpr_final_mist = {
            name = "Malachite Mist",
            text = {
                "All Jokers are debuffed"
            }
        },
        bl_hpr_final_splash = {
            name = "Saffron Splash",
            text = {
                "Unenhanced cards",
                "will not score"
            }
        },
        bl_hpr_final_globe = {
            name = "Golden Globe",
            text = {
                "-1 Hand,",
                "-1 Discard,",
                "-1 Hand Size,"
            }
        },
        bl_hpr_final_bomb = {
            name = "Bark Bomb",
            text = {
                "Destroys all held in hand",
                "cards after scoring"
            }
        },
    },
    Edition = {
        e_hpr_green = {
            name = "Green",
            text = {
                "{C:mult}+#1#{} Mult",
                "{C:mult}+#2#{} Mult on hand played",
                "{C:mult}-#2#{} Mult on discard"
            }
        },
        e_hpr_green_pcard = {
            name = "Green",
            text = {
                "{C:mult}+#1#{} Mult",
                "{C:mult}+#2#{} Mult when played",
                "{C:mult}-#2#{} Mult when discarded"
            }
        }
    },
    Enhanced = {
        m_hpr_ripple = {
            name = "Ripple Card",
            text = {
                "When played and {C:attention}scoring{},",
                "all other {C:attention}scoring{} cards",
                "{C:attention}permanently{} gain {C:chips}+#1#{} Chips"
            }
        },
        m_hpr_storm = {
            name = "Storm Card",
            text = {
                "When played and {C:attention}scoring{},",
                "all other {C:attention}scoring{} cards",
                "{C:attention}permanently{} gain {C:mult}+#1#{} Mult"
            }
        },
        m_hpr_error_enh = {
            name = "[MISSING]",
            text = {
                "{C:dark_edition}?????"
            }
        },
        m_hpr_purpur = {
            name = "Purpur Card",
            text = {
                "{C:purple}+#1#{} Score,",
                "scales with {C:attention}Ante",
                "{C:inactive}(Currently {C:purple}+#2#{C:inactive})"
            }
        },
        m_hpr_relic = {
            name = "Relic Card",
            text = {
                "No rank or suit",
                "{X:purple,C:white}X#1#{} Score for each",
                "level on {V:1}#3#{} ({V:2}lvl.#4#{}),",
                "{s:0.8}suit changes each round",
                "{C:inactive}(Currently {X:purple,C:white}X#2#{C:inactive} Score)"
            }
        }
    },
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
                "{C:hpr_balance}Balances {C:chips}Chips{} and {C:mult}Mult{}",
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
                "when eaten"
            }
        },
        --#region Eris descriptions
        j_hpr_eris = {
            name = "Eris",
            text = {
                {
                    "{C:attention}Rankless{} cards instead count as {C:attention}#1#s",
                    "{C:attention}Suitless{} cards instead count as {V:1}#2#"
                },
                {
                    "...",
                    "{s:0.8}Rank, suit and effect changes at end of round"
                }
            }
        },
        j_hpr_eris_red = {
            name = "Eris",
            text = {
                {
                    "{C:attention}Rankless{} cards instead count as {C:attention}#1#s",
                    "{C:attention}Suitless{} cards instead count as {V:1}#2#"
                },
                {
                    "Each {C:attention}#1#{} of {V:1}#2#{} gains",
                    "{C:mult}+#3#{} Mult when scored or held",
                    "{s:0.8}Rank, suit and effect changes at end of round"
                }
            }
        },
        j_hpr_eris_green = {
            name = "Eris",
            text = {
                {
                    "{C:attention}Rankless{} cards instead count as {C:attention}#1#s",
                    "{C:attention}Suitless{} cards instead count as {V:1}#2#"
                },
                {
                    "{C:green}Probabilities{} triggered from",
                    "{C:attention}#1#s{} of {V:1}#2#{} are {C:green}guaranteed",
                    "{s:0.8}Rank, suit and effect changes at end of round"
                }
            }
        },
        j_hpr_eris_blue = {
            name = "Eris",
            text = {
                {
                    "{C:attention}Rankless{} cards instead count as {C:attention}#1#s",
                    "{C:attention}Suitless{} cards instead count as {V:1}#2#"
                },
                {
                    "Each {C:attention}#1#{} of {V:1}#2#{} gains",
                    "{C:chips}+#4#{} Chips when scored or held",
                    "{s:0.8}Rank, suit and effect changes at end of round"
                }
            }
        },
        j_hpr_eris_cyan = {
            name = "Eris",
            text = {
                {
                    "{C:attention}Rankless{} cards instead count as {C:attention}#1#s",
                    "{C:attention}Suitless{} cards instead count as {V:1}#2#"
                },
                {
                    "{C:attention}#1#s{} of {V:1}#2#{} level up the last",
                    "played hand when held in hand",
                    "at end of round",
                    "{s:0.8}Rank, suit and effect changes at end of round"
                }
            }
        },
        j_hpr_eris_yellow = {
            name = "Eris",
            text = {
                {
                    "{C:attention}Rankless{} cards instead count as {C:attention}#1#s",
                    "{C:attention}Suitless{} cards instead count as {V:1}#2#"
                },
                {
                    "Each played {C:attention}#1#{} of {V:1}#2#",
                    "gives {C:money}$#5#{} when scored",
                    "{s:0.8}Rank, suit and effect changes at end of round"
                }
            }
        },
        j_hpr_eris_magenta = {
            name = "Eris",
            text = {
                {
                    "{C:attention}Rankless{} cards instead count as {C:attention}#1#s",
                    "{C:attention}Suitless{} cards instead count as {V:1}#2#"
                },
                {
                    "{C:attention}#1#s{} of {V:1}#2#{} create a {C:dark_edition}Negative",
                    "{C:tarot}Tarot{} card when discarded",
                    "{s:0.8}Rank, suit and effect changes at end of round"
                }
            }
        },
        --#endregion
        j_hpr_bungus = {
            name = "Bustling Fungus",
            text = {
                "Increases the {C:attention}rank{} of a",
                "random card in hand",
                "after every hand"
            }
        },
        j_hpr_observatorium = {
            name = "S001 OBSERVATORIUM",
            text = {
                "When a hand's {C:chips}Chips{} or {C:mult}Mult",
                "are {C:attention}leveled up{}, upgrade this",
                "Joker and all cards in your",
                "{C:attention}full deck{} in the same manner",
                "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips, {C:mult}+#2#{C:inactive} Mult)"
            }
        },
        j_hpr_missing = {
            name = "S{C:hpr_super_gay}-nan ?{}ERR{C:hpr_super_gay}??{}OR",
            text = {
                ""
            }
        },
        j_hpr_master = {
            name = "S002 MASTER",
            text = {
                {"Creates {C:attention}#1#{} random {C:attention}Tags{} and {C:attention}Booster",
                "{C:attention}Packs{} when {C:attention}Blind{} is selected"},
                {"Played unenhanced non-{C:attention}face{} cards",
                "become random {C:attention}consumables{} when played"}
            }
        },
        j_hpr_potassium = {
            name = "S003 POTASSIUM",
            text = {
                {"{X:slib_emult,C:white}^#1#{} Mult"},
                {
                    "Played cards have a {C:green}#2# in #3#{} chance",
                    "to be {C:attention}destroyed{} after scoring",
                    "Other {C:attention}Jokers{} have a {C:green}#4# in #5#{} chance",
                    "to be {C:red}banished{} at the end of round"
                }
            }
        },
        j_hpr_crazy = {
            name = "S004 CRAZY",
            text = {
                "All {C:attention}poker hands{} contained in",
                "played hand gain {C:mult}+#1#{} Mult for",
                "each {C:attention}unique{} contained {C:attention}poker hand"
            }
        },
        j_hpr_crafty = {
            name = "S005 CRAFTY",
            text = {
                "All {C:attention}poker hands{} contained in",
                "played hand gain {C:chips}+#1#{} Chips for",
                "each {C:attention}unique{} contained {C:attention}poker hand"
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
                {"If played hand contains a {C:attention}Straight",
                "this Joker gains {X:mult,C:white}X#2#{} Mult and",
                "creates a {C:dark_edition}Negative {C:attention}Consumable{} card",
                "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"},
                {"If played hand contains a {C:attention}Straight",
                "{C:attention}Flush{}, increase scaling by {X:mult,C:white}X#3#{} and",
                "create a random {C:attention}Voucher",
                "{C:inactive}(Must have room)"}
            }
        },
        j_hpr_void = {
            name = "S008 VOID",
            text = {
                {"{X:mult,C:white}X#1#{} Mult for each card",
                "below {C:attention}#3#{} in your full deck",
                "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"},
                {"{X:slib_emult,C:white}^#4#{} Mult for each unused",
                "space in {C:attention}Joker{} slots, {C:attention}played",
                "{C:attention}hand{}, and {C:attention}Consumable{} slots",
                "{C:inactive}(Currently {X:slib_emult,C:white}^#5#{C:inactive} Mult)"}
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
                {"Each played {C:diamonds}Diamond{} card",
                "gives {X:mult,C:white}X#1#{} Mult when scored"},
                {"Earn {C:money}$#2#{} at end of round for",
                "every {C:diamonds}Diamond{} card in full deck",
                "{C:inactive}(Currently {C:money}$#3#{C:inactive})"}
            }
        },
        j_hpr_heart = {
            name = "S012 HEART",
            text = {
                "Each scored {C:hearts}Heart{} card",
                "has a {C:green}#1# in #2#{} chance to",
                "give {X:slib_emult,C:white}^#4#{} Mult, else {X:mult,C:white}X#3#{} Mult"
            }
        },
        j_hpr_spade = {
            name = "S013 SPADE",
            text = {
                "Each scored {C:spades}Spade{} card gives",
                "{X:purple,C:white}X#3#{} Chips and Mult and",
                "gains {C:mult}+#1#{} Mult and {C:chips}+#2#{} Chips"
            }
        },
        j_hpr_club = {
            name = "S014 CLUB",
            text = {
                "Played {C:clubs}Clubs{} level up {C:clubs}Clubs",
                "with {C:chips}+#1#{} Chips and {C:mult}+#2#{} Mult",
                "Scored {C:clubs}Clubs{} give {X:mult,C:white}X#3#{} Mult"
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
            name = "S016 CONJURER",
            text = {
                "Adds {C:attention}#3# free Mega Standard Packs{} to each shop",
                "This Joker gains {X:mult,C:white}X#2#{} Mult when",
                "a {C:attention}playing card{} is added to your deck",
                "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
            }
        },
        j_hpr_circus = {
            name = "S017 IRRADIANT",
            text = {
                "Increases {C:dark_edition}ALL{} your stats by {C:attention}#1#{},",
                "reduces Ante by {C:attention}#1#{} while held",
                "{C:inactive}(Joker Slots excluded)",
            }
        },
        j_hpr_unity = {
            name = "S018 UNITY",
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
                "If {C:attention}first hand{} of round",
                "is a single {C:attention}2{}, it gains",
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
            name = "S019 MASK",
            text = {
                "Scored and held in hand",
                "{C:attention}face{} cards give {X:mult,C:white}X#2#{} Mult",
                "Earn {C:money}$#2#{} at end of round",
                "for every {C:attention}face{} card in",
                "your {C:attention}full{} deck",
                "{C:inactive}(Currently {C:money}$#3#{C:inactive})"
            }
        },
        j_hpr_numeric = {
            name = "S020 NUMERIC",
            text = {
                "When any non-{C:attention}face{} card is scored",
                "all other {C:attention}played{} cards permanently",
                "gain {C:chips}Chips{} and {C:mult}Mult{} equal to the",
                "scored card's {C:attention}base {C:chips}Chips"
            }
        },
        j_hpr_payload = {
            name = "S021 PAYLOAD",
            text = {
                "Earn {C:money}$1{} at the end of round",
                "for every {C:money}$#2#{} you have, up to",
                "a maximum of {C:money}$#1#{}, then increase",
                "this limit by {C:money}$#3#"
            }
        },
        j_hpr_destroyer = {
            name = "S022 HYDRA",
            text = {
                {"When {C:attention}Blind{} is selected,",
                "destroy joker to the right",
                "and add {C:attention}#2#%{} of its sell value",
                "to this Joker's {X:slib_emult,C:white}^Mult",
                "{C:inactive}(Currently {X:slib_emult,C:white}^#1#{C:inactive} Mult)"},
                {"This Joker gains {C:attention}#4#%{} of destroyed",
                "{C:attention}playing card's{} rank as {X:slib_echips,C:white}^Chips",
                "{C:inactive}(Currently {X:slib_echips,C:white}^#3#{C:inactive} Chips)"}
            }
        },
        j_hpr_ascendant = {
            name = "S023 ASCENDANT",
            text = {
                {
                    "All {C:attention}scored{} cards gain {X:chips,C:white}X#1#{} Chips",
                    "All {C:attention}discarded{} cards gain {X:mult,C:white}X#2#{} Mult",
                },
                {
                    "If {C:attention}first{} hand of round has",
                    "only {C:attention}1{} card, it gains a",
                    "permanent {C:attention}retrigger"
                }
            }
        },
        j_hpr_mimic = {
            name = "S024 MIMIC",
            text = {
                "Retriggers Joker to the",
                "right {C:attention}#1#{} time#<s>1#, {C:green}#3# in #4#{} chance",
                "at end of round to increase",
                "retriggers and denominator by {C:attention}#2#"
            }
        },
        j_hpr_lucky = {
            name = "S025 LUCKY",
            text = {
                "{C:green,E:1}Probabilities{} on {C:attention}Blinds{} are {C:attention}nullified",
                "When a {C:green,E:1}probability{} rolls for a card,",
                "it permanently gains {C:green}+#1# {C:attention}listed",
                "{C:green,E:1}numerators{} and {C:green,E:1}denominators",
            }
        },
        j_hpr_diamond_shape_with_a_dot_inside = {
            name = "Diamond Shape with a Dot Inside",
            text = {
                "Each played {C:diamonds}Diamond{} card",
                "gives {X:mult,C:white}X#1#{} Mult when scored"
            }
        },
        j_hpr_ult_meal = {
            name = "Ultimate Meal",
            text = {
                "{C:attention}Rerolls{} all {C:attention}listed",
                "{C:green,E:1}probabilities {C:attention}#1#{} times"
            }
        },
        j_hpr_tiny_graph = {
            name = "Memory",
            text = {
                "First played {C:attention}2",
                "gives {X:mult,C:white}X#1#{} Mult",
                "when scored"
            }
        },
        j_hpr_copier = {
            name = "Photocopier",
            text = {
                "Creates a {C:attention}Perishable",
                "{C:dark_edition}Negative{} copy of the",
                "rightmost joker when",
                "{C:attention}Boss Blind{} is defeated",
                "{C:inactive}(Photocopier excluded)"
            }
        },
        j_hpr_rent = {
            name = "Rent-a-Joker",
            text = {
                "Sell this card to create a",
                "{C:attention}Rental Perishable {C:red}Rare {C:attention}Joker",
                "{C:inactive}(Must have room)"
            }
        },
        j_hpr_genius_horse = {
            name = "Genius Horse",
            text = {
                "Adds the {C:attention}cube root{} of",
                "current {C:chips}Chips{} to {C:mult}Mult"
            }
        },
        j_hpr_fossil = {
            name = "Fossilized Joker",
            text = {
                "{C:attention}-1{} Ante while held"
            }
        },
        j_hpr_evil_eris = {
            name = "Sire",
            text = {
                "When a {C:planet}Planet{}, {C:hpr_moons}Moon{} or {C:star}Star",
                "card is used, all cards in your",
                "{C:attention}full{} deck permanently gain {C:gold}+#1#",
                "Ascension Power. {C:attention}Rankless{} cards",
                "instead gain {X:gold,C:white}X#2#{} Ascension Power"
            }
        },
        j_hpr_good_bomb = {
            name = "Good Bomb",
            text = {
                "After {C:attention}#1#{} rounds, {C:red}self destructs",
                "and adds random {C:dark_edition}editions{} to {C:attention}#2#",
                "cards in your {C:attention}full{} deck"
            }
        },
        j_hpr_paint_bucket = {
            name = "Quart of White Paint",
            text = {
                "{C:attention}+#1#{} hand size",
                "Removes {C:attention}enhancement{} from scoring",
                "cards when hand is played",
                "Destroyed if scoring hand",
                "has no {C:attention}enhanced{} cards"
            }
        },
        j_hpr_benthic = {
            name = "Benthic Bloom",
            text = {
                "{C:blue}Common{C:attention} Jokers{} appear",
                "{C:attention}#1#X{} as often"
            }
        },
        j_hpr_blue_wee = {
            name = "Blue Baby",
            text = {
                "{C:chips}+#1#{} Chips for each",
                "{C:attention}2{} in your full deck",
                "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
            }
        },
        j_hpr_petit_michel = {
            name = "Petit Michel",
            text = {
                "Each played {C:attention}2{} gives",
                "{C:mult}+#1#{} Mult when scored",
                "{C:green}#2# in #3#{} chance this is",
                "destroyed at end of round"
            }
        },
        j_hpr_averagedish = {
            name = "Average Sized Cavendish",
            text = {
                "Each played {C:attention}2{} gives",
                "{X:mult,C:white}X#2#{} Mult when scored",
                "and has a {C:green}#2# in #3#{} chance",
                "to be destroyed"
            }
        },
        j_hpr_mealy_apple = {
            name = "Mealy Apple",
            text = {
                "Discarded cards gain",
                "{C:mult}+#1#{} Mult for the",
                "next {C:attention}#2#{} discard#3#"
            }
        },
        j_hpr_2_ball = {
            name = "2 Ball",
            text = {
                "{C:green}#1# in #2#{} chance for each",
                "played {C:attention}2{} to create a",
                "{C:dark_edition}Green {C:tarot}Tarot{} card when scored",
                "{C:inactive}(Must have room)"
            }
        },
        j_hpr_apostrophe_m = {
            name = "'M",
            text = {
                "replaced by"
            }
        },
        j_hpr_glass_shard = {
            name = "Glass Shard",
            text = {
                "{X:mult,C:white}X#1#{} Mult",
                "The first card used",
                "in scoring has a",
                "{C:green}#2# in #3#{} chance to",
                "be {C:attention}destroyed"
            }
        },
        j_hpr_ceramic = {
            name = "Ceramic",
            text = {
                "{C:chips}+#1#{} Chips",
                "Breaks after {C:attention}#2#",
                "cards discarded"
            }
        },
        j_hpr_fine_china = {
            name = "Fine China",
            text = {
                "{X:chips,C:white}X#1#{} Chips",
                "Breaks when discarding",
                "more than {C:attention}#2#{} cards at once"
            }
        },
        j_hpr_butterfinger = {
            name = "Butterfingers",
            text = {
                "All {C:attention}Straights{} and",
                "{C:attention}Flushes{} can be made",
                "with {C:attention}#1#{} card#2#. Increases",
                "by {C:attention}1{} at end of round"
            }
        },
        j_hpr_superfluid = {
            name = "Superfluid",
            text = {
                "{C:hpr_balance}Balances {C:chips}Chips{} and {C:mult}Mult",
                "values of scored cards"
            }
        },
        j_hpr_cloud_2 = {
            name = "Cloud 2",
            text = {
                "Earn {C:money}$#1#{} for each",
                "{C:attention}2{} in your {C:attention}full deck",
                "at end of round",
                "{C:inactive}(Currently {C:money}$#2#{C:inactive})"
            }
        },
        j_hpr_wee_remote = {
            name = "Wee Remote",
            text = {
                "Each played {C:attention}2{} gives",
                "{X:chips,C:white}X#2#{} Chips and {X:mult,C:white}X#1#{} Mult",
                "when scored"
            }
        },
        j_hpr_night = {
            name = "Night",
            text = {
                "Jokers have a {C:green}#1# in #2#",
                "chance to be {C:attention}retriggered",
                "while outside of a {C:attention}Blind"
            }
        },
        j_hpr_sprout = {
            name = "Bean Sprout",
            text = {
                "After {C:attention}#2#{} rounds, sell",
                "this card to permanently",
                "gain {C:attention}+#1#{} hand size",
                "{C:inactive}(Currently {C:attention}#3#{C:inactive}/#2#)"
            }
        },
        j_hpr_softball = {
            name = "Softball Card",
            text = {
                "Other {C:hpr_wee}Wee{} Jokers",
                "each give {X:mult,C:white}X#1#{} Mult"
            }
        },
        j_hpr_stellarchicken = {
            name = "SDX001 GRILLED CHICKEN",
            text = {
                {
                    "Retriggers all Grilled Chicken",
                    "Jokers once for every #1# Ante"
                },
                {
                    "Creates a {C:attention}Grilled Chicken",
                    "Joker when {C:attention}Blind{} is selected"
                },
                {"Replace all future {C:attention}Food{} Jokers",
                "with {C:attention}Grilled Chicken{} variants"}
            }
        },
        j_hpr_guardian = {
            name = "S026 GUARDIAN",
            text = {
                "{C:attention}Prevents death{} once",
                "per {C:attention}Ante{} and creates",
                "a {C:dark_edition}Negative {C:attention}Eternal Joker",
                "{C:inactive}(Currently #1#)"
            }
        },
        j_hpr_hurtbreak = {
            name = "Hurtbreak Wonderland",
            text = {
                "{C:attention}8s{} permanently gain",
                "{C:money}$#1#{} when they change",
                "{C:attention}Enhancement"
            }
        },
        j_hpr_through_the_mirror = {
            name = "Through the Mirror",
            text = {
                "Scored {C:attention}8s{} have a recursive",
                "{C:green}#1# in #2#{} chance to retrigger",
                "{C:green}-1 {C:attention}base {C:green}numerator{} for every",
                "consecutive success"
            }
        },
        j_hpr_disintegration_loop = {
            name = "Disintegration Loop",
            text = {
                "Played {C:attention}8s{} level up",
                "a random {C:attention}poker hand"
            }
        },
        j_hpr_final_flight = {
            name = "Final Flight",
            text = {
                "Draw an {C:attention}extra card",
                "after each hand for",
                "every {C:attention}8{} held in hand"
            }
        },
        j_hpr_buffoon = {
            name = "S027 BUFFOON",
            text = {
                {"When {C:attention}Blind{} is selected, creates",
                "{C:attention}#1# {C:dark_edition}editioned {C:attention}Jokers{} with",
                "increased values based on their {C:attention}rarity"},
                {"Other Jokers trigger {C:mult}Mult{}",
                "based on their {C:attention}rarity"},
                {
                    "{C:common}Common{}: {X:dark_edition,C:white}X#2#{} values | {C:mult}+#5#{} Mult",
                    "{C:uncommon}Uncommon{}: {X:dark_edition,C:white}X#3#{} values | {X:mult,C:white}X#6#{} Mult",
                    "{C:rare}Rare{}: {X:dark_edition,C:white}X#4#{} values | {X:slib_emult,C:white}^#7#{} Mult",
                    "Any rarer: N/A | {X:slib_emult,C:white}^#7#{} Mult"
                }
            }
        },
        j_hpr_hunter = {
            name = "S028 HUNTER",
            text = {
                {"Disables effect of every {C:attention}Boss Blind"},
                {"{C:hpr_boss}Boss{} Jokers give",
                "{C:money}$#1#{} when triggered"},
                {"Always get a {C:hpr_boss}Boss{} Joker after",
                "the {C:attention}Boss Blind{} if possible"}
            }
        },
        j_hpr_man = {
            text = {
                "*Well, there is a man here."
            }
        },
        j_hpr_quiz = {
            name = "Quiz",
            text = {
                "Level up {V:1}#1#{} with",
                "{C:chips}+10{} Chips if scoring hand",
                "contains any {V:1}#1#{},",
                "{s:0.8}suit changes at end of round"
            }
        },
        j_hpr_zodiac = {
            name = "Zodiac",
            text = {
                "Gives the base {C:chips}Chips",
                "and {C:mult}Mult{} of {C:attention}#1#{},",
                "{s:0.8}hand changes at end of round",
                "{C:inactive}({C:chips}+#2#{C:inactive} Chips, {C:mult}+#3#{C:inactive} Mult)"
            }
        },
        j_hpr_cornucopia = {
            name = "Cornucopia",
            text = {
                "{C:attention}+#1#{} Consumable slot#<s>1#",
                "Fills all consumable slots",
                "with random {C:attention}consumables{} for",
                "the next {C:attention}#2#{} selected Blind#<s>2#"
            }
        },
        j_hpr_golden_ratio = {
            name = "Golden Ratio",
            text = {
                "Each played {C:attention}6{}, {C:attention}Ace{} or {C:attention}8",
                "gives {C:money}$#1#{} when scored"
            }
        },
        j_hpr_pie = {
            name = "Pumpkin Pi",
            text = {
                "Each played {C:attention}3{}, {C:attention}Ace{} or {C:attention}4",
                "gives {X:chips,C:white}X#1#{} Chips when scored"
            }
        },
        j_hpr_duplicator = {
            name = "Substandard Duplicator",
            text = {
                "When a {C:attention}Joker{} is bought,",
                "creates a {C:dark_edition}Negative{C:attention} Perishable",
                "copy with no {C:attention}sell value"
            }
        },
        j_hpr_prospector = {
            name = "Prospector",
            text = {
                "When round begins, draw",
                "all {C:attention}Gold Cards{} to hand"
            }
        },
        j_hpr_evil_heat = {
            name = "This Heat, an Evil Heat",
            text = {
                "Each scored {C:attention}10{} gives {X:mult,C:white}X#1#{} Mult",
                "and then increases this by {X:mult,C:white}X#2#",
                "Destroys played cards if {X:mult,C:white}XMult",
                "is greater than {X:mult,C:white}X#3#{} after scoring",
                "Resets after scoring"
            }
        },
        j_hpr_ashes = {
            name = "...then Fell the Ashes",
            text = {
                "{C:attention}Aces{} count as any {C:attention}suit",
                "Randomizes played {C:attention}Aces"
            }
        },
        j_hpr_execution = {
            name = "Executioner's Axe",
            text = {
                "{C:attention}Banishes{} a random {C:attention}Joker",
                "at the end of the {C:attention}shop",
            }
        },
        j_hpr_clown = {
            name = "Clown",
            text = {
                "{C:purple}+#1#{} Score,",
                "Scales with ante",
                "{C:inactive}(Currently {C:purple}+#2#{C:inactive})"
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
                "Select {C:hpr_erratic_col}#2#{} of up to",
                "{C:hpr_erratic_col}#1#{} random cards"
            }
        },
        p_hpr_erratic_pack_jumbo = {
            name = "#3# Erratic Pack",
            text = {
                "Select {C:hpr_erratic_col}#2#{} of up to",
                "{C:hpr_erratic_col}#1#{} random cards"
            }
        },
        p_hpr_erratic_pack_mega = {
            name = "#3# Erratic Pack",
            text = {
                "Select {C:hpr_erratic_col}#2#{} of up to",
                "{C:hpr_erratic_col}#1#{} random cards"
            }
        },
        p_hpr_erratic_mega_no_var = { --hardcoded loc_vars desc for tag
            name = "Mega Erratic Pack",
            text = {
                "Select {C:hpr_erratic_col}2{} of up to",
                "{C:hpr_erratic_col}5{} random cards"
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
        },
        hpr_negative_seal = {
            name = "Negative Seal",
            text = {
                "{C:dark_edition}+#1#{} Hand Size",
                "until end of round",
                "when scored"
            }
        },
        p_hpr_awesome = {
            name = "{C:hpr_awesome}AWESOME{} Buffoon Pack",
            text = {
                "Choose {C:attention}#1#{} of up to",
                "{C:attention}#2#{C:hpr_awesome} AWESOME{} Jokers"
            }
        },
        p_hpr_wee = {
            name = "Wee Buffoon Pack",
            text = {
                "Choose {C:attention}#1#{} of up to",
                "{C:attention}#2# {C:hpr_wee}Wee{} Joker cards"
            }
        },
        hpr_dual_seal = {
            name = "Dual Seal",
            text = {
                "{C:red}+#1#{} Discard",
                "when scored",
                "{C:blue}+#2#{} Hand when",
                "discarded"
            }
        },
        hpr_bronze_seal = {
            name = "Copper Seal",
            text = {
                "If this is the {C:attention}only",
                "played card, destroy it",
                "and gain {C:attention}+#1#{} consumable slot"
            }
        },
        hpr_void_seal = {
            name = "Void Seal",
            text = {
                "Creates a {C:hpr_moons}Moon{} card",
                "when played and scoring",
                "on first hand of round",
                "{C:inactive}(Must have room)"
            }
        }
    },
    Planet = {
        c_hpr_coast = {
            name = "Gilded Coast",
            text = {
                "({V:1}lvl.#1#{}) Level up",
                "{V:2}#2#",
                "{C:chips}+#3#{} Chips"
            }
        },
        c_hpr_neural = {
            name = "Neural Sanctum",
            text = {
                "({V:1}lvl.#1#{}) Level up",
                "{V:2}#2#",
                "{C:chips}+#3#{} Chips"
            }
        },
        c_hpr_limbo = {
            name = "A Moment, Whole",
            text = {
                "({V:1}lvl.#1#{}) Level up",
                "{V:2}#2#",
                "{C:chips}+#3#{} Chips"
            }
        },
        c_hpr_bulwark = {
            name = "Bulwark's Ambry",
            text = {
                "({V:1}lvl.#1#{}) Level up",
                "{V:2}#2#",
                "{C:chips}+#3#{} Chips"
            }
        },
        c_hpr_petrichor = {
            name = "Petrichor V",
            text = {
                "({V:1}lvl.#1#{}) Level up",
                "{C:attention}suitless{} cards",
                "{C:chips}+#3#{} Chips"
            }
        },
        c_hpr_bazaar = {
            name = "Bazaar Between Time",
            text = {
                "({V:1}lvl.#1#{}) Level up",
                "{V:2}#2#",
                "{C:mult}+#3#{} Mult"
            }
        },
        c_hpr_computational = {
            name = "Computational Exchange",
            text = {
                "({V:1}lvl.#1#{}) Level up",
                "{V:2}#2#",
                "{C:mult}+#3#{} Mult"
            }
        },
        c_hpr_fractured = {
            name = "A Moment, Fractured",
            text = {
                "({V:1}lvl.#1#{}) Level up",
                "{V:2}#2#",
                "{C:mult}+#3#{} Mult"
            }
        },
        c_hpr_v_fields = {
            name = "Void Fields",
            text = {
                "({V:1}lvl.#1#{}) Level up",
                "{V:2}#2#",
                "{C:mult}+#3#{} Mult"
            }
        },
        c_hpr_commencement = {
            name = "Commencement",
            text = {
                "({V:1}lvl.#1#{}) Level up",
                "{C:attention}suitless{} cards",
                "{C:mult}+#3#{} Mult"
            }
        },
    },
    Spectral = {
        c_hpr_pulsar = {
            name = "Pulsar",
            text = {
                "Applies {C:dark_edition,E:1}Negative{} edition",
                "to {C:attention}#1#{} selected card"
            }
        },
        c_hpr_ascender = {
            name = "Divinity",
            text = {
                "{C:hpr_stellar}Ascends{} one eligible {C:attention}Joker{} to",
                "its {C:hpr_stellar,E:1}Stellar{} counterpart"
            }
        },
        c_hpr_planetarium = {
            name = "The Planetarium",
            text = {
                "Level up",
                "every {E:1,C:legendary}suit{}",
                "{C:chips}+#1#{} Chips and",
                "{C:mult}+#2#{} Mult"
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
        },
        sleeve_hpr_cosmic = {
            name = "Cosmic Sleeve",
            text = {
                "Start the run with",
                "a {T:c_hpr_ascender,C:spectral}#1#{} card"
            }
        },
        sleeve_hpr_cosmic_alt = {
            name = "Cosmic Sleeve",
            text = {
                "{E:1,C:hpr_stellar}Stellar{} Jokers may appear naturally",
            }
        },
        sleeve_hpr_treasury = {
            name = "Treasury Sleeve",
            text = {
                "Start with an extra {C:money}$#1#",
                "You cannot spend below {C:money}$#1#",
            }
        },
        sleeve_hpr_treasury_alt = {
            name = "Treasury Sleeve",
            text = {
                "Earn an extra {C:money}$1{} of",
                "interest for every $5 you",
                "have at end of round"
            }
        },
        sleeve_hpr_inverted = {
            name = "Inverted sleeve",
            text = {
                "{C:attention}Consumable{} cards",
                "may be {C:dark_edition}Negative"
            }
        },
        sleeve_hpr_inverted_alt = {
            name = "Inverted Sleeve",
            text = {
                "{C:attention}Consumable{} cards",
                "are {C:attention}#1#X{} as likely to",
                "be {C:dark_edition}Negative"
            }
        }
    },
    Tag = {
        tag_hpr_deck = {
            name = "Deck Tag",
            text = {
                "Adds a {C:attention}Deck{} to the",
                "Voucher area of",
                "the next shop"
            }
        },
        tag_hpr_chaos = {
            name = "Chaos Tag",
            text = {
                "Gives a free",
                "{C:hpr_erratic_col}Mega Erratic Pack{}",
                "with a random {C:dark_edition}edition"
            }
        },
        tag_hpr_green = {
            name = "Green Tag",
            text = {
                "Next base edition shop",
                "Joker is free and",
                "becomes {C:dark_edition}Green",
            }
        },
        tag_hpr_sleeve = {
            name = "Sleeve Tag",
            text = {
                "Adds a {C:attention}Sleeve{} to the",
                "Voucher area of",
                "the next shop"
            }
        }
    },
    Tarot = {
        c_hpr_green = {
            name = "The Green",
            text = {
                "{C:mult}Greens{} 1 selected card"
            }
        }
    },
    Voucher = {
        v_hpr_stacking = {
            name = "Stacking",
            text = {
                "{C:attention}Playing cards{} in shop or packs",
                "may appear with permanent",
                "{C:chips}Chips{} or {C:mult}Mult{} bonuses"
            }
        },
        v_hpr_massprod = {
            name = "Mass Production",
            text = {
                "{C:attention}Playing cards{} in shop or packs",
                "may appear with permanent",
                "{X:chips,C:white}XChips{} or {X:mult,C:white}XMult{} bonuses"
            }
        },
        v_hpr_recursion = {
            name = "Recursion",
            text = {
                "{C:hpr_erratic_col}Erratic Packs{} may contain",
                "other {C:attention}Booster Packs"
            }
        },
        v_hpr_order_chaos = {
            name = "Ordered Chaos",
            text = {
                "{C:attention}Consumable{} cards and",
                "{C:attention}Vouchers{} can be taken",
                "out of {C:hpr_erratic_col}Erratic Packs"
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
                "Permanently adds {X:purple,C:white}X#1#{} Score",
                "to up to {C:attention}#2#{} selected cards"
            }
        },
        c_hpr_dysnomia = {
            name = "Dysnomia",
            text = {
                "Permanently adds {X:purple,C:white}X#1#{} held in hand",
                "Score to up to {C:attention}#2#{} selected cards"
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
        c_hpr_greip = {
            name = "Greip",
            text = {
                "Permanently adds {C:glop}+#1#{} Glop",
                "to up to {C:attention}#2#{} selected cards"
            }
        },
        c_hpr_gerd = {
            name = "Gerd",
            text = {
                "Permanently adds {C:glop}+#1#{} held in hand",
                "Glop to up to {C:attention}#2#{} selected cards"
            }
        }
    },
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
        hpr_plus_moon = "+1 Moon",
        hpr_plus_q = "+1 ???",
        k_erratic_pack = "Erratic Pack",
        k_hpr_stellar = "Stellar",
        hpr_generic_q = "?????",
        k_plus_aura = "+1 Aura",
        k_saved_q = "Saved?",
        ph_hpr_plarva = "Saved by Pluripotent Larva",
        k_hpr_awesome = "Awesome",
        k_hpr_plus_shop = "+1 Shop Slot",
        k_hpr_plus_csize = "+1 Consumable Slot",
        k_hpr_plus_hand = "+1 Hand",
        k_hpr_plus_discard = "+1 Discard",
        k_hpr_plus_jsize = "+1 Joker Slot",
        k_hpr_minus_ante = "-1 Ante",
        k_hpr_plus_hsize = "+1 Hand Size",
        k_hpr_plus_psize = "+1 Play limit",
        k_hpr_plus_dsize = "+1 Discard limit",
        k_hpr_plus_consumable = "+1 Consumable",
        k_hpr_painted_ex = "Painted!",
        k_hpr_wee = "Wee",
        k_hpr_green = "Green",
        k_hpr_abyssal_pack = "Abyssal Pack",
        k_hpr_awesome_pack = "AWESOME Pack",
        k_plus_hpr_moon = "+1 Moon",
        k_level_down = "Level Down",
        k_plus_joker_q = "+1 Joker?",
        k_inactive = "inactive",
        ph_hpr_stellar_revive = "Blessed by the stars",
        no_repeat_hands = "No repeat hand types per round",
        k_plus_egg = "+1 Egg",
        k_hidden_realm = "Hidden Realm",
        k_all_suits = "All Suits",
        b_hpr_take = "TAKE",
        k_planet_void = "?Pla??ne?t",
        k_hpr_elite = "Elite",
        k_empty_ex = "Empty!",
        k_hpr_plus_voucher = "+1 Voucher",
        k_hpr_enhanced_q = "Enhanced?"
    },
    high_scores = {},
    labels = {
        hpr_moons = "Moon",
        hpr_diy = "DIY",
        hpr_stellar = "Stellar",
        hpr_negative_seal = "Negative Seal",
        hpr_awesome = "Awesome",
        hpr_green = "Green",
        hpr_dual_seal = "Dual Seal",
        hpr_bronze_seal = "Copper Seal",
        hpr_void_seal = "Void Seal",
        hpr_elite = "Elite", --according to the wiki its k_hpr_elite but ive literally never had to do that so idk
    },
    poker_hand_descriptions = {},
    poker_hands = {},
    quips = {},
    ranks = {},
    suits_plural = {},
    suits_singular = {},
    tutorial = {},
    v_dictionary = {
        credits_idea = "Idea: #1#",
        credits_art = "Art: #1#",
        credits_code = "Code: #1#",
        credits_shader = "Shader: #1#",
        credits_music = "Music: #1#", --this is only really useful for packs but whatever
        credits_origin = "Origin: #1#",
        hpr_card_banned = "#1# Banished",
        a_hpr_green = "+#1# Green",
        a_hpr_green_minus = "-#1# Green",
        hpr_n_cards = "#1# Cards",
        a_discards = "+#1# Discards",
        play_x_cards = "Must play #1# cards",
        must_play_x = "Must play #1#"
    },
    v_text = {},
}

return {descriptions = descriptions, misc = misc}
