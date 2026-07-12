--#region lunar
local lunar_create_card = function (self, card, i)
    return {
        set = "hpr_moons",
        area = G.pack_cards,
        skip_materialize = true,
        soulable = true,
        key_append = "hpr_lunar_pack"
    }
end

local lunar_hallucinations_compat = function (self, caller, args)
    return {
        create_card_args = {
            set = "hpr_moons",
            key_append = "hpr_lunar_pack",
        },
        ret_table = {
            message = localize("k_plus_hpr_moon"),
            colour = G.C.SECONDARY_SET.hpr_moons,
        }
    }
end

SMODS.Booster {
    key = "lunar_normal_1",
    weight = 0.3,
    kind = "hpr_lunar",
    cost = 4,
    atlas = "placeholder",
    pos = { x = 0, y = 3 },
    config = { extra = 2, choose = 1 },
    group_key = "k_lunar_pack",
    loc_vars = function(self, info_queue, card)
        local v = SMODS.Booster.loc_vars(self, info_queue, card) or {vars={}}
        return {
            vars = v.vars,
            key = "p_hpr_lunar_pack"
        }
    end,
    ease_background_colour = function (self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.hpr_moons)
        ease_background_colour({ new_colour = G.C.SECONDARY_SET.hpr_moons, special_colour = G.C.BLACK, contrast = 2 })
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.1,
            initialize = true,
            lifespan = 3,
            speed = 0.2,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.BLUE, G.C.GREY },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = lunar_create_card,
    draw_hand = true,
    dcry_diha_compat = lunar_hallucinations_compat,
}

SMODS.Booster {
    key = "lunar_normal_2",
    weight = 0.3,
    kind = "hpr_lunar",
    cost = 4,
    atlas = "placeholder",
    pos = { x = 0, y = 3 },
    config = { extra = 2, choose = 1 },
    group_key = "k_lunar_pack",
    loc_vars = function(self, info_queue, card)
        local v = SMODS.Booster.loc_vars(self, info_queue, card) or {vars={}}
        return {
            vars = v.vars,
            key = "p_hpr_lunar_pack"
        }
    end,
    ease_background_colour = function (self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.hpr_moons)
        ease_background_colour({ new_colour = G.C.SECONDARY_SET.hpr_moons, special_colour = G.C.BLACK, contrast = 2 })
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.1,
            initialize = true,
            lifespan = 3,
            speed = 0.2,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.BLUE, G.C.GREY },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = lunar_create_card,
    draw_hand = true,
    dcry_diha_compat = lunar_hallucinations_compat,
}

SMODS.Booster {
    key = "lunar_jumbo_1",
    weight = 0.3,
    kind = "hpr_lunar",
    cost = 6,
    atlas = "placeholder",
    pos = { x = 1, y = 3 },
    config = { extra = 4, choose = 1 },
    group_key = "k_lunar_pack",
    loc_vars = function(self, info_queue, card)
        local v = SMODS.Booster.loc_vars(self, info_queue, card) or {vars={}}
        return {
            vars = v.vars,
            key = "p_hpr_lunar_pack_jumbo"
        }
    end,
    ease_background_colour = function (self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.hpr_moons)
        ease_background_colour({ new_colour = G.C.SECONDARY_SET.hpr_moons, special_colour = G.C.BLACK, contrast = 2 })
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.1,
            initialize = true,
            lifespan = 3,
            speed = 0.2,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.BLUE, G.C.GREY },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = lunar_create_card,
    draw_hand = true,
    dcry_diha_compat = lunar_hallucinations_compat,
}

SMODS.Booster {
    key = "lunar_mega_1",
    weight = 0.07,
    kind = "hpr_lunar",
    cost = 8,
    atlas = "placeholder",
    pos = { x = 2, y = 3 },
    config = { extra = 4, choose = 2 },
    group_key = "k_lunar_pack",
    loc_vars = function(self, info_queue, card)
        local v = SMODS.Booster.loc_vars(self, info_queue, card) or {vars={}}
        return {
            vars = v.vars,
            key = "p_hpr_lunar_pack_mega"
        }
    end,
    ease_background_colour = function (self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.hpr_moons)
        ease_background_colour({ new_colour = G.C.SECONDARY_SET.hpr_moons, special_colour = G.C.BLACK, contrast = 2 })
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.1,
            initialize = true,
            lifespan = 3,
            speed = 0.2,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.BLUE, G.C.GREY },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = lunar_create_card,
    draw_hand = true,
    dcry_diha_compat = lunar_hallucinations_compat,
}
--#endregion
--#region erratic packs
SMODS.Gradient {
    key = "erratic_col",
    colours = {
        HEX("FDA200"),
        HEX("FE5F55"),
        HEX("009CFD")
    },
    interpolation = "linear"
}

local erratic_create_card = function (self, card, i)
    --[[
    if i == 1 and G.GAME.used_vouchers.v_hpr_master_chaos then
        local key, count = "c_fool", -1
        for k, v in pairs(G.GAME.consumeable_usage or {}) do
            if v.count > count then
                key = k
                count = v.count
            end
        end
        return {
            set = "Consumeables",
            area = G.pack_cards,
            key_append = "hpr_erratic_card2",
            skip_materialize = true,
            key = key
        }
    end
    ]]
    local sets = { "Consumeables", "Joker", "Playing Card", }
    local rare_sets = { "Voucher", }
    if G.GAME.used_vouchers.v_hpr_recursion then
        sets[#sets+1] = "Booster"
    end
    local set = "Joker"
    if pseudorandom("hpr_erratic_voucher") < 0.1 then
        set = pseudorandom_element(rare_sets, "hpr_erratic")
    else
        set = pseudorandom_element(sets, "hpr_erratic")
    end
    return {
        set = set,
        seal = set == "Playing Card" and SMODS.poll_seal{type_key = "hpr_erratic_seal"} or nil,
        edition = set == "Playing Card" and SMODS.poll_edition{type_key = "hpr_erratic_edition"} or nil,
        skip_materialize = true,
        soulable = true,
        area = G.pack_cards,
        key_append = "hpr_erratic_card"
    }
end

local erratic_hallucinations_compat = function (self, caller, args)
    local pcards = true
    if args and args.no_playing_card then
        pcards = false
    end
    local sets = {"Consumeables", "Joker",}
    local rare_sets = {"Voucher",}
    if pcards then
        sets[#sets+1] = "Playing Card"
    end
    if G.GAME.used_vouchers.v_hpr_recursion then
        sets[#sets+1] = "Booster"
    end
    local set = "Joker"
    if pseudorandom("hpr_erratic_voucher2") < 0.1 then
        set = pseudorandom_element(rare_sets, "hpr_erratic2")
    else
        set = pseudorandom_element(sets, "hpr_erratic2")
    end
    local area = G.consumeables
    if set == "Playing Card" then
        area = G.deck
    elseif set == "Joker" then
        area = G.jokers
    end
    local msg = "hpr_plus_q"
    if set == "Playing Card" then
        msg = "hpr_plus_pcard"
    elseif set == "Consumeables" then
        msg = "slib_plus_consumable"
    elseif set == "Joker" then
        msg = "k_plus_joker"
    elseif set == "Voucher" then
        msg = "slib_plus_voucher"
    end
    return {
        create_card_args = {
            key_append = "hpr_erratic_card",
            set = set,
            area = area,
            seal = set == "Playing Card" and SMODS.poll_seal{type_key = "hpr_erratic_seal"} or nil,
            edition = set == "Playing Card" and SMODS.poll_edition{type_key = "hpr_erratic_edition"} or nil,
        },
        ret_table = {
            message = localize(msg),
            colour = SMODS.Gradients.hpr_erratic_col,
        },
    }
end

local update_erratic = function (self, dt)
    ease_colour(G.C.DYN_UI.MAIN, SMODS.Gradients.hpr_erratic_col)
    ease_background_colour({ new_colour = SMODS.Gradients.hpr_erratic_col, special_colour = G.C.BLACK, contrast = 2 })
    SMODS.Booster.update_pack(self, dt)
end

SMODS.Booster {
    key = "erratic_normal_1",
    weight = 0.5,
    kind = "hpr_erratic",
    cost = 4,
    atlas = "booster",
    pos = { x = 0, y = 0 },
    config = { extra = 3, choose = 1 },
    group_key = "k_erratic_pack",
    loc_vars = function (self, info_queue, card)
        local v = SMODS.Booster.loc_vars(self, info_queue, card) or {vars={}}
        return {
            vars = v.vars,
            key = "p_hpr_erratic_pack"
        }
    end,
    ease_background_colour = function (self)
        ease_colour(G.C.DYN_UI.MAIN, SMODS.Gradients.hpr_erratic_col)
        ease_background_colour({ new_colour = SMODS.Gradients.hpr_erratic_col, special_colour = G.C.BLACK, contrast = 2 })
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.1,
            initialize = true,
            lifespan = 3,
            speed = 0.2,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.BLUE, G.C.RED, G.C.FILTER, G.C.BLACK },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    update_pack = update_erratic,
    create_card = erratic_create_card,
    pronouns = "any_all",
    dcry_diha_compat = erratic_hallucinations_compat,
    draw_hand = true
}

SMODS.Booster {
    key = "erratic_normal_2",
    weight = 0.5,
    kind = "hpr_erratic",
    cost = 4,
    atlas = "booster",
    pos = { x = 1, y = 0 },
    config = { extra = 3, choose = 1 },
    group_key = "k_erratic_pack",
    loc_vars = function (self, info_queue, card)
        local v = SMODS.Booster.loc_vars(self, info_queue, card) or {vars={}}
        return {
            vars = v.vars,
            key = "p_hpr_erratic_pack"
        }
    end,
    ease_background_colour = function (self)
        ease_colour(G.C.DYN_UI.MAIN, SMODS.Gradients.hpr_erratic_col)
        ease_background_colour({ new_colour = SMODS.Gradients.hpr_erratic_col, special_colour = G.C.BLACK, contrast = 2 })
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.1,
            initialize = true,
            lifespan = 3,
            speed = 0.2,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.BLUE, G.C.RED, G.C.FILTER, G.C.BLACK },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    update_pack = update_erratic,
    create_card = erratic_create_card,
    pronouns = "any_all",
    dcry_diha_compat = erratic_hallucinations_compat,
    draw_hand = true
}

SMODS.Booster {
    key = "erratic_jumbo_1",
    weight = 0.5,
    kind = "hpr_erratic",
    cost = 6,
    atlas = "booster",
    pos = { x = 2, y = 0 },
    config = { extra = 5, choose = 1 },
    group_key = "k_erratic_pack",
    loc_vars = function (self, info_queue, card)
        local v = SMODS.Booster.loc_vars(self, info_queue, card) or {vars={}}
        v.vars[#v.vars+1] = localize(HPR.erratic_jumbos[math.random(1, #HPR.erratic_jumbos)])
        return {
            vars = v.vars,
            key = "p_hpr_erratic_pack_jumbo"
        }
    end,
    ease_background_colour = function (self)
        ease_colour(G.C.DYN_UI.MAIN, SMODS.Gradients.hpr_erratic_col)
        ease_background_colour({ new_colour = SMODS.Gradients.hpr_erratic_col, special_colour = G.C.BLACK, contrast = 2 })
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.1,
            initialize = true,
            lifespan = 3,
            speed = 0.2,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.BLUE, G.C.RED, G.C.FILTER, G.C.BLACK },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    update_pack = update_erratic,
    create_card = erratic_create_card,
    pronouns = "any_all",
    dcry_diha_compat = erratic_hallucinations_compat,
    draw_hand = true
}

SMODS.Booster {
    key = "erratic_mega_1",
    weight = 0.1,
    kind = "hpr_erratic",
    cost = 8,
    atlas = "booster",
    pos = { x = 3, y = 0 },
    config = { extra = 5, choose = 2 },
    group_key = "k_erratic_pack",
    loc_vars = function (self, info_queue, card)
        local v = SMODS.Booster.loc_vars(self, info_queue, card) or {vars={}}
        v.vars[#v.vars+1] = localize(HPR.erratic_megas[math.random(1, #HPR.erratic_jumbos)])
        return {
            vars = v.vars,
            key = "p_hpr_erratic_pack_mega"
        }
    end,
    ease_background_colour = function (self)
        ease_colour(G.C.DYN_UI.MAIN, SMODS.Gradients.hpr_erratic_col)
        ease_background_colour({ new_colour = SMODS.Gradients.hpr_erratic_col, special_colour = G.C.BLACK, contrast = 2 })
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.1,
            initialize = true,
            lifespan = 3,
            speed = 0.2,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.BLUE, G.C.RED, G.C.FILTER, G.C.BLACK },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    update_pack = update_erratic,
    create_card = erratic_create_card,
    pronouns = "any_all",
    dcry_diha_compat = erratic_hallucinations_compat,
    draw_hand = true
}
--#endregion
