if SERVER then
    AddCSLuaFile( "cl_round.lua" )
    include( "sv_round.lua" )
else
    include( "cl_round.lua" )
end

STATE_WAITING = 0
STATE_PREP = 1
STATE_PLAYING = 2
STATE_INTERMISSION = 3
STATE_END = 4

module( "JB.Round", package.seeall )

StateDisplay = {
    [0] = "Waiting",
    [1] = "Prep",
    [2] = "Playing",
    [3] = "Intermission",
    [4] = "End",
}

function GetState()
    return GetGlobalInt( "JB-State" )
end

function GetRound()
    return GetGlobalInt( "JB-Round" )
end

function GetRoundCount()
    return GetGlobalInt( "JB-RoundCount" )
end

function GetTime( raw )
    local t = GetGlobalFloat( "JB-Time" )

    if ( raw ) then
        return t
    end

    return math.Clamp( t - CurTime(), 0, t )
end