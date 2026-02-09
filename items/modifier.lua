
SMODS.Enhancement {
    key = "ripple",
    atlas = "enhancers",
    pos = { x = 0, y = 0 },
    config = { extra = 20 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra }}
    end,
    calculate = function (self, card, context)
        if context.before and context.cardarea == G.play then
            for _, c in ipairs(context.scoring_hand) do
                if c ~= card then
                    c.ability.perma_bonus = c.ability.perma_bonus + card.ability.extra
                    SMODS.calculate_effect({ message = localize("k_upgrade_ex"), message_card = c, colour = G.C.CHIPS })
                end
            end
            return nil, true
        end
    end,
    weight = 1.5
}

SMODS.Enhancement {
    key = "storm",
    atlas = "enhancers",
    pos = { x = 1, y = 0 },
    config = { extra = 3 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra }}
    end,
    calculate = function (self, card, context)
        if context.before and context.cardarea == G.play then
            for _, c in ipairs(context.scoring_hand) do
                if c ~= card then
                    c.ability.perma_mult = c.ability.perma_mult + card.ability.extra
                    SMODS.calculate_effect({ message = localize("k_upgrade_ex"), message_card = c, colour = G.C.MULT })
                end
            end
            return nil, true
        end
    end,
    weight = 1.5
}

SMODS.Enhancement {
    key = "silver",
    atlas = "enhancers",
    pos = { x = 2, y = 1 },
    calculate = function (self, card, context)
        if context.playing_card_end_of_round and context.cardarea == G.hand then
            G.E_MANAGER:add_event(Event{
                func = function ()
                    add_tag(Tag(HPR.poll_tag("hpr_silver"), false, "Small"))
                    return true
                end
            })
            return { message = localize("k_plus_tag") }
        end
    end,
    weight = 0.5
}

SMODS.Enhancement {
    key = "lunar",
    atlas = "enhancers",
    pos = { x = 3, y = 1 },
    config = { extra = 2 },
    loc_vars = function (self, info_queue, card)
        local n, d = SMODS.get_probability_vars(card, 1, card.ability.extra, "hpr_lunar")
        return { vars = { n, d }}
    end,
    calculate = function (self, card, context)
        if context.before and context.cardarea == G.play and SMODS.pseudorandom_probability(card, "hpr_lunar", 1, card.ability.extra) then
            return {
                level_up = true,
                message = localize("k_level_up_ex")
            }
        end
    end,
    weight = 1
}

SMODS.Seal {
    key = "negative",
    pos = { x = 4, y = 4 },
    badge_colour = G.C.L_BLACK,
    calculate = function (self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                message = localize{ type = "variable", key = "a_handsize", vars = { 1 }},
                colour = G.C.DARK_EDITION,
                func = function ()
                    G.E_MANAGER:add_event(Event{
                        func = function ()
                            G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + 1
                            G.hand:change_size(1)
                            return true
                        end,
                    })
                end
            }
        end
    end,
    draw = function (self, card, layer)
        if (layer == "card" or layer == "both") and card.sprite_facing == "front" then
            G.shared_seals[card.seal].role.draw_major = card
            G.shared_seals[card.seal]:draw_shader('dissolve', nil, nil, nil, card.children.center)
            G.shared_seals[card.seal]:draw_shader('negative', nil, card.ARGS.send_to_shader, nil, card.children.center)
            G.shared_seals[card.seal]:draw_shader('negative_shine', nil, card.ARGS.send_to_shader, nil, card.children.center)
        end
    end,
}

SMODS.Shader{
    key = "green",
    path = "green.fs"
}

SMODS.Edition{
    key = "green",
    shader = "green",
    atlas = "consumable",
    pos = {x = 0, y = 0},
    badge_colour = G.C.HPR_ULTRAGREEN,
    apply_to_float = true,
    extra_cost = 5,
    config = { extra = { green = 0, add = 1 }},
    loc_vars = function (self, info_queue, card)
        local key = self.key
        if card.playing_card then key = key.."_pcard" end
        return{ vars = { card.edition.extra.green, card.edition.extra.add }, key = key }
    end,
    calculate = function (self, card, context)
        if card.playing_card then
            if context.discard and context.other_card == card and card.edition.extra.green > 0 then
                SMODS.scale_card(card, {
                    ref_table = card.edition.extra,
                    ref_value = "green",
                    scalar_value = "add",
                    operation = '-',
                    message_key = "a_hpr_green_minus",
                    message_colour = G.C.HPR_ULTRAGREEN
                })
            end
            if context.before and (context.cardarea == G.play or context.cardarea == "unscored") then
                SMODS.scale_card(card, {
                    ref_table = card.edition.extra,
                    ref_value = "green",
                    scalar_value = "add",
                    message_key = "a_hpr_green",
                    message_colour = G.C.HPR_ULTRAGREEN
                })
            end
            if context.main_scoring and context.cardarea == G.play and card.edition.extra.green ~= 0 then
                return{
                    mult = card.edition.extra.green,
                    message = localize{type="variable",key="a_hpr_green",vars={card.edition.extra.green}},
                    colour = G.C.HPR_ULTRAGREEN,
                    remove_default_message = true,
                    sound = "foil2",
                    volume = 0.3,
                    hpr_no_mod = true
                }
            end
        else
            if context.pre_discard and card.edition.extra.green > 0 then
                SMODS.scale_card(card, {
                    ref_table = card.edition.extra,
                    ref_value = "green",
                    scalar_value = "add",
                    operation = '-',
                    message_key = "a_hpr_green_minus",
                    message_colour = G.C.HPR_ULTRAGREEN
                })
            end
            if context.before then
                SMODS.scale_card(card, {
                    ref_table = card.edition.extra,
                    ref_value = "green",
                    scalar_value = "add",
                    message_key = "a_hpr_green",
                    message_colour = G.C.HPR_ULTRAGREEN
                })
            end
            if context.pre_joker and card.edition.extra.green ~= 0 then
                return{
                    mult = card.edition.extra.green,
                    message = localize{type="variable",key="a_hpr_green",vars={card.edition.extra.green}},
                    colour = G.C.HPR_ULTRAGREEN,
                    remove_default_message = true,
                    sound = "foil2",
                    volume = 0.3,
                    hpr_no_mod = true
                }
            end
        end
    end
}