HPR = {}
HPR.base_values = {}

to_big = to_big or function(x) return x end
loc_colour()

SMODS.current_mod.optional_features = {
    post_trigger = true
}

SMODS.Atlas {
    key = "placeholder",
    path = "placeholder.png",
    px = 71,
    py = 95
}

assert(SMODS.load_file("items/rare.lua"))()
assert(SMODS.load_file("items/back.lua"))()
assert(SMODS.load_file("items/voucher.lua"))()