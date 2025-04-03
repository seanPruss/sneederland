return {
    "folke/snacks.nvim",
    opts = {
        scroll = { enabled = false },
        bigfile = { enabled = true },
        dashboard = {
            preset = {
                header = [[
████████╗██╗  ██╗███████╗    ███████╗███╗   ██╗███████╗███████╗██████╗     ███████╗██████╗ ██╗████████╗ ██████╗ ██████╗ 
╚══██╔══╝██║  ██║██╔════╝    ██╔════╝████╗  ██║██╔════╝██╔════╝██╔══██╗    ██╔════╝██╔══██╗██║╚══██╔══╝██╔═══██╗██╔══██╗
   ██║   ███████║█████╗      ███████╗██╔██╗ ██║█████╗  █████╗  ██║  ██║    █████╗  ██║  ██║██║   ██║   ██║   ██║██████╔╝
   ██║   ██╔══██║██╔══╝      ╚════██║██║╚██╗██║██╔══╝  ██╔══╝  ██║  ██║    ██╔══╝  ██║  ██║██║   ██║   ██║   ██║██╔══██╗
   ██║   ██║  ██║███████╗    ███████║██║ ╚████║███████╗███████╗██████╔╝    ███████╗██████╔╝██║   ██║   ╚██████╔╝██║  ██║
   ╚═╝   ╚═╝  ╚═╝╚══════╝    ╚══════╝╚═╝  ╚═══╝╚══════╝╚══════╝╚═════╝     ╚══════╝╚═════╝ ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝
   ]],
                ---@type snacks.dashboard.Item[]
                keys = {
                    {
                        icon = " ",
                        key = "f",
                        desc = "Find File",
                        action = function()
                            local handle = io.popen("git rev-parse --is-inside-work-tree 2>/dev/null")
                            local result = handle:read("*a")
                            handle:close()
                            if result:match("true") then
                                Snacks.picker.git_files()
                            else
                                Snacks.picker.files({ hidden = true })
                            end
                        end,
                    },
                    { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                    {
                        icon = " ",
                        key = "g",
                        desc = "Find Text",
                        action = ":lua Snacks.dashboard.pick('live_grep')",
                    },
                    {
                        icon = " ",
                        key = "r",
                        desc = "Recent Files",
                        action = ":lua Snacks.dashboard.pick('oldfiles')",
                    },
                    {
                        icon = " ",
                        key = "c",
                        desc = "Config",
                        action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
                    },
                    { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                    { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
                    { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
                    { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                },
            },
        },
    },
}
