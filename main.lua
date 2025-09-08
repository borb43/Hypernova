HPR = {}
HPR.base_values = {}

to_big = to_big or function(x) return x end
loc_colour()

SMODS.current_mod.optional_features = {
    post_trigger = true
}

SMODS.Atlas {
    key = "placeholder",
    path = "placeholder.png",
    px = 71,
    py = 95
}

function deepcopy(o, seen) --stolen from stack overflow. hope it works
  seen = seen or {}
  if o == nil then return nil end
  if seen[o] then return seen[o] end

  local no
  if type(o) == 'table' then
    no = {}
    seen[o] = no

    for k, v in next, o, nil do
      no[deepcopy(k, seen)] = deepcopy(v, seen)
    end
    setmetatable(no, deepcopy(getmetatable(o), seen))
  else -- number, string, boolean, etc
    no = o
  end
  return no
end

assert(SMODS.load_file("items/rare.lua"))()
assert(SMODS.load_file("items/back.lua"))()
assert(SMODS.load_file("items/voucher.lua"))()