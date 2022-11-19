LENGTH_ROUND = 5
LENGTH_INTERMISSION = 3
LENGTH_WAITING = 25

module( "JB.Round", package.seeall )

function SetState( n )
    local n = math.Clamp( n, 0, 4 )

    JB.Log.Info( string.format( "Setting state to %s.", StateDisplay[n] ) )

    SetGlobalInt( "JB-State", n )
end

function SetRound( n )
    JB.Log.Info( string.format( "Setting round to %s.", n ) )

    SetGlobalInt( "JB-Round", n )
end

function NextRound()
    local n = GetRound() + 1

    SetRound( n )
end

function SetRoundCount( n )
    JB.Log.Info( string.format( "Setting round count to %s.", n ) )

    SetGlobalInt( "JB-RoundCount", n )
end

SetRoundCount( 5 )

function SetTime( n, raw )
    local n = raw and n or CurTime() + n

    JB.Log.Info( string.format( "Setting time to %s.", n ) )

    SetGlobalFloat( "JB-Time", n )
end

SetTime( -1, true )

function StartPrep()
    NextRound()
    SetTime( LENGTH_INTERMISSION )
    SetState( STATE_PREP )
end


function StartRound()
    SetTime( LENGTH_ROUND )
    SetState( STATE_PLAYING )

    JB.Log.Info( string.format( "Starting round %s.", GetRound() ) )
end

function StartIntermission()
    SetTime( LENGTH_INTERMISSION )
    SetState( STATE_INTERMISSION )
end

LastState = nil

function Think()
    local mode = JB.Gamemode.GetCurrent()

    if ( !mode or mode == "" ) then
        return
    end

    local State = GetState()

    if ( !LastState ) then
        LastState = State
    end

    if ( LastState && LastState != State ) then
        hook.Call( "JB_StateChange", GAMEMODE, State, LastState )

        LastState = State
    end

    local Round = GetRound()
    local MinPly = JB.Gamemode.GetMinPlayers()
    local TimeLeft = GetTime()
    local RoundCount = GetRoundCount()

    local PlyCount = player.GetCount()
    
    if ( State == STATE_WAITING ) then
        if ( PlyCount < MinPly ) then
            return
        end

        if ( TimeLeft == -1 ) then
            SetTime( LENGTH_WAITING )
            return
        end

        if ( TimeLeft <= 0 ) then
            StartPrep()
        end
    end

    if ( State == STATE_PREP ) then
        if ( TimeLeft <= 0 ) then
            StartRound()
        end
    end

    if ( State == STATE_PLAYING ) then
        if ( TimeLeft <= 0 ) then
            if ( Round >= RoundCount ) then
                SetTime( LENGTH_INTERMISSION )
                SetState( STATE_END )
                return
            end

            StartIntermission()
        end
    end

    if ( State == STATE_INTERMISSION ) then
        if ( TimeLeft <= 0 ) then
            StartPrep()
        end
    end

    if ( State == STATE_END ) then
        if ( TimeLeft <= 0 ) then
            print( "game ova" )
        end
    end

end

hook.Add( "Think", "JBRoundThink", Think )