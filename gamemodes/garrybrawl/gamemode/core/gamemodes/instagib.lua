JB.Gamemode.Register( "instagib", {
    Base = "base",

    Name = "Instagib",
    Description = "Meow!",

    Hooks = {
        PlayerDeath = function( victim, inflictor, attacker ) end,
    },
} )