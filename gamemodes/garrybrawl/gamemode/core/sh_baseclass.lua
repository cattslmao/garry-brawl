DEFINE_BASECLASS( "player_default" )

local PLAYER = {}

PLAYER.WalkSpeed = 300
PLAYER.RunSpeed  = 300
PLAYER.SlowWalkSpeed = 300
PLAYER.CrouchedWalkSpeed = 100

player_manager.RegisterClass( "JB-Base", PLAYER, "player_default" )