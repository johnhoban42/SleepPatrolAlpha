#include "constants.agc"
#include "mapLoad.agc"
#include "physics.agc"

// Project: SleepPatrolAlpha 
// Created: 2020-11-07

// show all errors
SetErrorMode(2)

// set window properties
SetWindowTitle( "SleepPatrolAlpha" )
SetWindowSize( 620, 1100, 0 )
SetWindowAllowResize( 1 ) // allow the user to resize the window

// set display properties
SetVirtualResolution( 620 , 1100 ) // doesn't have to match the window
SetOrientationAllowed( 1, 1, 1, 1 ) // allow both portrait and landscape on mobile devices
SetSyncRate( 30, 0 ) // 30fps instead of 60 to save battery
SetScissor( 0,0,0,0 ) // use the maximum available screen space, no black borders
UseNewDefaultFonts( 1 ) // since version 2.0.22 we can use nicer default fonts

SetVSync(1)


CreateSprite(SHEEP, 0)
SetSpriteColor(SHEEP, 255, 0, 0, 255)
SetSpritePosition(SHEEP, 100, 100)

CreateSprite(2, 0)
SetSpritePosition(2, 100, 1000)
SetSpriteGroup(2, GROUND)

do

	if(GetPointerPressed())
		jump()
	endif
	
	print(jumping)
	
	move()

    Print( ScreenFPS() )
    Sync()
loop
