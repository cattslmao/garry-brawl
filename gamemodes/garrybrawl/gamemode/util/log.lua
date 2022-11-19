module( "JB.Log", package.seeall )

Colors = {
    Prefix = Color( 250, 76, 57 ),

    Info = Color( 50, 100, 255 ),
    Warn = Color( 255, 255, 0 ),
    Error = Color( 255, 0, 0 ),
}

function Print( msg, prefix, color )
    MsgC( color or color_white, "[" .. prefix .. "] ", color_white, msg .. "\n" )
end

function Info( msg, prefix, color )
    Print( msg, prefix or "Info", color or Colors.Info )
end

function Warn( msg, prefix, color )
    Print( msg, prefix or "Warn", color or Colors.Warn )
end

function Error( msg, prefix, color )
    Print( msg, prefix or "Error", color or Colors.Error )
end