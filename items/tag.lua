-- Mini Charm Tag for voucher
SMODS.Tag {
    key = "mini_charm",
    pos = { x = 2, y = 2 },
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.p_arcana_normal_1
    end,
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.PURPLE, function()
                local booster = SMODS.create_card { key = 'p_arcana_normal_' .. math.random(1, 4), area = G.play }
                booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
                booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
                booster.T.w = G.CARD_W * 1.27
                booster.T.h = G.CARD_H * 1.27
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end,
    in_pool = function (self, args)
        return false
    end,
    no_collection = true
}

-- Mini Meteor Tag for voucher
SMODS.Tag {
    key = "mini_meteor",
    pos = { x = 3, y = 2 },
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.p_celestial_normal_1
    end,
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.SECONDARY_SET.Planet, function()
                local booster = SMODS.create_card { key = 'p_celestial_normal_' .. math.random(1, 4), area = G.play }
                booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
                booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
                booster.T.w = G.CARD_W * 1.27
                booster.T.h = G.CARD_H * 1.27
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end,
    in_pool = function (self, args)
        return false
    end,
    no_collection = true
}

SMODS.Tag {
    key = "boss",
    atlas = "tag",
    pos = { x = 0, y = 0 },
    loc_vars = function (self, info_queue, tag)
        return { vars = { tag.ability.boss_key and localize{type = "name_text", key = tag.ability.boss_key, set = "Blind" } or "[Blind]" }}
    end,
    apply = function (self, tag, context)
        if context.type == "store_joker_create" and tag.ability.boss_key then
            local key
            for _, c in pairs(G.P_CENTERS) do
                if c.boss_key == tag.ability.boss_key then
                    key = c.key
                    break
                end
            end
            if key then
                local card = SMODS.create_card{
                    key = key,
                    area = context.area,
                    key_append = "hpr_boss_tag"
                }
                create_shop_card_ui(card, "Joker", context.area)
                card.states.visible = false
                tag:yep("+", G.C.RARITY.hpr_boss, function ()
                    card:start_materialize()
                    card.ability.couponed = true
                    card:set_cost()
                    return true
                end)
                tag.triggered = true
                return card
            end
        end
    end,
    set_ability = function (self, tag)
        tag.ability.boss_key = G.GAME.last_hpr_boss_tag_key
    end
}