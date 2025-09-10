CardSleeves.Sleeve {
    key = "sealed",
    atlas = "sleeve",
    pos = { x = 0, y = 0 },
    --unlock_condition = { deck = "b_hpr_sealed", stake = "stake_green" },
    --unlocked = false,
    apply = function(self, sleeve)
        if self.get_current_deck_key() == "b_hpr_sealed" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    for _, suit in ipairs({ "Diamonds", "Hearts", "Clubs", "Spades" }) do
                        SMODS.add_card({
                            area = G.deck,
                            set = "Base",
                            skip_materialize = true,
                            no_edition = true,
                            suit = suit,
                            rank = "Ace"
                        })
                    end
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            func = function()
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
    end,
    loc_vars = function (self)
        local key = self.key
        if self.get_current_deck_key() == "b_hpr_sealed" then
            key = self.key .. "_alt"
        end
        return { key = key }
    end
}

CardSleeves.Sleeve {
    key = "pink",
    atlas = "sleeve",
    pos = { x = 1, y = 0 },
    config = { extra = { slots = 1 } },
    loc_vars = function (self, sleeve)
        key = self.key
        if self.get_current_deck_key() == "b_hpr_pink" then
            key = self.key .. "_alt"
        end
        return { vars = { self.config.extra.slots }, key = key }
    end,
    apply = function (self, sleeve)
        if self.get_current_deck_key == "b_hpr_pink" then
            SMODS.change_voucher_limit(sleeve.ability.extra.slots)
        else
            SMODS.change_booster_limit(sleeve.ability.extra.slots)
        end
    end
}