SMODS.Consumable{
    key = "green",
    set = "Tarot",
    atlas = "consumable",
    pos = { x = 0, y = 0 },
    no_collection = true,
    pools = { Meme = true }, --i cba to find the actual cryptid objecttype so i hope this is right
    can_use = function (self, card)
        return #HPR.get_all_highlighted(card, {G.hand,G.consumeables,G.jokers}) == 1
    end,
    use = function (self, card, area, copier)
        local cards = HPR.get_all_highlighted(card, {G.hand,G.consumeables,G.jokers})
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                for _, c in ipairs(cards) do
                    c:set_edition("e_hpr_green", true)
                end
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
    end
}