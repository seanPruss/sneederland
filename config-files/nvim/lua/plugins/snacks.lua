return {
    "folke/snacks.nvim",
    opts = {
        dashboard = {
            preset = {
                header = [[
    .....                                           ...                                                ..                ..      .        ..          .         s                             
 .H8888888h.  ~-.    .uef^"                     .x888888hx    :                                      dF               x88f` `..x88. .>  dF           @88>      :8                             
 888888888888x  `> :d88E                       d88888888888hxx     u.    u.                         '88bu.          :8888   xf`*8888   '88bu.         8P      .88           u.      .u    .   
X~     `?888888hx~ `888E            .u        8" ... `"*8888 `   x@88k u@88c.      .u         .u    '*88888bu      :8888f .888  `"`    '*88888bu      .      :888ooo  ...ue888b   .d88B :@8c  
'      x8.^"*88*"   888E .z8k    ud8888.     !  "   ` .xnxx.    ^"8888""8888"   ud8888.    ud8888.    ^"*8888N     88888' X8888. >"8x    ^"*8888N   .@88u  -*8888888  888R Y888r ="8888f8888r 
 `-:- X8888x        888E~?888L :888'8888.    X X   .H8888888 :    8888  888R  :888'8888. :888'8888.  beWE "888L    88888  ?88888< 888>  beWE "888L ''888E`   8888     888R I888>   4888>'88"  
      488888>       888E  888E d888 '88 "    X 'hn8888888*"   >   8888  888R  d888 '88 " d888 '88 "  888E  888E    88888   "88888 "8    888E  888E   888E    8888     888R I888>   4888> '    
    .. `"88*        888E  888E 8888.+"       X: `*88888 `     !   8888  888R  8888.+"    8888.+"     888E  888E    88888 '  `8888>      888E  888E   888E    8888     888R I888>   4888>      
  x88888nX"      .  888E  888E 8888L         '8h.. ``     ..x8>   8888  888R  8888L      8888L       888E  888F    `8888>    X88!       888E  888F   888E   .8888Lu= u8888cJ888   .d888L .+   
 !"*8888888n..  :   888E  888E '8888c. .+     `88888888888888f   "*88*" 8888" '8888c. .+ '8888c. .+ .888N..888      `888X  `~""`   :   .888N..888    888&   ^ 888*    "*888*P"    ^"8888*"    
'    "*88888888*   m888N= 888>  "88888         ' 8888888888*"      ""   'Y"    "88888     "88888     `"888*""         "88k.      .~     `"888*""     R888"    'Y"       'Y"          "Y"      
        ^"***"`     `Y"   888     "YP'            ^"****""`                      "YP'       "YP'        ""              `""*==~~`          ""         ""                                      
                         J88"                                                                                                                                                                 
                         @                                                                                                                                                                    
                       :"                                                                                                                                                                     
 ]],
        -- stylua: ignore
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
            },
        },
    },
}
