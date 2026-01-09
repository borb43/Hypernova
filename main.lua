HPR = SMODS.current_mod

HPR.calculate = function(self, context)
    if context.using_consumeable or context.hpr_using_joker then
        local c = context.consumeable or context.hpr_used_j
        G.E_MANAGER:add_event(Event{
            func = function ()
                G.GAME.hpr_ignorance_card = c.ability.set
                return true
            end
        })
    end
    if context.before then
        for _, c in ipairs(context.full_hand) do
            if not c.debuff then
                c.ability.hpr_times_played = c.ability.hpr_times_played + 1
            end
        end
    end
end

HPR.post_load = function ()
    if Entropy and G.FUNCS.use_joker then
        local use_j_ref = G.FUNCS.use_joker
        function G.FUNCS.use_joker(e)
            use_j_ref(e)
            SMODS.calculate_context({
                hpr_using_joker = true,
                hpr_used_j = e.config.ref_table
            })
        end
    end
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
to_number = to_number or function(x) return x end
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
    post_trigger = true,
    retrigger_joker = true
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

SMODS.Atlas {
    key = "enhancers",
    path = "enhancers.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "stellar",
    path = "stellar.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "blind_chip",
    path = "blind.png",
    atlas_table = "ANIMATION_ATLAS",
    frames = 21,
    px = 34,
    py = 34
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

assert(SMODS.load_file("items/modifier.lua"))()
assert(SMODS.load_file("items/prophecy.lua"))()
assert(SMODS.load_file("items/moon.lua"))()
assert(SMODS.load_file("items/booster.lua"))()
assert(SMODS.load_file("items/misc_joker.lua"))()
assert(SMODS.load_file("items/legendary.lua"))()

if next(SMODS.find_mod("entr")) then
    assert(SMODS.load_file("crossmod/rlegendary.lua"))()
end

assert(SMODS.load_file("items/stellar.lua"))()
assert(SMODS.load_file("items/awesome.lua"))()
assert(SMODS.load_file("items/back.lua"))()
assert(SMODS.load_file("items/blind.lua"))()
assert(SMODS.load_file("items/voucher.lua"))()
assert(SMODS.load_file("crossmod/xmod_moons.lua"))()

if CardSleeves then
    assert(SMODS.load_file("crossmod/sleeve.lua"))()
end