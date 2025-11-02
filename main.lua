HPR = SMODS.current_mod

HPR.calculate = function(self, context)
    if context.post_trigger then
        if context.other_card or context.card then
            local other_ret = context.other_ret.jokers
            local trigger_card = (context.other_context.other_card or context.other_context.card)
            if trigger_card and trigger_card:get_hpr_eff_mod() then
                HPR.manipulate_ret(other_ret, trigger_card:get_hpr_eff_mod())
            end
        end
    end
end

HPR.set_ability_reset_keys = function ()
    return {
        "moon_bonus", "moon_h_chips", "moon_mult", "moon_h_mult",
        "moon_x_chips", "moon_h_x_chips", "moon_x_mult", "moon_h_x_mult",
        "moon_p_dollars", "moon_h_dollars", "moon_repetitions", "moon_eff_mod",
        "moon_entr_plus_asc", "moon_entr_asc", "moon_entr_exp_asc",
        "moon_entr_h_plus_asc", "moon_entr_h_asc", "moon_entr_h_exp_asc",
        "akyrs_moon_score", "akyrs_moon_h_score"
    }
end

local mod_path = HPR.path

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

SMODS.Atlas {
    key = "moons",
    path = "moon.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "voucher",
    path = "voucher.png",
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

--Load Library Files
local files = NFS.getDirectoryItems(mod_path .. "lib")
for _, file in ipairs(files) do
	print("[HYPERNOVA] Loading library file " .. file)
	local f, err = SMODS.load_file("lib/" .. file)
	if err then
		error(err) --Steamodded actually does a really good job of displaying this info! So we don't need to do anything else.
	end
	f()
end

assert(SMODS.load_file("items/moon.lua"))()
assert(SMODS.load_file("items/booster.lua"))()
assert(SMODS.load_file("items/misc_joker.lua"))()
assert(SMODS.load_file("items/legendary.lua"))()
assert(SMODS.load_file("items/stellar.lua"))()
assert(SMODS.load_file("items/back.lua"))()
assert(SMODS.load_file("items/voucher.lua"))()

if CardSleeves then
    assert(SMODS.load_file("crossmod/sleeve.lua"))()
end
