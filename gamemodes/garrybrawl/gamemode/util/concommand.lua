module( "JB.Concommand", package.seeall )

function Add( str, ... )
    concommand.Add( "jb_" .. str, ... )
end

function Remove( str, ... )
    concommand.Add( "jb_" .. str )
end