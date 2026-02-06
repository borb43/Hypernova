HPR = SMODS.current_mod
HPR.consts = {}

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
    --[[
    if Entropy and G.FUNCS.use_joker then
        local use_j_ref = G.FUNCS.use_joker
        function G.FUNCS.use_joker(e)
            use_j_ref(e)
            SMODS.calculate_context({
                hpr_using_joker = true,
                hpr_used_j = e.config.ref_table
            })
        end
    end]]
    -- center function hooks
    for _, c in pairs(G.P_CENTERS) do
        if c.pools and c.pools.wee then
            local ref = c.set_badges
            c.set_badges = function (self, card, badges)
                if ref then ref(self, card, badges) end
                if self.discovered then
                    badges[#badges+1] = create_badge(localize("k_hpr_wee"), G.C.HPR_WEE, G.C.WHITE, 1)
                end
            end
        end
    end
    local ref = G.P_CENTERS.e_negative.get_weight
    G.P_CENTERS.e_negative.get_weight = function (self)
        local base_weight = ref and ref(self) or self.weight
        return base_weight * (G.GAME.hpr_negative_mod or 1)
    end
    -- engulf functions
    if next(SMODS.find_mod("enf")) and Engulf then
        Engulf.EditionFuncs["e_hpr_green"] = function (card, hand, instant, amount, edition, cosmetic)
            if not cosmetic then
                G.GAME.hands[hand].mult = G.GAME.hands[hand].mult + (edition.extra.green * amount)
            end
            if (not instant) or Engulf.config.verbose then
                G.E_MANAGER:add_event(Event{trigger = "after", delay = 0.4, func = function ()
                    play_sound("multhit1")
                    if card then card:juice_up(0.8, 0.5) end
                return true end})
                Engulf.hm((edition.extra.green > 0 and "+" or "-")..number_format(math.abs(edition.extra.green*amount)), true)
                delay(0.2)
                Engulf.hm(number_format(G.GAME.hands[hand].mult), false)
                delay(0.7)
            end
        end
    end
end

HPR.post_create_card = function (card, area, soulable, key_append)
    if (card.ability.set == "Default" or card.ability.set == "Enhanced") and area and (area.config.type == "shop" or area == G.pack_cards) then
        if G.GAME and G.GAME.used_vouchers.v_hpr_stacking then
            if pseudorandom("hpr_stacking") < 0.5 then card.ability.perma_bonus = card.ability.perma_bonus + pseudorandom("hpr_stacking_buff"..(key_append or ""), 10, 60) end
            if pseudorandom("hpr_stacking") < 0.5 then card.ability.perma_h_chips = card.ability.perma_h_chips + pseudorandom("hpr_stacking_buff"..(key_append or ""), 15, 90) end
            if pseudorandom("hpr_stacking") < 0.4 then card.ability.perma_mult = card.ability.perma_mult + pseudorandom("hpr_stacking_buff"..(key_append or ""), 2, 10) end
            if pseudorandom("hpr_stacking") < 0.4 then card.ability.perma_h_mult = card.ability.perma_h_mult + pseudorandom("hpr_stacking_buff"..(key_append or ""), 3, 15) end
        end
        if G.GAME and G.GAME.used_vouchers.v_hpr_massprod then
            if pseudorandom("hpr_stacking2") < 0.25 then card.ability.perma_x_chips = card.ability.perma_x_chips + (pseudorandom("hpr_stacking_buff2"..(key_append or ""), 1, 10)/10) end
            if pseudorandom("hpr_stacking2") < 0.25 then card.ability.perma_h_x_chips = card.ability.perma_h_x_chips + (pseudorandom("hpr_stacking_buff2"..(key_append or ""), 1, 10)/10) end
            if pseudorandom("hpr_stacking2") < 0.25 then card.ability.perma_x_mult = card.ability.perma_x_mult + (pseudorandom("hpr_stacking_buff2"..(key_append or ""), 1, 10)/10) end
            if pseudorandom("hpr_stacking2") < 0.25 then card.ability.perma_h_x_mult = card.ability.perma_h_x_mult + (pseudorandom("hpr_stacking_buff2"..(key_append or ""), 1, 10)/10) end
        end
        if G.GAME and G.GAME.used_vouchers.v_hpr_falsified then
            if pseudorandom("hpr_stacking3") < 0.2 then card.ability.perma_repetitions = card.ability.perma_repetitions + 1 end
        end
        if G.GAME and G.GAME.used_vouchers.v_hpr_fool_gold then
            if pseudorandom("hpr_stacking4") < 0.2 then card.ability.perma_h_dollars = card.ability.perma_h_dollars + pseudorandom("hpr_stacking_buff4"..(key_append or ""),1,6) end
            if pseudorandom("hpr_stacking4") < 0.2 then card.ability.perma_p_dollars = card.ability.perma_p_dollars + pseudorandom("hpr_stacking_buff4"..(key_append or ""),1,4) end
        end
    end
    if card.ability.consumeable and G.GAME.modifiers.hpr_neg_consumable_rate and pseudorandom((key_append or "").."neg_consumable_deck") < G.GAME.modifiers.hpr_neg_consumable_rate then
		card:set_edition("e_negative")
	end
    if area and G.GAME.used_vouchers.v_hpr_graviton and (area.config.type == "shop" or area == G.pack_cards) and card.is_rarity and card:is_rarity(1) and pseudorandom((key_append or "").."hpr_graviton") < 0.05 then
        card:set_edition("e_negative")
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

G.C.HPR_ULTRAGREEN = {0, 1, 0, 1}
G.C.HPR_STLR = HEX("1F0D35")
G.C.HPR_WEE = HEX("60c4a5")
G.C.HPR_BALANCE = {0.8, 0.45, 0.85, 1}
G.ARGS.LOC_COLOURS.hpr_ultragreen = G.C.HPR_ULTRAGREEN
G.ARGS.LOC_COLOURS.hpr_balance = G.C.HPR_BALANCE

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

SMODS.ObjectType {
    key = "wee",
    default = "j_wee",
    cards = {
        j_wee = true
    }
}

SMODS.current_mod.optional_features = {
    --post_trigger = true,
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

SMODS.Atlas {
    key = "consumable",
    path = "misc_consumable.png",
    px = 71,
    py = 95,
}

SMODS.Atlas {
    key = "booster",
    path = "booster.png",
    px = 71,
    py = 95,
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
assert(SMODS.load_file("items/consumable.lua"))()
assert(SMODS.load_file("items/booster.lua"))()
assert(SMODS.load_file("items/misc_joker.lua"))()
assert(SMODS.load_file("items/legendary.lua"))()
assert(SMODS.load_file("items/tag.lua"))()

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