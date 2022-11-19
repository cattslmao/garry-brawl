module( "JB.Round", package.seeall )

hook.Add( "HUDPaint", "DebugHudClient", function()
    local t = {
        "Gamemode: " .. JB.Gamemode.GetCurrent(),
        "State: " .. JB.Round.StateDisplay[JB.Round.GetState()],
        "Round: " .. JB.Round.GetRound() .. "/" .. JB.Round.GetRoundCount(),
        "Time: " .. math.Round( JB.Round.GetTime() ),
    }

    local x, y = 15, 15
    local inc = 15

    for k, v in ipairs( t ) do
        draw.SimpleText( v, "ChatFont", x, y + ( (k-1)*inc ) )
    end
end )