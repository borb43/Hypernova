CardSleeves.Sleeve {
    key = "sealed",
    atlas = "sleeve",
    pos = { x = 2, y = 0 },
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
                    G.GAME.starting_deck_size = G.GAME.starting_deck_size + 4
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            func = function()
                for _, card in ipairs(G.deck.cards) do
                    if card:get_id() == 14 then
                        if card:is_suit("Diamonds") then
                            card:set_seal("Gold", true, true)
                        elseif card:is_suit("Hearts") then
                            card:set_seal("Red", true, true)
                        elseif card:is_suit("Clubs") then
                            card:set_seal("Blue", true, true)
                        elseif card:is_suit("Spades") then
                            card:set_seal("Purple", true, true)
                        else
                            card:set_seal(SMODS.poll_seal({
                                guaranteed = true
                            }), true, true)
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
        local key = self.key
        if self.get_current_deck_key() == "b_hpr_pink" then
            key = self.key .. "_alt"
        end
        return { vars = { self.config.extra.slots }, key = key }
    end,
    apply = function (self, sleeve)
        if self.get_current_deck_key() == "b_hpr_pink" then
            SMODS.change_voucher_limit(self.config.extra.slots)
        else
            SMODS.change_booster_limit(self.config.extra.slots)
        end
    end
}

CardSleeves.Sleeve {
    key = "cosmic",
    atlas = "sleeve",
    pos = { x = 0, y = 0 },
    loc_vars = function (self, sleeve)
        local key = self.key
        if self.get_current_deck_key() == "b_hpr_cosmic" then
            key = key .. "_alt"
        end
        return { key = key, vars = { localize { type = 'name_text', key = "c_hpr_ascender", set = 'Spectral' } } }
    end,
    apply = function (self, sleeve)
        if self.get_current_deck_key() == "b_hpr_cosmic" then
            G.GAME.modifiers.hpr_stellar_in_shop = true
        else
            G.E_MANAGER:add_event(Event{
                func = function ()
                    SMODS.add_card{ key = "c_hpr_ascender" }
                    return true
                end
            })
        end
    end
}

CardSleeves.Sleeve {
    key = "treasury",
    atlas = "sleeve",
    pos = { x = 0, y = 0 },
    config = { extra = 25 },
    loc_vars = function (self, sleeve)
        local key = self.key
        if self:get_current_deck_key() == "b_hpr_treasury" then
            key = key .. "_alt"
        end
        return { key = key, vars = { self.config.extra } }
    end,
    apply = function (self, sleeve)
        if self:get_current_deck_key() == "b_hpr_treasury" then
            G.GAME.interest_amount = G.GAME.interest_amount + 1
        else
            G.GAME.starting_params.dollars = G.GAME.starting_params.dollars + self.config.extra
            G.GAME.bankrupt_at = G.GAME.bankrupt_at + self.config.extra
        end
    end,
}

CardSleeves.Sleeve {
    key = "inverted",
    atlas = "sleeve",
    pos = { x = 0, y = 0 },
    config = { extra = { rate = 0.1, mult = 2 }},
    loc_vars = function (self, sleeve)
        local key = self.key
        if self:get_current_deck_key() == "b_hpr_inverted" then
            key = key .. "_alt"
        end
        return { vars = { self.config.mult }, key = key }
    end,
    apply = function (self, sleeve)
        G.GAME.hpr_neg_consumable_rate = (G.GAME.hpr_neg_consumable_rate or self.config.rate)
        if self:get_current_deck_key() == "b_hpr_inverted" then
            G.GAME.hpr_neg_consumable_rate = G.GAME.hpr_neg_consumable_rate * self.config.mult
        end
    end
}