if next(SMODS.find_mod("potassium_re")) then
    HPR.moon {
        key = "greip",
        atlas = "placeholder",
        pos = { x = 3, y = 2 },
        config = { extra = 0.1, max_highlighted = 2 },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra, card.ability.max_highlighted } }
        end,
        apply_bonus = function(self, card, other_card)
            other_card.ability.kali_perma_glop = other_card.ability.kali_perma_glop + card.ability.extra
        end
    }

    HPR.moon {
        key = "gerd",
        atlas = "placeholder",
        pos = { x = 3, y = 2 },
        config = { extra = 0.1, max_highlighted = 3 },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra, card.ability.max_highlighted } }
        end,
        apply_bonus = function(self, card, other_card)
            other_card.ability.kali_perma_h_glop = other_card.ability.kali_perma_h_glop + card.ability.extra
        end
    }
end
