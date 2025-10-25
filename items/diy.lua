
SMODS.ConsumableType {
    key = "hpr_diy",
    default = "c_fool", --TEMP
    primary_colour = HEX("a86e3e"),
    secondary_colour = HEX("b3533b")
}

SMODS.Booster {
    key = "diy",
    weight = 0,
    in_pool = function (self, args)
        return false
    end,
    kind = "hpr_diy_pack",
    cost = 0,
    atlas = "placeholder",
    pos = { x = 4, y = 2 },
    config = { extra = 5, choose = 2 },
    group_key = "k_hpr_diy",
    loc_vars = function (self, info_queue, card)
        local cfg = (card and card.ability) or self.config or {}
        return { vars = { cfg.extra, cfg.choose }}
    end,
    ease_background_colour = function (self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.DARK_EDITION)
        ease_background_colour({ new_colour = G.C.CHANCE, special_colour = G.C.BLACK, contrast = 2 })
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
            set = "Consumeables", --TEMP
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "hpr_diy"
        }
    end,
    --no_collection = true,
}