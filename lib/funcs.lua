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

function HPR.poll_erratic_set(seed) --returns a random set, along with additional information if applicable (`set` always, `seal` and `edition` if playing card)
    seed = seed or "hpr_erratic"
    if pseudorandom(seed) < 0.9 then
        local set = pseudorandom_element({"Joker", "Consumeables", "Playing Card"}, seed)
        local seal, edition, area
        if set == "Playing Card" then
            seal = SMODS.poll_seal({key = seed.."_seal"})
            edition = SMODS.poll_edition({key = seed.."_edition", no_negative = true})
        end
        return {
            set = set or "Joker",
            seal = seal,
            edition = edition
        }
    else
        local options = {"Voucher"}
        if next(SMODS.find_mod("entr")) then
            options[#options+1] = "RedeemableBacks"
            if next(SMODS.find_mod("CardSleeves")) then
                options[#options+1] = "Sleeve"
            end
        end
        local set = pseudorandom_element(options, seed)
        return {
            set = set or "Voucher"
        }
    end
end

function HPR.get_ascension(card)
    local center = card.config and card.config.center or card
    if center.key then
        return HPR.vanilla_ascensions[center.key] or center.hpr_ascension_key or nil
    end
    return nil
end

function HPR.get_unique_suits(cards)
    local suits = {}
    for _, c in ipairs(cards) do
        for s, _ in ipairs(SMODS.Suits) do
            if not suits[s] and c.is_suit and c:is_suit(s) then
                suits[s] = true
                break
            end
        end
    end
    return #suits, suits
end

function HPR.findany(str, ...)
    if str then
        for _, p in ipairs({...}) do
            if string.find(str, p) then return true end
        end
    end
end

function HPR.get_base_chips(card)
    local id = card:get_id()
    local chips
    for _, rank in pairs(SMODS.Ranks) do
        if id == rank.id then
            chips = rank.nominal
        end
    end
    return chips
end