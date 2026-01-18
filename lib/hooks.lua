local create_card_ref = create_card --hook for applying perma bonuses to cards (for stacking and mass production)
create_card = function(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
	if next(SMODS.find_card("j_hpr_missing")) and SMODS.ConsumableTypes[_type] then
		_type = "Consumeables"
	end
    local ret_card = create_card_ref(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    if ret_card.ability.set == "Default" or ret_card.ability.set == "Enhanced" then
        if G.GAME and G.GAME.used_vouchers.v_hpr_stacking then
            if pseudorandom("stacking") < 0.5 then ret_card.ability.perma_bonus = (ret_card.ability.perma_bonus or 0) + pseudorandom("stacking_buff"..(key_append or ""), 10, 60) end
            if pseudorandom("stacking") < 0.5 then ret_card.ability.perma_h_chips = (ret_card.ability.perma_h_chips or 0) + pseudorandom("stacking_buff"..(key_append or ""), 15, 90) end
            if pseudorandom("stacking") < 0.4 then ret_card.ability.perma_mult = (ret_card.ability.perma_mult or 0) + pseudorandom("stacking_buff"..(key_append or ""), 2, 10) end
            if pseudorandom("stacking") < 0.4 then ret_card.ability.perma_h_mult = (ret_card.ability.perma_h_mult or 0) + pseudorandom("stacking_buff"..(key_append or ""), 3, 15) end
        end
        if G.GAME and G.GAME.used_vouchers.v_hpr_massprod then
            if pseudorandom("stacking") < 0.25 then ret_card.ability.perma_x_chips = (ret_card.ability.perma_x_chips or 1) + (pseudorandom("stacking_buff"..(key_append or ""), 1, 10)/10) end
            if pseudorandom("stacking") < 0.25 then ret_card.ability.perma_h_x_chips = (ret_card.ability.perma_h_x_chips or 1) + (pseudorandom("stacking_buff"..(key_append or ""), 1, 10)/10) end
            if pseudorandom("stacking") < 0.25 then ret_card.ability.perma_x_mult = (ret_card.ability.perma_x_mult or 1) + (pseudorandom("stacking_buff"..(key_append or ""), 1, 10)/10) end
            if pseudorandom("stacking") < 0.25 then ret_card.ability.perma_h_x_mult = (ret_card.ability.perma_h_x_mult or 1) + (pseudorandom("stacking_buff"..(key_append or ""), 1, 10)/10) end
        end
    end
	if ret_card.ability.consumeable and G.GAME.modifiers.hpr_neg_consumable_rate and pseudorandom((key_append or "").."neg_consumable_deck") < G.GAME.modifiers.hpr_neg_consumable_rate then
		ret_card:set_edition("e_negative")
	end
    return ret_card
end
--#region card credits
local smcmb = SMODS.create_mod_badges
function SMODS.create_mod_badges(obj, badges)
	smcmb(obj, badges)
	if not SMODS.config.no_mod_badges and obj and obj.hpr_credits then
		local function calc_scale_fac(text)
			local size = 0.9
			local font = G.LANG.font
			local max_text_width = 2 - 2 * 0.05 - 4 * 0.03 * size - 2 * 0.03
			local calced_text_width = 0
			-- Math reproduced from DynaText:update_text
			for _, c in utf8.chars(text) do
				local tx = font.FONT:getWidth(c) * (0.33 * size) * G.TILESCALE * font.FONTSCALE
					+ 2.7 * 1 * G.TILESCALE * font.FONTSCALE
				calced_text_width = calced_text_width + tx / (G.TILESIZE * G.TILESCALE)
			end
			local scale_fac = calced_text_width > max_text_width and max_text_width / calced_text_width or 1
			return scale_fac
		end
		if obj.hpr_credits.art or obj.hpr_credits.code or obj.hpr_credits.idea then
			local scale_fac = {}
			local min_scale_fac = 1
			local strings = { HPR.display_name }
			for _, v in ipairs({ "idea", "art", "code" }) do
				if obj.hpr_credits[v] then
					for i = 1, #obj.hpr_credits[v] do
						strings[#strings + 1] =
							localize({ type = "variable", key = "hpr_credits_" .. v, vars = { obj.hpr_credits[v][i] } })[1]
					end
				end
			end
			for i = 1, #strings do
				scale_fac[i] = calc_scale_fac(strings[i])
				min_scale_fac = math.min(min_scale_fac, scale_fac[i])
			end
			local ct = {}
			for i = 1, #strings do
				ct[i] = {
					string = strings[i],
				}
			end
			local hpr_badge = {
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.R,
						config = {
							align = "cm",
							colour = HPR.badge_colour,
							r = 0.1,
							minw = 2 / min_scale_fac,
							minh = 0.36,
							emboss = 0.05,
							padding = 0.03 * 0.9,
						},
						nodes = {
							{ n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
							{
								n = G.UIT.O,
								config = {
									object = DynaText({
										string = ct or "ERROR",
										colours = { obj.hpr_credits and obj.hpr_credits.text_colour or G.C.WHITE },
										silent = true,
										float = true,
										shadow = true,
										offset_y = -0.03,
										spacing = 1,
										scale = 0.33 * 0.9,
									}),
								},
							},
							{ n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
						},
					},
				},
			}
			local function eq_col(x, y)
				for i = 1, 4 do
					if x[i] ~= y[i] then
						return false
					end
				end
				return true
			end
			for i = 1, #badges do
				if eq_col(badges[i].nodes[1].config.colour, HEX("C09ED9")) then
					badges[i].nodes[1].nodes[2].config.object:remove()
					badges[i] = hpr_badge
					break
				end
			end
		end
	end
end
--#endregion
--#region cave painting hooks
local get_id_ref = Card.get_id
function Card:get_id()
	local old_id = self.base.id
	if next(SMODS.find_card("j_hpr_cavepaint")) and (G.GAME.current_round.hpr_cavepaint_card or {}).id and SMODS.has_enhancement(self, "m_stone") then
		self.base.id = G.GAME.current_round.hpr_cavepaint_card.id
	end
	local ret = get_id_ref(self)
	self.base.id = old_id
	return ret
end

local is_suit_ref = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
	local old_suit = self.base.suit
	if next(SMODS.find_card("j_hpr_cavepaint")) and (G.GAME.current_round.hpr_cavepaint_card or {}).suit then
		self.base.suit = G.GAME.current_round.hpr_cavepaint_card.suit
	end
	local ret = is_suit_ref(self, suit, bypass_debuff, flush_calc)
	self.base.suit = old_suit
	return ret
end

local no_rank_ref = SMODS.has_no_rank
function SMODS.has_no_rank(card)
	if next(SMODS.find_card("j_hpr_cavepaint")) and (G.GAME.current_round.hpr_cavepaint_card or {}).id and SMODS.has_enhancement(card, "m_stone") then
		return false
	end
	return no_rank_ref(card)
end

local no_suit_ref = SMODS.has_no_suit
function SMODS.has_no_suit(card)
	if next(SMODS.find_card("j_hpr_cavepaint")) and (G.GAME.current_round.hpr_cavepaint_card or {}).suit and SMODS.has_enhancement(card, "m_stone") then
		return false
	end
	return no_suit_ref(card)
end
--#endregion
--[[ menu card, disabled temporarily
local main_menu_ref = Game.main_menu
function Game:main_menu(change_context)
	local ret = main_menu_ref(self, change_context)
	--create the funny card
	local card = create_card_ref("Spectral", G.title_top, nil, nil, true, nil, "c_hpr_pulsar")
	--realign stuff
	G.title_top.T.w = G.title_top.T.w * 1.7675
	G.title_top.T.x = G.title_top.T.x - 0.8
	G.title_top:emplace(card)
	--card display stuff
	card.T.w = card.T.w * 1.1 * 1.2
	card.T.h = card.T.h * 1.1 * 1.2
	card.children.floating_sprite.T.w = card.children.floating_sprite.T.w * 1.1 * 1.2
	card.children.floating_sprite.T.h = card.children.floating_sprite.T.h * 1.1 * 1.2
	card.no_ui = true
	card.states.visible = false

	--materialize
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 0,
		blockable = false,
		blocking = false,
		func = function ()
			if change_context == "splash" then
				card.states.visible = true
				card:start_materialize({G.C.WHITE, HPR.badge_colour}, true, 2.5)
			else
				card.states.visible = true
				card:start_materialize({G.C.WHITE, HPR.badge_colour}, nil, 1.2)
			end
			return true
		end
	}))

	return ret
end
]]
local level_up_handref = level_up_hand
function level_up_hand(card, hand, instant, amount)
	level_up_handref(card, hand, instant, amount)
	amount = amount or 1
	SMODS.calculate_context({
		hpr_level_up_hand = true,
		other_card = card,
		hand_type = hand,
		instant = instant,
		chips = G.GAME.hands[hand].l_chips * amount,
		mult = G.GAME.hands[hand].l_mult * amount,
		levels = amount
	})
end

local set_cost_ref = Card.set_cost
function Card:set_cost()
    set_cost_ref(self)
    if next(SMODS.find_card("j_hpr_master")) then
        local y = false
        y = self.ability.set == "Booster"
        if not y then
            for _, center in ipairs(G.P_CENTER_POOLS.Consumeables) do
                if center.key == self.config.center.key then y = true end
            end
        end
        if y then
            self.cost = 0
            self.sell_cost = math.max(1, math.floor(self.cost / 2)) + (self.ability.extra_value or 0)
            self.sell_cost_label = self.facing == 'back' and '?' or self.sell_cost
        end
    end
end

local scie = SMODS.calculate_individual_effect
function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
	if HPR.findany(key, "mult", "chip") then
		for _, c in ipairs(SMODS.find_card("j_hpr_growth")) do
			amount = amount * c.ability.extra.eff_mod
		end
		for _, c in ipairs(SMODS.find_card("j_hpr_fast_growing")) do
			if not HPR.findany(key:lower(), "x", "e", "hyper", "eq") then
				if key:find("chips") then key = "x_chips" end
				if key == "chip_mod" then key = "Xchip_mod" end
				if key == "h_mult" then key = "mult" end
				key = key:gsub("mult", "x_mult")
				amount = 1 + amount*c.ability.extra.reduction
			else
				amount = amount * c.ability.extra.buff
			end
		end
		if next(SMODS.find_card("j_hpr_antiderivative")) and string.find(key, "mult") and not HPR.findany(key:lower(), "x", "e", "hyper", "eq") then
			local multi = 0
			for _, c in ipairs(SMODS.find_card("j_hpr_antiderivative")) do
				multi = math.max(multi, c.ability.extra)
			end
			if key == "h_mult" then key = "mult" end
			key = key:gsub("mult", "x_mult")
			amount = 1 + amount*multi
		end
		for _, c in ipairs(SMODS.find_card("j_hpr_derivative")) do
			if HPR.findany(key, "X", "x") and key:find("mult") and c.ability.extra.active then
				key = key:gsub("x_", "")
				key = key:gsub("X", "")
				key = key:gsub("x", "")
				amount = amount * c.ability.extra.multiplier
				c.ability.extra.active = false
				break
			end
		end
	end
	if HPR.findany(key, "mult", "chip", "dollar") then
		amount = amount * (scored_card.ability.perma_eff_mod + 1)
		if string.find(key:lower(), "dollars") then amount = math.floor(amount) end
	end
	return scie(effect, scored_card, key, amount, from_edition)
end

local score_card_ref = SMODS.score_card
function SMODS.score_card(card, context)
	if not G.scorehand and context.cardarea == G.hand and (next(SMODS.find_card("j_hpr_storm")) or SMODS.has_enhancement(card, "m_hpr_alloy") ) then
		G.scorehand = true
		context.cardarea = G.play
		SMODS.score_card(card, context)
		G.scorehand = nil
		context.cardarea = G.hand
	end
	if not G.scorehand and context.cardarea == G.play and SMODS.has_enhancement(card, "m_hpr_alloy") then
		G.scorehand = true
		context.cardarea = G.hand
		SMODS.score_card(card, context)
		G.scorehand = nil
		context.cardarea = G.play
	end
	return score_card_ref(card, context)
end

local fingies_ref = SMODS.four_fingers
function SMODS.four_fingers(hand_type)
	if next(SMODS.find_card("j_hpr_shorthand")) then
		return math.min(3, fingies_ref(hand_type))
	end
	return fingies_ref(hand_type)
end

local x_same_ref = get_X_same
function get_X_same(num, hand, or_more)
	num = num - #SMODS.find_card("j_hpr_shorthand")
	return x_same_ref(num, hand, or_more)
end

local shortcut_ref = SMODS.shortcut
function SMODS.shortcut()
	if next(SMODS.find_card("j_hpr_shorthand")) then return true end
	return shortcut_ref()
end

local wrap_ref = SMODS.wrap_around_straight
function SMODS.wrap_around_straight()
	if next(SMODS.find_card("j_hpr_shorthand")) then return true end
	return wrap_ref()
end

local prob_vars_ref = SMODS.get_probability_vars
function SMODS.get_probability_vars(trigger_obj, base_numerator, base_denominator, identifier, from_roll, no_mod)
	if trigger_obj and trigger_obj.ability and not no_mod then
		base_numerator = base_numerator + (trigger_obj.ability.hpr_num_bonus or 0)
		base_denominator = base_denominator + (trigger_obj.ability.hpr_denom_bonus or 0)
	end
	return prob_vars_ref(trigger_obj, base_numerator, base_denominator, identifier, from_roll, no_mod)
end

local is_eternal_ref = SMODS.is_eternal
function SMODS.is_eternal(card, trigger)
	if card.ability.consumeable and card.ability.eternal then return true end
	return is_eternal_ref(card, trigger)
end

local poll_ed_ref = poll_edition
function poll_edition(_key, _mod, _no_neg, _guaranteed, _options)
	_mod = _mod or 1
	_mod = _mod * (3^#SMODS.find_card("j_hpr_fortune"))
	return poll_ed_ref(_key, _mod, _no_neg, _guaranteed, _options)
end

local prob_ref = SMODS.pseudorandom_probability
function SMODS.pseudorandom_probability(trigger_obj, seed, base_numerator, base_denominator, identifier, no_mod)
	local res = prob_ref(trigger_obj, seed, base_numerator, base_denominator, identifier, no_mod)
	local effects = {}
	SMODS.calculate_context({
		trigger_obj = trigger_obj,
		identifier = identifier or seed,
		hpr_retrigger_probability = true
	}, effects)
	for i = 1, #effects do
		local eff = effects[i]
		if eff and eff.jokers and (eff.jokers.hpr_retriggers or 0) >= 1 then
			for _ = 1, eff.jokers.hpr_retriggers do
				local new_res = prob_ref(trigger_obj, seed, base_numerator, base_denominator, identifier, no_mod)
				card_eval_status_text(eff.jokers.card or trigger_obj, "extra", nil, nil, nil, { message = eff.jokers.message or localize("k_again_ex"), colour = eff.jokers.colour or G.C.GREEN })
				res = res or new_res
			end
		end
	end
	return res
end

local face_ref = Card.is_face
function Card:is_face(from_boss)
	return face_ref(self, from_boss) or SMODS.has_enhancement(self, "m_hpr_mimic")
end

local inj = SMODS.injectItems
function SMODS.injectItems(...)
	inj(...)
	HPR.post_load()
end