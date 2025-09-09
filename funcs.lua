HPR.generate_compat_msg = function(card, other_card, compat_flag, args) --generate blueprint type compat ui. message keys refer to a localization key in dictionary, colours are the background colours
    if not args then args = {} end
    compat_flag = compat_flag or "blueprint_compat"
    local compatible = other_card and other_card ~= card and other_card.config.center[compat_flag]
    return {
        {
            n = G.UIT.C,
            config = { align = "bm", minh = 0.4 },
            nodes = {
                {
                    n = G.UIT.C,
                    config = { ref_table = card, align = "m", colour = compatible and mix_colours(args.compat_colour or G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(args.incompat_colour or G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                    nodes = {
                        { n = G.UIT.T, config = { text = ' ' .. localize((compatible and (args.compat_msg_key or 'k_compatible') or (args.incompat_message_key or 'k_incompatible'))) .. ' ', colour = (compatible and args.compat_text_col or args.incompat_text_col) or args.text_colour or G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                    }
                }
            }
        }
    }
end
