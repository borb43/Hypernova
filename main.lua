HPR = SMODS.current_mod

HPR.erratic_colours = {
    G.C.RED,
    G.C.BLUE,
    G.C.FILTER
}

HPR.erratic_jumbos = {
    "k_large",
    "k_jumbo",
    "k_sizable",
    "k_big",
    "k_wumbo",
    "k_very"
}

HPR.erratic_megas = {
    "k_mega",
    "k_giga",
    "k_giant",
    "k_massive",
    "k_extremely",
    "k_huge"
}

to_big = to_big or function(x) return x end
loc_colour()

SMODS.ObjectType {
    key = "Food",
    default = "j_ice_cream",
    cards = {
        j_gros_michel = true,
        j_egg = true,
        j_ice_cream = true,
        j_cavendish = true,
        j_turtle_bean = true,
        j_diet_cola = true,
        j_popcorn = true,
        j_ramen = true,
        j_selzer = true
    }
}

SMODS.current_mod.optional_features = {
    post_trigger = true
}

SMODS.Atlas {
    key = "placeholder",
    path = "placeholder.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "back",
    path = "back.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "joker",
    path = "joker.png",
    px = 71,
    py = 95
}

if CardSleeves then
    SMODS.Atlas { --placeholder at 0,0
        key = "sleeve",
        path = "sleeve.png",
        px = 73, --did you really have to be 2 pixels wider man
        py = 95
    }
end

assert(SMODS.load_file("lib/extra_tabs.lua"))()
assert(SMODS.load_file("lib/funcs.lua"))()

assert(SMODS.load_file("items/moon.lua"))()
assert(SMODS.load_file("items/booster.lua"))()
assert(SMODS.load_file("items/common.lua"))()
assert(SMODS.load_file("items/uncommon.lua"))()
assert(SMODS.load_file("items/rare.lua"))()
assert(SMODS.load_file("items/legendary.lua"))()
assert(SMODS.load_file("items/back.lua"))()
assert(SMODS.load_file("items/voucher.lua"))()

if CardSleeves then
    assert(SMODS.load_file("crossmod/sleeve.lua"))()
end