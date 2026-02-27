SMODS.Back { --sealed deck, starting aces have seals
    key = "sealed",
    atlas = "back",
    pos = { x = 1, y = 0 },
    apply = function (self, back)
        G.E_MANAGER:add_event(Event({
            func = function ()
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
    pools = { RedeemableBacks = true }
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
    end,
    pools = { RedeemableBacks = true }
}

SMODS.Back {
    key = "cosmic",
    atlas = "placeholder",
    pos = { x = 4, y = 2 },
    config = { consumables = { "c_hpr_ascender" }},
    loc_vars = function (self, info_queue, card)
        return { vars = { localize { type = 'name_text', key = self.config.consumables[1], set = 'Spectral' } }}
    end,
    pools = { RedeemableBacks = true }
}

SMODS.Back {
    key = "treasury",
    atlas = "placeholder",
    pos = { x = 4, y = 2 },
    config = { extra = 25 },
    loc_vars = function (self, info_queue, card)
        return { vars = { self.config.extra }}
    end,
    apply = function (self, back)
        G.GAME.starting_params.dollars = G.GAME.starting_params.dollars + self.config.extra
        G.GAME.bankrupt_at = G.GAME.bankrupt_at + self.config.extra
    end,
    pools = { RedeemableBacks = true }
}

SMODS.Back {
    key = "inverted",
    atlas = "placeholder",
    pos = { x = 4, y = 2 },
    config = { extra = 0.1 },
    apply = function (self, back)
        G.GAME.modifiers.hpr_neg_consumable_rate = self.config.extra
    end,
    pools = { RedeemableBacks = true }
}
--[[
SMODS.Back {
    key = "experiment",
    atlas = "placeholder",
    pos = { x = 4, y = 2 },
    pools = { RedeemableBacks = true },
    calculate = function (self, back, context)
        if context.end_of_round and context.main_eval and context.beat_boss then
            G.GAME.hpr_awesome_pack_mod = (G.GAME.hpr_awesome_pack_mod or 1) * 2
        end
        if context.open_booster and context.booster.key == "p_hpr_awesome" then
            G.GAME.hpr_awesome_pack_mod = 1
        end
    end
}]]