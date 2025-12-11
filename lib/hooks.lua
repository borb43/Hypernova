local create_card_ref = create_card --hook for applying perma bonuses to cards (for stacking and mass production)
create_card = function(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    local ret_card = create_card_ref(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    if ret_card.ability.set == "Default" or ret_card.ability.set == "Enhanced" then
        if G.GAME and G.GAME.used_vouchers.v_hpr_stacking then
            if pseudorandom("stacking") < 0.5 then ret_card.ability.perma_bonus = (ret_card.ability.perma_bonus or 0) + pseudorandom("stacking_buff", 10, 60) end
            if pseudorandom("stacking") < 0.5 then ret_card.ability.perma_h_chips = (ret_card.ability.perma_h_chips or 0) + pseudorandom("stacking_buff", 15, 90) end
            if pseudorandom("stacking") < 0.4 then ret_card.ability.perma_mult = (ret_card.ability.perma_mult or 0) + pseudorandom("stacking_buff", 2, 10) end
            if pseudorandom("stacking") < 0.4 then ret_card.ability.perma_h_mult = (ret_card.ability.perma_h_mult or 0) + pseudorandom("stacking_buff", 3, 15) end
        end
        if G.GAME and G.GAME.used_vouchers.v_hpr_massprod then
            if pseudorandom("stacking") < 0.25 then ret_card.ability.perma_x_chips = (ret_card.ability.perma_x_chips or 1) + (pseudorandom("stacking_buff", 1, 10)/10) end
            if pseudorandom("stacking") < 0.25 then ret_card.ability.perma_h_x_chips = (ret_card.ability.perma_h_x_chips or 1) + (pseudorandom("stacking_buff", 1, 10)/10) end
            if pseudorandom("stacking") < 0.25 then ret_card.ability.perma_x_mult = (ret_card.ability.perma_x_mult or 1) + (pseudorandom("stacking_buff", 1, 10)/10) end
            if pseudorandom("stacking") < 0.25 then ret_card.ability.perma_h_x_mult = (ret_card.ability.perma_h_x_mult or 1) + (pseudorandom("stacking_buff", 1, 10)/10) end
        end
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
		if obj.hpr_credits.art or obj.hpr_credits.code or obj.hpr_credits.idea or obj.hpr_credits.custom then
			local scale_fac = {}
			local min_scale_fac = 1
			local strings = { HPR.display_name }
			for _, v in ipairs({ "idea", "art", "code" }) do
				if obj.hpr_credits[v] then
					if type(obj.hpr_credits[v]) == "string" then obj.hpr_credits[v] = {obj.hpr_credits[v]} end
					for i = 1, #obj.hpr_credits[v] do
						strings[#strings + 1] =
							localize({ type = "variable", key = "cry_" .. v, vars = { obj.hpr_credits[v][i] } })[1]
					end
				end
			end
            if obj.hpr_credits.custom then
                strings[#strings + 1] = localize({ type="variable", key = obj.hpr_credits.custom.key, vars = { obj.hpr_credits.custom.text } })
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
			for i = 1, #badges do	
				if badges[i].nodes[1].nodes[2].config.object.string == HPR.display_name then --this was meant to be a hex code but it just doesnt work for like no reason so its hardcoded
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
