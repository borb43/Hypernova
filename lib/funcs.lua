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

HPR.reset_hand_display = function ()
    update_hand_text({ delay = 0 }, { mult = 0, chips = 0, level = "", handname = "" })
end

HPR.custom_upgrade_hand = function (card, _hand, t)
    local hand = G.GAME.hands[_hand]
    update_hand_text({ delay = 0 }, { handname = localize(hand, "poker_hands"), level = hand.level, chips = hand.chips, mult = hand.mult })
    if t.mult then
        hand.mult = hand.mult + t.mult
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
            play_sound('tarot1')
            if card and card.juice_up then card:juice_up(0.8, 0.5) end
            G.TAROT_INTERRUPT_PULSE = true
            return true end }))
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {mult = hand.mult, StatusText = true})
    end
    if t.chips then
        hand.chips = hand.chips + t.chips
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
            play_sound('tarot1')
            if card and card.juice_up then card:juice_up(0.8, 0.5) end
            G.TAROT_INTERRUPT_PULSE = true
            return true end }))
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, {chips = hand.chips, StatusText = true})
    end
    if t.xmult or t.xchips then
        delay(1)
        if t.xmult then
            hand.mult = hand.mult * t.xmult
            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { mult = "X"..t.xmult, StatusText = true })
            delay(0.7)
            update_hand_text({delay = 0}, {mult = hand.mult})
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                play_sound('tarot1')
                if card and card.juice_up then card:juice_up(0.8, 0.5) end
                G.TAROT_INTERRUPT_PULSE = true
                return true end }))
        end
        if t.xchips then
            hand.chips = hand.chips * t.xchips
            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { mult = "X"..t.xchips, StatusText = true })
            delay(0.7)
            update_hand_text({delay = 0}, {mult = hand.chips})
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                play_sound('tarot1')
                if card and card.juice_up then card:juice_up(0.8, 0.5) end
                G.TAROT_INTERRUPT_PULSE = true
                return true end }))
        end
    end
    if t.balance then
        delay(1)
        local tot = hand.chips + hand.mult
        hand.chips = tot/2
        hand.mult = tot/2
        update_hand_text({delay = 0}, {chips = hand.chips, mult = hand.mult})
        HPR.event_presets.balance_display(card)
        delay(0.6)
    end
    if t.levels then
        hand.level = hand.level + t.levels
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('tarot1')
            if card then card:juice_up(0.8, 0.5) end
            G.TAROT_INTERRUPT_PULSE = nil
            return true end }))
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level=hand.level})
        delay(1.3)
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = (function() check_for_unlock{type = 'upgrade_hand', hand = _hand, level = hand.level} return true end)
        }))
    end
    HPR.reset_hand_display()
end