HPR.manipulate_blacklist = {
    colour = true,
    card = true,
    message_card = true,
    playing_card = true,
    end_of_round = true,
    retriggers = true
}

HPR.janky_manipulates = {
    cards_to_draw = true,
    numerator = true,
    denominator = true,
    arrows = true
}

HPR.manipulate_ret = function(table, mod) -- multiplies values in a table by `mod`. intended for joker returns in context.post_trigger
    for k, v in pairs(table) do
        if type(table[k]) == "number" and not HPR.manipulate_blacklist[k] and (HPR.config.enable_janky_manips or not HPR.janky_manipulates[k]) then
            if k == "level_up" and table[k] == true then table[k] = 1 end
            table[k] = table[k] * mod
            if k == "dollars" or k == "p_dollars" or k == "h_dollars" or k == "level_up" or k == "arrows" then
                table[k] = math.floor(table[k])
            end
        elseif type(v) == "table" and not v.area and not HPR.manipulate_blacklist[k] then
            HPR.manipulate_ret(v, mod)
        end
    end
end
