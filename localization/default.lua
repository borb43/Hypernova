
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
        }
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
                "-1 Hand",
                "-1 Discard",
                "-1 Hand Size"
            }
        },
        bl_hpr_final_bomb = {
            name = "Bark Bomb",
            text = {
                "Destroys all held in hand",
                "cards after scoring"
            }
        }
    },
    Edition = {},
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
        m_hpr_mimic = {
            name = "Mimic Card",
            text = {
                "{X:mult,C:white}X#1#{} Mult",
                "Counts as a",
                "{C:attention}face{} card"
            }
        },
        m_hpr_prism = {
            name = "Prism Card",
            text = {
                "When played and {C:attention}scoring,",
                "a random card in hand",
                "becomes {C:dark_edition}Polychrome",
                "{C:red}Destroyed{} when discarded",
                "or held at the end of round"
            }
        },
        m_hpr_alloy = {
            name = "Alloy Card",
            text = {
                "Also {C:attention}scores{} while held in hand",
                "Also triggers {C:attention}held in hand{}",
                "effects when played and scoring"
            }
        },
        m_hpr_schematic = {
            name = "Fusion Card",
            text = {
                "No rank or suit",
                "Balances {C:chips}Chips{} and",
                "{C:mult}Mult{} when scored"
            }
        },
        m_hpr_silver = {
            name = "Silver Card",
            text = {
                "Creates a random {C:attention}Tag",
                "when held in hand",
                "at the end of round"
            }
        },
        m_hpr_lunar = {
            name = "Lunar Card",
            text = {
                "{C:green}#1# in #2#{} chance to level",
                "up hand when played"
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
                "when eaten"
            }
        },
        j_hpr_eris = {
            name = "Eris",
            text = {
                {
                    "When {C:attention}Blind{} is selected, {C:attention}destroys",
                    "a random held {C:planet}Planet{} card to",
                    "create a {C:dark_edition}Negative {C:hpr_moons}Moon{} card"
                },
                {
                    "When hand is played, {C:attention}destroys",
                    "leftmost held {C:hpr_moons}Moon{} to apply its",
                    "effects to all {C:attention}played{} cards"
                }
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
                "When a hand's {C:chips}Chips{} or {C:mult}Mult",
                "are {C:attention}leveled up{}, upgrade this",
                "Joker and all cards in your",
                "{C:attention}full deck{} by the same amount",
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
                "{X:money,C:white}#3#X{} the amount",
                "{s:0.8,C:inactive}Sponsored by {s:0.8,V:1}#6#"
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
        },
        j_hpr_numeric = {
            name = "S021 NUMERIC",
            text = {
                "When any non-{C:attention}face{} card is scored",
                "all other {C:attention}played{} cards permanently",
                "gain {C:chips}Chips{} and {C:mult}Mult{} equal to the",
                "scored card's {C:attention}base {C:chips}Chips"
            }
        },
        j_hpr_payload = {
            name = "S022 PAYLOAD",
            text = {
                "Earn {C:money}$1{} at the end of round",
                "for every {C:money}$#2#{} you have, up to",
                "a maximum of {C:money}$#1#{}, then increase",
                "this limit by {C:money}$#3#"
            }
        },
        j_hpr_destroyer = {
            name = "S023 DESTROYER",
            text = {
                "When {C:attention}Blind{} is selected,",
                "destroy joker to the right",
                "and add its sell value",
                "to this Joker's {X:mult,C:white}XMult",
                "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
            }
        },
        j_hpr_ascendant = {
            name = "S024 ASCENDANT",
            text = {
                "All {C:attention}played{} and {C:attention}held in hand{} cards gain",
                "{X:mult,C:white}X#1#{} Mult respective to their {C:attention}area"
            }
        },
        j_hpr_mimic = {
            name = "S025 MIMIC",
            text = {
                "{C:attention}Retriggers{} adjacent jokers"
            }
        },
        j_hpr_lucky = {
            name = "S026 LUCKY",
            text = {
                "{C:green,E:1}Probabilities{} on {C:attention}Blinds{} are {C:attention}nullified",
                "When a {C:green,E:1}probability{} rolls for a card,",
                "it permanently gains {C:green}+#1# {C:attention}listed",
                "{C:green,E:1}numerators{} and {C:green,E:1}denominators",
                "{s:1.2,C:hpr_super_gay,E:1}Luck is on your side"
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
        j_hpr_joker_versus = {
            name = "Joker Versus",
            text = {
                "First scoring {C:attention}3",
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
        j_hpr_recycle = {
            name = "S027 RECYCLE",
            text = {
                "When hand is played, this",
                "Joker gains {X:mult,C:white}X#2#{} Mult for",
                "each remaining {C:red}discard",
                "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
            }
        },
        j_hpr_fast_growing = {
            name = "S028 FAST-GROWING",
            text = {
                "All {C:chips}+Chips{} and {C:mult}+Mult{} effects are converted",
                "to {X:chips,C:white}XChips{} and {X:mult,C:white}XMult{} at {C:attention}1+#1#X{} the amount",
                "{X:dark_edition,C:white}X#2#{} all other {C:chips}Chips{} and {C:mult}Mult{} effects",
                "Increases by {X:dark_edition,C:white}X#3#{} at the end of round"
            }
        },
        j_hpr_voucherman = {
            name = "Voucherman",
            text = {
                "{C:attention}Permanently{} increase a",
                "random stat when any",
                "{C:attention}Voucher{} is redeemed",
                "Creates a {C:attention}Voucher Tag",
                "at the end of round"
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
        },
        undiscovered_hpr_prophecy = {
            name = "Not Discovered",
            text = {
                "Purchase or use",
                "this card in an",
                "unseeded run to",
                "learn what it does"
            }
        },
        hpr_negative_seal = {
            name = "Negative Seal",
            text = {
                "Temporary {C:dark_edition}+1{} Hand Size",
                "when scored"
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
                "its {C:hpr_stellar,E:1}Stellar{} counterpart"
            }
        },
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
                "an {T:c_hpr_ascender,C:spectral}#1#{} card"
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
    hpr_prophecy = {
        c_hpr_tome = {
            name = "Tome",
            text = {
                "Creates a {C:attention}Rental{} copy",
                "of a random {C:attention}Joker",
                "Permanently increases",
                "{C:attention}Rental{} cost by {C:red}$#1#",
                "{C:inactive}(Must have room)"
            }
        },
        c_hpr_ignorance = {
            name = "Ignorance",
            text = {
                "Creates {C:attention}#1# Eternal",
                "{C:attention}Consumables{} of the last",
                "used {C:attention}Consumable Type",
                "{C:inactive}Currently: {V:1}#1#"
            }
        },
        c_hpr_blessing = {
            name = "Blessing",
            text = {
                "Converts selected cards",
                "to {C:attention}#1#s{}. {C:red}Level down",
                "a random hand for each",
                "selected card",
                "{s:0.8,C:inactive}(Requires enough levels available to remove)"
            }
        },
        c_hpr_divide = {
            name = "Divide",
            text = {
                "Creates {C:dark_edition}Negative {C:attention}Perishable",
                "copies of all your non-",
                "{C:attention}Perishable{} Jokers",
                "All future {C:attention}Perishable",
                "Jokers last {C:attention}1{} less round",
                "{C:inactive}(Minimum of {C:attention}1{C:inactive} round)"
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
        ph_hpr_plarva = "Saved by Pluripotent Larva",
        b_hpr_prophecy_cards = "Corrupted Cards",
        k_hpr_prophecy = "Corrupted",
        k_plus_tag = "+1 Tag",
        k_hpr_awesome = "Awesome",
        k_hpr_plus_shop = "+1 Shop Slot",
        k_hpr_plus_csize = "+1 Consumable Slot",
        k_hpr_plus_hand = "+1 Hand",
        k_hpr_plus_discard = "+1 Discard",
        k_hpr_plus_jsize = "+1 Joker Slot",
        k_hpr_minus_ante = "-1 Ante",
        k_hpr_plus_hsize = "+1 Hand Size",
        k_hpr_green_hands = "+$1 per Hand",
        k_hpr_green_discards = "+$1 per Discard",
        k_hpr_plus_bsize = "+1 Booster Slot",
        k_hpr_plus_vsize = "+1 Voucher Slot",
        k_hpr_plus_csl = "+1 Card Selection Limit",
        k_hpr_plus_reroll = "+1 Free Reroll",
        k_hpr_plus_iamt = "+1 Interest Amount",
        k_hpr_plus_debt = "+$20 Debt Limit",
        k_hpr_plus_consumable = "+1 Consumable"

    },
    high_scores = {},
    labels = {
        hpr_moons = "Moon",
        hpr_diy = "DIY",
        hpr_stellar = "Stellar",
        hpr_prophecy = "Corrupted",
        hpr_negative_seal = "Negative Seal",
        hpr_awesome = "Awesome"
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
