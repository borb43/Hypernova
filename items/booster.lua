--#region lunar
local lunar_hallucinations_compat = {
    colour = HEX("5d15d1"),
    loc_key = "hpr_plus_moon",
    create = function ()
        SMODS.add_card{
            set = "hpr_moons",
            area = G.consumeables,
            key_append = "diha",
            edition = 'e_negative'
        }
    end
}

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
        local cfg = (card and card.ability) or self.config or {}
        return {
            vars = { cfg.choose, cfg.extra },
            key = "p_hpr_lunar_pack"
        }
    end,
    ease_background_colour = function (self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SET.hpr_moons)
        ease_background_colour({ new_colour = G.C.SET.hpr_moons, special_colour = G.C.BLACK, contrast = 2 })
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
    create_card = function (self, card, i)
        return {
            set = "hpr_moons",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "hpr_lunar_pack"
        }
    end,
    draw_hand = true,
    cry_digital_hallucinations = lunar_hallucinations_compat
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
        local cfg = (card and card.ability) or self.config or {}
        return {
            vars = { cfg.choose, cfg.extra },
            key = "p_hpr_lunar_pack"
        }
    end,
    ease_background_colour = function (self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SET.hpr_moons)
        ease_background_colour({ new_colour = G.C.SET.hpr_moons, special_colour = G.C.BLACK, contrast = 2 })
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
    create_card = function (self, card, i)
        return {
            set = "hpr_moons",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "hpr_lunar_pack"
        }
    end,
    draw_hand = true,
    cry_digital_hallucinations = lunar_hallucinations_compat
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
        local cfg = (card and card.ability) or self.config or {}
        return {
            vars = { cfg.choose, cfg.extra },
            key = "p_hpr_lunar_pack_jumbo"
        }
    end,
    ease_background_colour = function (self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SET.hpr_moons)
        ease_background_colour({ new_colour = G.C.SET.hpr_moons, special_colour = G.C.BLACK, contrast = 2 })
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
    create_card = function (self, card, i)
        return {
            set = "hpr_moons",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "hpr_lunar_pack"
        }
    end,
    draw_hand = true,
    cry_digital_hallucinations = lunar_hallucinations_compat
}

SMODS.Booster {
    key = "lunar_mega_1",
    weight = 0.07,
    kind = "hpr_lunar",
    cost = 8,
    atlas = "placeholder",
    pos = { x = 0, y = 3 },
    config = { extra = 4, choose = 2 },
    group_key = "k_lunar_pack",
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config or {}
        return {
            vars = { cfg.choose, cfg.extra },
            key = "p_hpr_lunar_pack_mega"
        }
    end,
    ease_background_colour = function (self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SET.hpr_moons)
        ease_background_colour({ new_colour = G.C.SET.hpr_moons, special_colour = G.C.BLACK, contrast = 2 })
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
    create_card = function (self, card, i)
        return {
            set = "hpr_moons",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "hpr_lunar_pack"
        }
    end,
    draw_hand = true,
    cry_digital_hallucinations = lunar_hallucinations_compat
}
--#endregion
--#region erratic packs
SMODS.Gradient {
    key = "erratic_col",
    colours = {
        HEX("FDA200"),
        HEX("FE5F55"),
        HEX("009CFD")
    }
}

HPR.erratic_sets = {
    "Joker", "Playing Card", "Consumeables", "Voucher"
}
if next(SMODS.find_mod("entr")) then
    HPR.erratic_sets[#HPR.erratic_sets+1] = "Back"
    if next(SMODS.find_mod("CardSleeves")) then
        HPR.erratic_sets[#HPR.erratic_sets+1] = "Sleeve"
    end
end

local erratic_hallucinations_compat = {
    colour = SMODS.Gradients.hpr_erratic_col,
    loc_key = "hpr_plus_q",
    create = function ()
        local pool_roll = pseudorandom_element({"Joker", "Playing Card", "Consumeables"}, "hpr_erratic_diha") --idk where to put vouchers so they arent here
        local area
        if pool_roll == "Joker" then area = G.jokers end
        if pool_roll == "Consumeables" then area = G.consumeables end
        if pool_roll == "Playing Card" then area = G.deck end
        SMODS.add_card{
            set = pool_roll,
            area = area,
            edition = 'e_negative',
            key_append = "diha"
        }
    end
}

SMODS.Booster {
    key = "erratic_normal_1",
    weight = 0.5,
    kind = "hpr_erratic",
    cost = 4,
    atlas = "placeholder",
    pos = { x = 0, y = 3 },
    config = { extra = 3, choose = 1 },
    group_key = "k_erratic_pack",
    loc_vars = function (self, info_queue, card)
        local cfg = (card and card.ability) or self.config or {}
        return {
            vars = { cfg.extra, cfg.choose },
            key = "p_hpr_erratic_pack"
        }
    end,
    ease_background_colour = function (self)
        ease_colour(G.C.DYN_UI.MAIN, SMODS.Gradients.hpr_erratic_col)
        ease_background_colour({ new_colour = SMODS.Gradients.hpr_erratic_col, special_colour = G.C.BLACK, contrast = 1 + math.random()*2 })
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
    create_card = function (self, card, i)
        local pool = pseudorandom_element(HPR.erratic_sets, "hpr_erratic")
        return {
            set = pool,
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "hpr_erratic_card",
            seal = pool == "Playing Card" and SMODS.poll_seal({key = "hpr_erratic_seal"}),
            edition = pool == "Playing Card" and SMODS.poll_edition({key = "hpr_erratic_edition"})
        }
    end,
    pronouns = "any_all",
    cry_digital_hallucinations = erratic_hallucinations_compat,
    draw_hand = true
}

SMODS.Booster {
    key = "erratic_normal_2",
    weight = 0.5,
    kind = "hpr_erratic",
    cost = 4,
    atlas = "placeholder",
    pos = { x = 0, y = 3 },
    config = { extra = 3, choose = 1 },
    group_key = "k_erratic_pack",
    loc_vars = function (self, info_queue, card)
        local cfg = (card and card.ability) or self.config or {}
        return {
            vars = { cfg.extra, cfg.choose },
            key = "p_hpr_erratic_pack"
        }
    end,
    ease_background_colour = function (self)
        ease_colour(G.C.DYN_UI.MAIN, SMODS.Gradients.hpr_erratic_col)
        ease_background_colour({ new_colour = SMODS.Gradients.hpr_erratic_col, special_colour = G.C.BLACK, contrast = 1 + math.random()*2 })
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
    create_card = function (self, card, i)
        local pool = pseudorandom_element(HPR.erratic_sets, "hpr_erratic")
        return {
            set = pool,
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "hpr_erratic_card",
            seal = pool == "Playing Card" and SMODS.poll_seal({key = "hpr_erratic_seal"}),
            edition = pool == "Playing Card" and SMODS.poll_edition({key = "hpr_erratic_edition"})
        }
    end,
    pronouns = "any_all",
    cry_digital_hallucinations = erratic_hallucinations_compat,
    draw_hand = true
}

SMODS.Booster {
    key = "erratic_jumbo_1",
    weight = 0.5,
    kind = "hpr_erratic",
    cost = 6,
    atlas = "placeholder",
    pos = { x = 1, y = 3 },
    config = { extra = 5, choose = 1 },
    group_key = "k_erratic_pack",
    loc_vars = function (self, info_queue, card)
        local cfg = (card and card.ability) or self.config or {}
        return {
            vars = { cfg.extra, cfg.choose, localize(HPR.erratic_jumbos[math.random(1, #HPR.erratic_jumbos)]) },
            key = "p_hpr_erratic_pack_jumbo"
        }
    end,
    ease_background_colour = function (self)
        ease_colour(G.C.DYN_UI.MAIN, SMODS.Gradients.hpr_erratic_col)
        ease_background_colour({ new_colour = SMODS.Gradients.hpr_erratic_col, special_colour = G.C.BLACK, contrast = 1 + math.random()*2 })
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
    create_card = function (self, card, i)
        local pool = pseudorandom_element(HPR.erratic_sets, "hpr_erratic")
        return {
            set = pool,
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "hpr_erratic_card",
            seal = pool == "Playing Card" and SMODS.poll_seal({key = "hpr_erratic_seal"}),
            edition = pool == "Playing Card" and SMODS.poll_edition({key = "hpr_erratic_edition"})
        }
    end,
    pronouns = "any_all",
    cry_digital_hallucinations = erratic_hallucinations_compat,
    draw_hand = true
}

SMODS.Booster {
    key = "erratic_mega_1",
    weight = 0.1,
    kind = "hpr_erratic",
    cost = 4,
    atlas = "placeholder",
    pos = { x = 2, y = 3 },
    config = { extra = 5, choose = 2 },
    group_key = "k_erratic_pack",
    loc_vars = function (self, info_queue, card)
        local cfg = (card and card.ability) or self.config or {}
        return {
            vars = { cfg.extra, cfg.choose, localize(HPR.erratic_megas[math.random(1, #HPR.erratic_jumbos)]) },
            key = "p_hpr_erratic_pack_mega"
        }
    end,
    ease_background_colour = function (self)
        ease_colour(G.C.DYN_UI.MAIN, SMODS.Gradients.hpr_erratic_col)
        ease_background_colour({ new_colour = SMODS.Gradients.hpr_erratic_col, special_colour = G.C.BLACK, contrast = 1 + math.random()*2 })
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
    create_card = function (self, card, i)
        local pool = pseudorandom_element(HPR.erratic_sets, "hpr_erratic")
        return {
            set = pool,
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "hpr_erratic_card",
            seal = pool == "Playing Card" and SMODS.poll_seal({key = "hpr_erratic_seal"}),
            edition = pool == "Playing Card" and SMODS.poll_edition({key = "hpr_erratic_edition"})
        }
    end,
    pronouns = "any_all",
    cry_digital_hallucinations = erratic_hallucinations_compat,
    draw_hand = true
}
--#endregion