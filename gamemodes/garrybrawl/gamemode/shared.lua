GM.Name = "Garry Brawl: Episode 3"
GM.Author = "kity"

// UTIL
if SERVER then
    AddCSLuaFile( "util/log.lua" )
    AddCSLuaFile( "util/concommand.lua" )

    AddCSLuaFile( "core/sh_baseclass.lua" )

    AddCSLuaFile( "core/sh_gamemode.lua" )
    AddCSLuaFile( "core/round/sh_round.lua" )

    AddCSLuaFile( "core/gamemodes/base.lua" )
    AddCSLuaFile( "core/gamemodes/instagib.lua" )
end

include( "util/log.lua" )
include( "util/concommand.lua" )

include( "core/sh_baseclass.lua" )

include( "core/sh_gamemode.lua" )
include( "core/round/sh_round.lua" )

include( "core/gamemodes/base.lua" )
include( "core/gamemodes/instagib.lua" )