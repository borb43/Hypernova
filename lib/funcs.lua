HPR.generate_compat_msg = function(card, other_card, compat_flag, args) --generate blueprint type compat ui. `args.compat_message_key` and `args.incompat_message_key` both refer to localization keys for the incompat message, defaulting to the standard blueprint messages
    if not args then args = {} end
    compat_flag = compat_flag or "blueprint_compat"
    local compatible = (other_card and other_card ~= card and other_card.config.center[compat_flag]) or
    compat_flag == true
    return {
        {
            n = G.UIT.C,
            config = { align = "bm", minh = 0.4 },
            nodes = {
                {
                    n = G.UIT.C,
                    config = { ref_table = card, align = "m", colour = compatible and mix_colours(args.compat_colour or G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(args.incompat_colour or G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                    nodes = {
                        { n = G.UIT.T, config = { text = ' ' .. localize((compatible and (args.compat_msg_key or 'k_compatible') or (args.incompat_message_key or 'k_incompatible'))) .. ' ', colour = args.text_colour or G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                    }
                }
            }
        }
    }
end

Card.get_hpr_eff_mod = function(self)
    local extra_eff_mod = self.ability.perma_eff_mod ~= 0 and self.ability.perma_eff_mod + 1 or nil
    if extra_eff_mod then
        return (extra_eff_mod or 1)
    end
end

HPR.trigger_consumable_effect = function(card, seed)
    if not seed then seed = "force_use_generic" end
    local cac = card.ability.consumeable
    local ca = card.ability
    if (cac and (cac.max_highlighted and (cac.mod_conv or cac.suit_conv) or cac.hand_type)) or
    ca.max_highlighted and (ca.mod_conv or ca.suit_conv) or ca.hand_type or ca.hand_types then --autocompat stuff here
        local cards = cac and cac.max_highlighted or ca.max_highlighted
        local suit = cac and cac.suit_conv or ca.suit_conv
        local mod = cac and cac.mod_conv or ca.mod_conv
        local hand_type = cac and cac.hand_type or ca.hand_type
        local cry_hand_types = ca.hand_types
        if G.hand and G.hand.cards[1] and (suit or mod) then
            local options = {}
            for i = 1, #G.hand.cards do
                options[#options+1] = G.hand.cards[i]
            end
            for _ = 1, cards do
                local target, index = pseudorandom_element(options, seed)
                table.remove(options, index)
                G.E_MANAGER:add_event(Event({
                    func = function ()
                        if suit then
                            SMODS.change_base(target, suit)
                        end
                        if mod then
                            target:set_ability(mod)
                        end
                    end
                }))
            end
        end
        if hand_type then
            SMODS.smart_level_up_hand(card, hand_type)
        end
        if cry_hand_types and type(cry_hand_types) == "table" and next(cry_hand_types) then
            for _, hand in ipairs(cry_hand_types) do
                SMODS.smart_level_up_hand(card, hand)
            end
        end
    elseif not card.config.center.mod then
        --vanilla stuff here
    else
        if card.config.center.hpr_trigger_effect then
            card.config.center:hpr_trigger_effect(card, card.area)
        elseif card.config.center.force_use then
            card.config.center:force_use(card, card.area)
        end
    end
end
