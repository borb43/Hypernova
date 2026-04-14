local create_card_ref = create_card --hook for applying perma bonuses to cards (for stacking and mass production)
create_card = function(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
	if (next(SMODS.find_card("j_hpr_missing")) or next(SMODS.find_card("j_hpr_apostrophe_m"))) and (SMODS.ConsumableTypes[_type] or _type == "Tarot_Planet") then
		_type = "Consumeables"
	end
	if G.GAME.used_vouchers.v_hpr_void_cradle and _type == "Tarot" and key_append ~= "ar1" and not forced_key and pseudorandom("hpr_void_cradle") < 0.2 then
		_type = "Spectral"
	end
	if G.GAME.used_vouchers.v_hpr_astrology and (_type == "Planet" or _type == "Tarot") and not forced_key then
		_type = "Tarot_Planet"
	end
	if G.GAME.used_vouchers.v_hpr_magician and _type == "Default" and area and (area.config.type == "shop" or area == G.pack_cards) then
		set = "Enhanced"
	end
    local ret_card = create_card_ref(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    HPR.post_create_card(ret_card, area, soulable, key_append)
    return ret_card
end
--#region card credits
local smcmb = SMODS.create_mod_badges
function SMODS.create_mod_badges(obj, badges)
	smcmb(obj, badges)
	if not SMODS.config.no_mod_badges and obj and type(obj.hpr_badge_info) == "table" then
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
		if next(obj.hpr_badge_info) then
			local scale_fac = {}
			local min_scale_fac = 1
			local strings = { HPR.display_name }
			for _, v in ipairs(obj.hpr_badge_info) do
				if v.key and v.vars then
					local str = localize({ type = "variable", key = v.key, vars = v.vars })
					strings[#strings + 1] = (type(str) == "table" and str[1]) or str
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
										colours = { G.C.WHITE },
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
			for i = 1, #badges do
				if badges[i].nodes[1].config.colour == HPR.badge_colour then
					badges[i].nodes[1].nodes[2].config.object:remove()
					badges[i] = hpr_badge
					break
				end
			end
		end
	end
end
--#endregion

local level_up_handref = level_up_hand
function level_up_hand(card, hand, instant, amount)
	amount = amount or 1
	amount = amount * (3 ^ #SMODS.find_card("j_hpr_final_mist"))
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

local upgrade_hands_ref = SMODS.upgrade_poker_hands
function SMODS.upgrade_poker_hands(args)
	upgrade_hands_ref(args)
	if args.func then
		local hands = type(args.hands) == "table" and args.hands or {args.hands}
		for _, hand in ipairs(hands) do
			SMODS.calculate_context{
				hpr_other_modify_hand = true,
				parameters = args.parameters or SMODS.Scoring_Parameter.obj_buffer,
				instant = args.instant,
				func = args.func,
				other_card = args.from,
				levels = type(args.level_up)=="number" and args.level_up or args.level_up and 1 or 0,
				hand_type = hand,
			}
		end
	end
end

local set_cost_ref = Card.set_cost
function Card:set_cost()
	if self.area and self.area.type == "shop" and not self.ability.hpr_samples_triggered then
		self.ability.hpr_samples_triggered = true
		if G.GAME.used_vouchers and G.GAME.used_vouchers.v_hpr_samples and pseudorandom("hpr_samples") < 0.3 then
			self.ability.couponed = true
		end
	end
    set_cost_ref(self)
	if G.GAME.hpr_cost_reduction then
		self.cost = self.cost - G.GAME.hpr_cost_reduction
	end
	if self.ability.hpr_no_value then
		self.sell_cost = 0 + (self.ability.extra_value or 0)
	else
		self.sell_cost = math.max(1, math.floor(self.cost / 2)) + (self.ability.extra_value or 0)
	end
	self.sell_cost_label = self.facing == 'back' and '?' or self.sell_cost
end

local scie = SMODS.calculate_individual_effect
function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
	if HPR.findany(key, "mult", "chip") and not effect.hpr_no_mod then
		for _, c in ipairs(SMODS.find_card("j_hpr_growth")) do
			amount = amount * c.ability.extra.eff_mod
		end
		if next(SMODS.find_card("j_hpr_antiderivative")) and string.find(key, "mult") and not HPR.findany(key:lower(), "x", "e") then
			local multi = 0
			for _, c in ipairs(SMODS.find_card("j_hpr_antiderivative")) do
				multi = math.max(multi, c.ability.extra)
			end
			if key == "h_mult" then key = "mult" end
			key = key:gsub("mult", "x_mult")
			amount = 1 + amount*multi
		end
		for _, c in ipairs(SMODS.find_card("j_hpr_derivative")) do
			if HPR.findany(key, "X", "x") and key:find("mult") and not key:find("xlog") and c.ability.extra.active then
				key = key:gsub("x_", "")
				key = key:gsub("X", "")
				key = key:gsub("x", "")
				amount = amount * c.ability.extra.multiplier
				c.ability.extra.active = false
				break
			end
		end
	end
	return scie(effect, scored_card, key, amount, from_edition)
end

local score_card_ref = SMODS.score_card
function SMODS.score_card(card, context)
	if not G.scorehand and context.cardarea == G.hand and (next(SMODS.find_card("j_hpr_storm")) or next(SMODS.get_enhancements(card) or {}) and next(SMODS.find_card("j_hpr_final_splash"))) then
		G.scorehand = true
		context.cardarea = G.play
		SMODS.score_card(card, context)
		G.scorehand = nil
		context.cardarea = G.hand
	end
	if not G.scorehand and context.cardarea == "unscored" and G.GAME.used_vouchers.v_hpr_magic_wand then
		G.scorehand = true
		context.cardarea = G.hand
		SMODS.score_card(card, context)
		G.scorehand = nil
		context.cardarea = "unscored"
	end
	return score_card_ref(card, context)
end

local fingies_ref = SMODS.four_fingers
function SMODS.four_fingers(hand_type)
	local results = {}
	local fingers = SMODS.find_card("j_hpr_butterfinger")
	if next(fingers) then
		local min = math.huge
		for _, c in ipairs(fingers) do
			min = math.min(c.ability.extra, min)
		end
		results[#results+1] = min
	end
	if next(SMODS.find_card("j_hpr_shorthand")) then
		results[#results+1] = 3
	end
	return math.min(fingies_ref(hand_type), unpack(results))
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
--[[
local is_eternal_ref = SMODS.is_eternal
function SMODS.is_eternal(card, trigger)
	if card.ability.consumeable and card.ability.eternal then return true end
	return is_eternal_ref(card, trigger)
end
]]
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
		local eff = effects[i] and effects[i].jokers
		while eff do
			if eff.repetitions then
				for _ = 1, eff.repetitions do
					local new_res = prob_ref(trigger_obj, seed, base_numerator, base_denominator, identifier, no_mod)
					if not eff.no_message then card_eval_status_text(eff.message_card or eff.card or trigger_obj, "extra", nil, nil, nil, { message = eff.message or localize("k_again_ex"), colour = eff.colour or G.C.GREEN }) end
					res = res or new_res
				end
			else
				sendWarnMessage("Found effect table during repetition check with no assigned repetitions", "Hypernova")
			end
			eff = eff.extra
		end
	end
	return res
end

local inj = SMODS.injectItems
function SMODS.injectItems(...)
	inj(...)
	HPR.post_load()
end

local ed = poll_edition
function poll_edition(_key, _mod, _no_neg, _guaranteed, _options)
	_mod = _mod or 1
	_mod = _mod * (G.GAME.hpr_edition_rate or 1)
	return ed(_key, _mod, _no_neg, _guaranteed, _options)
end

HPR.consts.green_mult = 0.95
local gba = get_blind_amount
function get_blind_amount(ante)
	local base = gba(ante)
	local mult = 1
	if G.GAME.hpr_stasis then
		mult = mult * G.GAME.hpr_stasis^(G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante)
	end
	return math.floor(base * mult)
end

local shatter_ref = SMODS.shatters
function SMODS.shatters(card)
	if card.hpr_force_shatter or card.config.center.key == "j_hpr_ceramic" or card.config.center.key == "j_hpr_fine_china" then
		return true
	end
	return shatter_ref(card)
end

local needs_pull_ref = Spectrallib.needs_pull_button
function Spectrallib.needs_pull_button(card)
	if HPR.can_pull(card) and SMODS.OPENED_BOOSTER.config.center.kind == "hpr_erratic" and G.GAME.used_vouchers.v_hpr_order_chaos and (card.ability.consumeable or card.ability.set == "Voucher") then
		return localize("b_hpr_take")
	end
	return needs_pull_ref(card)
end
local can_pull_ref = Spectrallib.can_be_pulled
function Spectrallib.can_be_pulled(card)
	if HPR.can_pull(card) and SMODS.OPENED_BOOSTER.config.center.kind == "hpr_erratic" and G.GAME.used_vouchers.v_hpr_order_chaos and (card.ability.consumeable or card.ability.set == "Voucher") then
		return true
	end
	return can_pull_ref(card)
end

local no_rank_ref = SMODS.has_no_rank
function SMODS.has_no_rank(card)
	if next(SMODS.find_card("j_hpr_eris")) then
		return false
	end
	return no_rank_ref(card)
end

local no_suit_ref = SMODS.has_no_suit
function SMODS.has_no_suit(card)
	if next(SMODS.find_card("j_hpr_eris")) then
		return false
	end
	return no_suit_ref(card)
end

local get_id_ref = Card.get_id
function Card:get_id()
	if next(SMODS.find_card("j_hpr_eris")) and HPR.base_rankless(self) and G.GAME.hpr_eris_card and G.GAME.hpr_eris_card.id then
		local old_id = self.base.id
		self.base.id = G.GAME.hpr_eris_card.id
		local res = get_id_ref(self)
		self.base.id = old_id
		return res
	end
	return get_id_ref(self)
end

local is_suit_ref = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
	if next(SMODS.find_card("j_hpr_eris")) and HPR.base_suitless(self) and G.GAME.hpr_eris_card and G.GAME.hpr_eris_card.suit then
		local old_suit = self.base.suit
		self.base.suit = G.GAME.hpr_eris_card.suit
		local res = is_suit_ref(self, suit, bypass_debuff, flush_calc)
		self.base.suit = old_suit
		return res
	end
	return is_suit_ref(self, suit, bypass_debuff, flush_calc)
end

local any_suit_ref = SMODS.has_any_suit
function SMODS.has_any_suit(card)
	if next(SMODS.find_card("j_hpr_ashes")) and card:get_id() == 14 then
		return true
	end
	return any_suit_ref(card)
end