SMODS.Back { --sealed deck, starting aces have seals
    key = "sealed",
    atlas = "placeholder",
    pos = { x = 4, y = 2 },
    apply = function (self, back)
        G.E_MANAGER:add_event(Event({
            func = function ()
                for _, card in ipairs(G.deck.cards) do
                    if card:get_id() == 14 then
                        if card:is_suit("Diamonds") then
                            card:set_seal("Gold", true, true)
                        end
                        if card:is_suit("Hearts") then
                            card:set_seal("Red", true, true)
                        end
                        if card:is_suit("Clubs") then
                            card:set_seal("Blue", true, true)
                        end
                        if card:is_suit("Spades") then
                            card:set_seal("Purple", true, true)
                        end
                    end
                end
                return true
            end
        }))
    end
}

SMODS.Back {
    key = "pink",
    atlas = "back",
    pos = { x = 0, y = 0 },
    config = { extra = { slots = 1 } },
    loc_vars = function (self, info_queue, card)
        return { vars = { self.config.extra.slots } }
    end,
    apply = function (self, back)
        SMODS.change_booster_limit(self.config.extra.slots)
    end
}