
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
    end,
    in_pool = function (self, args)
        return false
    end
}