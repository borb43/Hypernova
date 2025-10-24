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

HPR.apply_moon_bonus = function(card, moon_card) --applies the moon bonus to a card
    local mult = G.GAME.hpr_moons_mult or 1
    card.ability.perma_bonus = card.ability.perma_bonus + (moon_card.ability.moon_bonus or 0)*mult
    card.ability.perma_h_chips = card.ability.perma_h_chips + (moon_card.ability.moon_h_chips or 0)*mult
    card.ability.perma_mult = card.ability.perma_mult + (moon_card.ability.moon_mult or 0)*mult
    card.ability.perma_h_mult = card.ability.perma_h_mult + (moon_card.ability.moon_h_mult or 0)*mult
    card.ability.perma_x_chips = card.ability.perma_x_chips + (moon_card.ability.moon_x_chips or 0)*mult
    card.ability.perma_h_x_chips = card.ability.perma_h_x_chips + (moon_card.ability.moon_h_x_chips or 0)*mult
    card.ability.perma_x_mult = card.ability.perma_x_mult + (moon_card.ability.moon_x_mult or 0)*mult
    card.ability.perma_h_x_mult = card.ability.perma_h_x_mult + (moon_card.ability.moon_h_x_mult or 0)*mult
    card.ability.perma_p_dollars = card.ability.perma_p_dollars + (moon_card.ability.moon_p_dollars or 0)*mult
    card.ability.perma_h_dollars = card.ability.perma_h_dollars + (moon_card.ability.moon_h_dollars or 0)*mult
    card.ability.perma_repetitions = card.ability.perma_repetitions + (moon_card.ability.moon_repetitions or 0)*mult
    card.ability.perma_eff_mod = card.ability.perma_eff_mod + (moon_card.ability.moon_eff_mod or 0)*mult
    if next(SMODS.find_mod("entr")) then
        card.ability.perma_entr_plus_asc = card.ability.perma_entr_plus_asc + (moon_card.ability.moon_entr_plus_asc or 0)*mult
        card.ability.perma_entr_h_plus_asc = card.ability.perma_entr_h_plus_asc + (moon_card.ability.moon_entr_h_plus_asc or 0)*mult
        card.ability.perma_entr_asc = card.ability.perma_entr_asc + (moon_card.ability.moon_entr_asc or 0)*mult
        card.ability.perma_entr_h_asc = card.ability.perma_entr_h_asc + (moon_card.ability.moon_entr_h_asc or 0)*mult
        card.ability.perma_entr_exp_asc = card.ability.perma_entr_exp_asc + (moon_card.ability.moon_entr_exp_asc or 0)*mult
        card.ability.perma_entr_h_exp_asc = card.ability.perma_entr_h_exp_asc + (moon_card.ability.moon_entr_h_exp_asc)*mult
    end
    if next(SMODS.find_mod("aikoyorisshenanigans")) then
        card.ability.akyrs_perma_score = card.ability.akyrs_perma_score + (moon_card.ability.akyrs_moon_score or 0)*mult
        card.ability.akyrs_perma_h_score = card.ability.akyrs_perma_h_score + (moon_card.ability.akyrs_moon_h_score or 0)*mult
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