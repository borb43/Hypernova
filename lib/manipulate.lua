HPR.manipulate_blacklist = {
    numerator = true,
    denominator = true,
    cards_to_draw = true,
    arrows = HPR.config.disable_arrow_manip,
    colour = true,
    card = true
}

HPR.manipulate_ret = function(table, mod)
    for k, v in pairs(table) do
        if type(table[k]) == "number" and not HPR.manipulate_blacklist[k] then
            if k == "level_up" and table[k] == true then table[k] = 1 end
            table[k] = table[k] * mod
            if k == "dollars" or k == "p_dollars" or k == "h_dollars" or k == "level_up" or k == "arrows" then
                table[k] = math.floor(table[k])
            end
        elseif type(v) == "table" and not v.config and not HPR.manipulate_blacklist[k] then
            HPR.manipulate_ret(v, mod)
        end
    end
end

HPR.round = function (num, dec) --rounds a number to `dec` decimal places
    local ret = num
    local mul = 10^dec
    ret = ret * mul
    return math.floor(ret+0.5)/mul
end

HPR.misprint_ret = function(table, mod, seed) -- multiplies by a random value in `mod^[-1, 1]`.
    for k, v in pairs(table) do
        if type(table[k]) == "number" and not HPR.manipulate_blacklist[k] then
            if k == "level_up" and table[k] == true then table[k] = 1 end
            table[k] = table[k] * mod^(pseudorandom(seed..k)*2 - 1)
            if k == "dollars" or k == "p_dollars" or k == "h_dollars" or k == "level_up" or k == "arrows" then
                table[k] = math.floor(table[k])
            else
                table[k] = HPR.round(table[k], 2)
            end
        elseif type(v) == "table" and not v.config and not HPR.manipulate_blacklist[k] then
            HPR.misprint_ret(v, mod, seed..k)
        end
    end
end