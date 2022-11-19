module( "JB.Gamemode", package.seeall )

Registry = Registry or {}
LoadedHooks = LoadedHooks or {}

TeamRef = TeamRef or {}
ClassRef = ClassRef or {}

function GetCurrent()
    return GetGlobalString( "JB-CurrentGamemode" ) or nil
end

function Get()
    return Registry[ GetCurrent() ]
end

function GetMinPlayers()
    return GetGlobalInt( "JB-MinPlayers" ) or 2
end

function GetTeam( name )
    return TeamRef[ name ]
end

function GetClass( name )
    return ClassRef[ name ]
end

function Register( name, gamemode_tbl )
    if ( Registry[ name ] ) then
        JB.Log.Warn( string.format( "Gamemode \"%s\" already registered.", name ) )
        return
    end

    JB.Log.Info( string.format( "Registering gamemode \"%s\".", gamemode_tbl.Name or name ) )

    if ( gamemode_tbl.Base && Registry[ gamemode_tbl.Base ] ) then
        gamemode_tbl = table.Merge( Registry[ gamemode_tbl.Base ], gamemode_tbl )
    end

    Registry[ name ] = gamemode_tbl
end

function Clean()
    local HookCount = table.Count( LoadedHooks )
    
    if ( HookCount > 0 ) then
        JB.Log.Info( string.format( "Clearing %s hook(s).", HookCount ) )
    
        for _, v in ipairs( LoadedHooks ) do
            JB.Log.Info( string.format( "Clearing hook \"%s\".", v[2] ) )
            hook.Remove( v[1], v[2] )
        end

        LoadedHooks = {}
    end

    TeamRef = {}
end

function Load( name )
    if ( CLIENT ) then return end

    if ( !Registry[ name ] ) then
        JB.Log.Error( string.format( "Gamemode \"%s\" isn't registered!", name ) )
        return
    end

    local def = Registry[ name ]

    JB.Log.Info( string.format( "Loading gamemode \"%s\"...", def.Name or name ) )

    Clean()

    SetGlobalString( "JB-CurrentGamemode", name )

    SetGlobalInt( "JB-MinPlayers", def.MinPlayers )

    for k, v in pairs( def.Hooks ) do
        local ident = "JB-" .. name .. "-" .. k

        JB.Log.Info( string.format( "Creating hook \"%s\".", ident ) )

        hook.Add( k, ident, v )

        table.insert( LoadedHooks, { k, ident } )
    end

    for k, v in pairs( def.PlayerClass ) do
        local ident = "JB-" .. name .. "-" .. k

        JB.Log.Info( string.format( "Creating class \"%s\".", ident ) )

        player_manager.RegisterClass( ident, v, "JB-Base" )

        ClassRef[ k ] = ident
    end

    for k, v in pairs( def.Teams ) do
        local name = v.name or "Team " .. k

        JB.Log.Info( string.format( "Setting up team \"%s\" at index %s.", name, k ) )

        team.SetUp( k, name, v.color or color_white, v.joinable or true )

        if ( v.Class ) then
            team.SetClass( k, GetClass( v.Class ) )
        else
            team.SetClass( k, "JB-Base" )
        end

        TeamRef[ name ] = k
    end
end