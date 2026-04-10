
SMODS.Tag {
    key = "deck",
    atlas = "tag",
    pos = { x = 1, y = 0 },
    apply = function (self, tag, context)
        if context.type == "voucher_add" then
            tag:yep("+", G.C.FILTER, function ()
                local back = SMODS.create_card{
                    set = "Back",
                    area = G.shop_vouchers,
                    key_append = "hpr_deck_tag"
                }
                back.shop_voucher = true
                create_shop_card_ui(back, "Voucher", G.shop_vouchers)
                back:start_materialize()
                G.shop_vouchers:emplace(back)
                G.shop_vouchers.config.card_limit = #G.shop_vouchers.cards
                back.from_tag = true
                return true
            end)
            tag.triggered = true
        end
    end,
    min_ante = 2
}

if next(SMODS.find_mod("CardSleeves")) then
    SMODS.Tag {
        key = "sleeve",
        atlas = "tag",
        pos = { x = 0, y = 0 },
        apply = function (self, tag, context)
            if context.type == "voucher_add" then
                tag:yep("+", G.C.FILTER, function ()
                    local back = SMODS.create_card{
                        set = "Sleeve",
                        area = G.shop_vouchers,
                        key_append = "hpr_sleeve_tag"
                    }
                    back.shop_voucher = true
                    create_shop_card_ui(back, "Voucher", G.shop_vouchers)
                    back:start_materialize()
                    G.shop_vouchers:emplace(back)
                    G.shop_vouchers.config.card_limit = #G.shop_vouchers.cards
                    back.from_tag = true
                    return true
                end)
                tag.triggered = true
            end
        end
    }
end

SMODS.Tag {
    key = "chaos",
    atlas = "tag",
    pos = { x = 2, y = 0 },
    loc_vars = function (self, info_queue, tag)
        info_queue[#info_queue+1] = { set = "Other", key = "p_hpr_erratic_mega_no_var", vars = {} }
    end,
    apply = function (self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', SMODS.Gradients.hpr_erratic_col, function()
                local booster = SMODS.create_card { key = "p_hpr_erratic_mega_1", area = G.play }
                local ed_pool = {}
                for _, ed in ipairs(G.P_CENTER_POOLS.Edition) do
                    if ed.key ~= "e_base" and not (ed.config and ed.config.card_limit) then
                        ed_pool[#ed_pool+1] = ed.key
                    end
                end
                local edition = SMODS.poll_edition{ options = ed_pool, guaranteed = true, key = "hpr_chaos_tag" }
                booster:set_edition(edition or "e_foil", true, true)
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
    end
}

SMODS.Tag {
    key = "green",
    atlas = "tag",
    pos = { x = 3, y = 0 },
    loc_vars = function (self, info_queue, tag)
        info_queue[#info_queue+1] = G.P_CENTERS.e_hpr_green
    end,
    apply = function (self, tag, context)
        if context.type == 'store_joker_modify' then
            if not context.card.edition and not context.card.temp_edition and context.card.ability.set == 'Joker' then
                local lock = tag.ID
                G.CONTROLLER.locks[lock] = true
                context.card.temp_edition = true
                tag:yep('+', G.C.DARK_EDITION, function()
                    context.card.temp_edition = nil
                    context.card:set_edition("e_hpr_green", true)
                    context.card.ability.couponed = true
                    context.card:set_cost()
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                tag.triggered = true
                return true
            end
        end
    end,
    in_pool = function(self, args)
        return G.P_CENTERS["e_hpr_green"].discovered
    end
}