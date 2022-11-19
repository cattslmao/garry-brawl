JB.Gamemode.Register( "base", {
    Name = "Base Gamemode",
    Description = "Base Gamemode",

    Hooks = {
        PlayerDeath = function( victim, inflictor, attacker ) end,

        JB_StateChange = function( new, old )
            print( "State change: " .. old .. "->" .. new )
        end,
    },

    PlayerClass = {},

    RoundLength = 150, -- 2 minutes 30 seconds

    MinPlayers = 2,

    Respawn = false,

    Teams = {
        [1] = { 
            name = "Team 1",
            color = Color( 255, 0, 0 ),
            joinable = true,

            spawnpoints = { "jb_spawn_" },
        },
        [2] = { 
            name = "Team 2",
            color = Color( 0, 0, 255 ),
            joinable = true,

            spawnpoints = { "jb_spawn_" },
        },
    },
} )