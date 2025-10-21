HPR.extra_tabs = function ()
    return HPR.tab_storage
end

HPR.tab_storage = {}

HPR.tab_storage[#HPR.tab_storage+1] = { --Code tab
    label = "Code",
    tab_definition_function = function ()
        return {
            n = G.UIT.ROOT, config = {r = 0.1, minw = 8, minh = 6, align = "tm", padding = 0.2, colour = G.C.BLACK}, nodes = {
                {n = G.UIT.C, config = {r = 0.1, align = "tm", padding = 0.1, colour = G.C.CLEAR}, nodes = { --Credits header and text column
                    {n = G.UIT.R, config = {r = 0.5, align = "tm", padding = 0.15, colour = G.C.RED, emboss = 0.05 }, nodes = { --Credits code section header
                        {n = G.UIT.T, config = {text = "Eris (@borb43)", colour = G.C.UI.TEXT_LIGHT, scale = 0.45, align = "cm"}}
                    }},
                    {n = G.UIT.R, config = {align = "tm", padding = 0.1, minh = 0.5}, nodes = { --Credits code section contents
                        {n = G.UIT.T, config = {text = "Creator", colour = G.C.UI.TEXT_LIGHT, scale = 0.4, align = "tm"}}
                    }},
                }}
            }
        }
    end
}

HPR.tab_storage[#HPR.tab_storage+1] = { --Art tab
    label = "Art",
    tab_definition_function = function ()
        return {
            n = G.UIT.ROOT, config = {r = 0.1, minw = 8, minh = 6, align = "tm", padding = 0.2, colour = G.C.BLACK}, nodes = {
                {n = G.UIT.C, config = {r = 0.1, align = "tm", padding = 0.1, colour = G.C.CLEAR}, nodes = {
                    {n = G.UIT.R, config = {r = 0.5, align = "tm", padding = 0.15, colour = G.C.RED, emboss = 0.05}, nodes = { --art credit user header
                        {n = G.UIT.T, config = {text = "Codifyd (@codifyd)", colour = G.C.UI.TEXT_LIGHT, scale = 0.45, align = "cm"}}
                    }},
                    {n = G.UIT.R, config = {align = "tm", padding = 0.1, minh = 0.5}, nodes = { --art credit contents
                        {n = G.UIT.T, config = {text = "Solar Flare", colour = G.C.UI.TEXT_LIGHT, scale = 0.4, align = "tm"}}
                    }},
                    {n = G.UIT.R, config = {r = 0.5, align = "tm", padding = 0.15, colour = G.C.RED, emboss = 0.05}, nodes = { --art credit user header
                        {n = G.UIT.T, config = {text = "LFMoth", colour = G.C.UI.TEXT_LIGHT, scale = 0.45, align = "cm"}}
                    }},
                    {n = G.UIT.R, config = {align = "tm", padding = 0.1, minh = 0.5}, nodes = { --art credit contents
                        {n = G.UIT.T, config = {text = "Deimos, Phobos, Europa", colour = G.C.UI.TEXT_LIGHT, scale = 0.4, align = "tm"}}
                    }},
                }}
            }
        }
    end
}