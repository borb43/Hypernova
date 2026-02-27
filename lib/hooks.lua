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
				if badges[i].nodes[1].nodes[2].config.object.string == HPR.display_name then --for SOME reason this works now
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
	if G.GAME.used_vouchers and G.GAME.used_vouchers.v_hpr_samples and self.area and self.area.type == "shop" and not self.ability.hpr_samples_triggered then
		self.ability.hpr_samples_triggered = true
		if pseudorandom("hpr_samples") < 0.3 then
			self.ability.couponed = true
		end
	end
    set_cost_ref(self)
    if next(SMODS.find_card("j_hpr_master")) then
        local y = false
        y = self.ability.set == "Booster" or not not SMODS.ConsumableTypes[self.ability.set]
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
	if G.GAME.hpr_cost_reduction then
		self.cost = self.cost - G.GAME.hpr_cost_reduction
	end
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
	--[[
	if HPR.findany(key, "mult", "chip", "dollar") and not effect.hpr_no_mod then
		amount = amount * (scored_card.ability.perma_eff_mod + 1)
		if key == "dollars" or key == "p_dollars" or key == "h_dollars" then amount = math.floor(amount) end
	end
	]]
	return scie(effect, scored_card, key, amount, from_edition)
end

local score_card_ref = SMODS.score_card
function SMODS.score_card(card, context)
	if not G.scorehand and context.cardarea == G.hand and next(SMODS.find_card("j_hpr_storm")) then
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

local is_eternal_ref = SMODS.is_eternal
function SMODS.is_eternal(card, trigger)
	if card.ability.consumeable and card.ability.eternal then return true end
	return is_eternal_ref(card, trigger)
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
		local eff = effects[i] and effects[i].jokers
		while eff do
			if eff.repetitions then
				for _ = 1, eff.repetitions do
					local new_res = prob_ref(trigger_obj, seed, base_numerator, base_denominator, identifier, no_mod)
					card_eval_status_text(eff.message_card or eff.card or trigger_obj, "extra", nil, nil, nil, { message = eff.message or localize("k_again_ex"), colour = eff.colour or G.C.GREEN })
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

local end_round_ref = end_round
function end_round()
	if G.GAME.blind and G.GAME.blind.config and G.GAME.blind.config.blind.hpr_next_phase and G.GAME.chips >= G.GAME.blind.chips then
		G.GAME.chips = 0
		G.GAME.round_resets.lost = true
		G.GAME.blind:set_blind(G.P_BLINDS[G.GAME.blind.config.blind.hpr_next_phase])
		G.E_MANAGER:add_event(Event{
			func = function ()
				HPR.reset_blind()
				return true
			end
		})
	else
		for _, c in ipairs(G.I.CARD) do if c.ability then c.ability.hpr_played_this_round = nil end end
		end_round_ref()
	end
end
-- one million anti changing the blind measures
reroll_boss_but_ref = G.FUNCS.reroll_boss_button
function G.FUNCS.reroll_boss_button(e)
	reroll_boss_but_ref(e)
	local bl_key = G.GAME.round_resets.blind_choices.Boss
	if bl_key and G.P_BLINDS[bl_key] and G.P_BLINDS[bl_key].hpr_no_avoid then
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
		e.children[1].children[1].config.shadow = false
		if e.children[2] then e.children[2].children[1].config.shadow = false end
	end
end

reroll_boss_ref = G.FUNCS.reroll_boss
function G.FUNCS.reroll_boss(e)
	local bl_key = G.GAME.round_resets.blind_choices.Boss
	if bl_key and G.P_BLINDS[bl_key] and G.P_BLINDS[bl_key].hpr_no_avoid then return end
	reroll_boss_ref(e)
end

local disable_ref = Blind.disable
function Blind:disable()
	if not self.config.blind.hpr_no_avoid then disable_ref(self) end
end

local blind_ui_ref = create_UIBox_blind_select
function create_UIBox_blind_select()
	if HPR.should_spawn_superboss() then
		G.GAME.round_resets.blind_choices.Boss = "bl_hpr_true_final_star_p1"
	end
	return blind_ui_ref()
end

local new_boss_ref = get_new_boss
function get_new_boss()
	if HPR.should_spawn_superboss() then return "bl_hpr_true_final_star_p1" end
	return new_boss_ref()
end

local play_ref = G.FUNCS.play_cards_from_highlighted
function G.FUNCS.play_cards_from_highlighted(e)
	if not (G.play and G.play.cards[1]) then
		for i = 1, #G.hand.highlighted do
			G.hand.highlighted[i].ability.hpr_played_this_round = true
		end
	end
	play_ref(e)
end