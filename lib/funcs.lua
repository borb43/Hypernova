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

function HPR.poll_tag(seed, key_append, options)
    local tag_pool = options or get_current_pool('Tag', nil, nil, key_append or seed)
    local selected_tag = pseudorandom_element(tag_pool, seed)
    local it = 1
    while selected_tag == 'UNAVAILABLE' do
        it = it + 1
        selected_tag = pseudorandom_element(tag_pool, seed.."_resample"..it)
    end
    return selected_tag
end

function HPR.awesome_fucking_banish(destroyer_key, to_banish) --single key for destroyer (defaults to j_ceremonial) and a table of keys for to_banish
    local destroyer = SMODS.create_card{ area = G.play, key = destroyer_key or "j_ceremonial" }
    destroyer:start_materialize()
    G.play:emplace(destroyer)
    local cards = {}
    for _, key in ipairs(to_banish) do
        local c = SMODS.create_card{ area = G.play, key = key }
        c:start_materialize()
        G.play:emplace(c)
        cards[#cards+1] = c
    end

    for _, c in ipairs(cards) do
        G.GAME.banned_keys[c.config.center.key] = true
        local temp = c
        G.E_MANAGER:add_event(Event{
            trigger = "after",
            delay = 0.8,
            func = function ()
                destroyer:juice_up(0.8, 0.8)
                temp:start_dissolve({G.C.RED}, nil, 1.6)
                play_sound('slice1', 0.96 + math.random() * 0.08)
                return true
            end
        })
        delay(0.8)
    end

    G.E_MANAGER:add_event(Event{
        trigger = "after",
        delay = 0.5,
        func = function ()
            destroyer:start_dissolve()
            return true
        end
    })
end

function HPR.is_any(str, ...)
    for _, p in ipairs({...}) do
        if str == p then return true end
    end
end

function HPR.get_random_hand(include_hidden, seed, in_pool, fallback)
    local hands = {}
    for name in pairs(G.GAME.hands) do
        if include_hidden or SMODS.is_poker_hand_visible(name) then
            hands[#hands+1] = name
        end
    end
    return pseudorandom_element(hands, seed, {in_pool = in_pool}) or fallback or "High Card"
end

function HPR.contains(_t, val)
    for _, v in pairs(_t) do
        if v == val then return true end
    end
end

function HPR.mod_blind_amount(amt, op)
    local new_amt
    if not op or op == "*" or op =="X" then
        new_amt = G.GAME.blind.chips * amt
    elseif op == "+" then
        new_amt = G.GAME.blind.chips + amt
    elseif op == "^" then
        new_amt = G.GAME.blind.chips ^ amt
    elseif op == "eq" then
        new_amt = amt
    end
    G.GAME.blind.chips = new_amt
    G.GAME.blind.chip_text = number_format(new_amt)
    G.HUD_blind:recalculate()
end