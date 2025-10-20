-- #region lunar
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
        local cfg = (card and card.ability) or self.config or {} --only here because vscode is being an annoying little piece of shit about "need check nil" like what the fuck do you think `or` is meant to do you dumb fuck
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
    draw_hand = true
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
        local cfg = (card and card.ability) or self.config or {} --only here because vscode is being an annoying little piece of shit about "need check nil" like what the fuck do you think `or` is meant to do you dumb fuck
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
    draw_hand = true
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
        local cfg = (card and card.ability) or self.config or {} --only here because vscode is being an annoying little piece of shit about "need check nil" like what the fuck do you think `or` is meant to do you dumb fuck
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
    draw_hand = true
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
        local cfg = (card and card.ability) or self.config or {} --only here because vscode is being an annoying little piece of shit about "need check nil" like what the fuck do you think `or` is meant to do you dumb fuck
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
    draw_hand = true
}
-- #endregion

SMODS.Booster {
    key = "erratic_normal_1",
    weight = 1,
    kind = "hpr_erratic",
    cost = 4,
    atlas = "placeholder",
    pos = { x = 0, y = 3 },
    config = { extra = 3, choose = 1 },
    group_key = "k_erratic_pack",
    loc_vars = function (self, info_queue, card)
        local cfg = (card and card.ability) or self.config or {}
        return {
            vars = { cfg.extra, cfg.choose, colours = { HPR.erratic_colours[math.random(1, #HPR.erratic_colours)] } },
            key = "p_hpr_erratic_pack"
        }
    end,
    ease_background_colour = function (self)
        local uicol = HPR.erratic_colours[math.random(1, #HPR.erratic_colours)]
        local bgcol = HPR.erratic_colours[math.random(1, #HPR.erratic_colours)]
        ease_colour(G.C.DYN_UI.MAIN, uicol)
        ease_background_colour({ new_colour = bgcol, special_colour = G.C.BLACK, contrast = 1 + math.random()*2 })
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
        return {
            set = pseudorandom_element({"Joker", "Voucher", "Playing Card", "Consumeables"}, "hpr_erratic"),
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "hpr_erratic_card"
        }
    end,
    pronouns = "any_all"
}

SMODS.Booster {
    key = "erratic_normal_2",
    weight = 1,
    kind = "hpr_erratic",
    cost = 4,
    atlas = "placeholder",
    pos = { x = 0, y = 3 },
    config = { extra = 3, choose = 1 },
    group_key = "k_erratic_pack",
    loc_vars = function (self, info_queue, card)
        local cfg = (card and card.ability) or self.config or {}
        return {
            vars = { cfg.extra, cfg.choose, colours = { HPR.erratic_colours[math.random(1, #HPR.erratic_colours)] } },
            key = "p_hpr_erratic_pack"
        }
    end,
    ease_background_colour = function (self)
        local uicol = HPR.erratic_colours[math.random(1, #HPR.erratic_colours)]
        local bgcol = HPR.erratic_colours[math.random(1, #HPR.erratic_colours)]
        ease_colour(G.C.DYN_UI.MAIN, uicol)
        ease_background_colour({ new_colour = bgcol, special_colour = G.C.BLACK, contrast = 1 + math.random()*2 })
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
        return {
            set = pseudorandom_element({"Joker", "Voucher", "Playing Card", "Consumeables"}, "hpr_erratic"),
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "hpr_erratic_card"
        }
    end,
    pronouns = "any_all"
}

SMODS.Booster {
    key = "erratic_jumbo_1",
    weight = 1,
    kind = "hpr_erratic",
    cost = 6,
    atlas = "placeholder",
    pos = { x = 1, y = 3 },
    config = { extra = 5, choose = 1 },
    group_key = "k_erratic_pack",
    loc_vars = function (self, info_queue, card)
        local cfg = (card and card.ability) or self.config or {}
        return {
            vars = { cfg.extra, cfg.choose, localize(HPR.erratic_jumbos[math.random(1, #HPR.erratic_jumbos)]), colours = { HPR.erratic_colours[math.random(1, #HPR.erratic_colours)] } },
            key = "p_hpr_erratic_pack_jumbo"
        }
    end,
    ease_background_colour = function (self)
        local uicol = HPR.erratic_colours[math.random(1, #HPR.erratic_colours)]
        local bgcol = HPR.erratic_colours[math.random(1, #HPR.erratic_colours)]
        ease_colour(G.C.DYN_UI.MAIN, uicol)
        ease_background_colour({ new_colour = bgcol, special_colour = G.C.BLACK, contrast = 1 + math.random()*2 })
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
        return {
            set = pseudorandom_element({"Joker", "Voucher", "Playing Card", "Consumeables"}, "hpr_erratic"),
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "hpr_erratic_card"
        }
    end,
    pronouns = "any_all"
}

SMODS.Booster {
    key = "erratic_mega_1",
    weight = 0.25,
    kind = "hpr_erratic",
    cost = 4,
    atlas = "placeholder",
    pos = { x = 2, y = 3 },
    config = { extra = 5, choose = 2 },
    group_key = "k_erratic_pack",
    loc_vars = function (self, info_queue, card)
        local cfg = (card and card.ability) or self.config or {}
        return {
            vars = { cfg.extra, cfg.choose, localize(HPR.erratic_megas[math.random(1, #HPR.erratic_jumbos)]), colours = { HPR.erratic_colours[math.random(1, #HPR.erratic_colours)] } },
            key = "p_hpr_erratic_pack_mega"
        }
    end,
    ease_background_colour = function (self)
        local uicol = HPR.erratic_colours[math.random(1, #HPR.erratic_colours)]
        local bgcol = HPR.erratic_colours[math.random(1, #HPR.erratic_colours)]
        ease_colour(G.C.DYN_UI.MAIN, uicol)
        ease_background_colour({ new_colour = bgcol, special_colour = G.C.BLACK, contrast = 1 + math.random()*2 })
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
        return {
            set = pseudorandom_element({"Joker", "Voucher", "Playing Card", "Consumeables"}, "hpr_erratic"),
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "hpr_erratic_card"
        }
    end,
    pronouns = "any_all"
}