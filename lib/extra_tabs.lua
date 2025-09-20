HPR.extra_tabs = function ()
    return HPR.tab_storage
end

HPR.tab_storage = {}

HPR.tab_storage[#HPR.tab_storage+1] = { --Credits tab
    label = "Credits",
    tab_definition_function = function ()
        return {
            n = G.UIT.ROOT, config = {r = 0.1, minw = 8, minh = 6, align = "tm", padding = 0.2, colour = G.C.BLACK}, nodes = {
                {n = G.UIT.C, config = {r = 0.1, align = "tm", padding = 0.1, colour = G.C.CLEAR}, nodes = { --Credits header and text column
                    {n = G.UIT.R, config = {r = 0.5, align = "tm", padding = 0.15, colour = G.C.RED, emboss = 0.05, minw = 2,}, nodes = { --Credits code section header
                        {n = G.UIT.T, config = {text = "Code", colour = G.C.UI.TEXT_LIGHT, scale = 0.5, align = "cm"}}
                    }},
                    {n = G.UIT.R, config = {align = "tm", padding = 0.1, minh = 0.5}, nodes = { --Credits code section contents
                        {n = G.UIT.T, config = {text = "Eris (@borb43)", colour = G.C.UI.TEXT_LIGHT, scale = 0.4, align = "tm"}}
                    }},
                    {n = G.UIT.R, config = {r = 0.5, align = "tm", padding = 0.15, colour = G.C.RED, emboss = 0.05, minw = 2,}, nodes = { --Credits art section header
                        {n = G.UIT.T, config = {text = "Art", colour = G.C.UI.TEXT_LIGHT, scale = 0.5, align = "cm"}}
                    }},
                    {n = G.UIT.R, config = {align = "tm", padding = 0.1, minh = 0.5}, nodes = { --Credits art section contents
                        {n = G.UIT.T, config = {text = "Codifyd (@codifyd)", colour = G.C.UI.TEXT_LIGHT, scale = 0.4, align = "tm"}}
                    }},
                }}
            }
        }
    end
}