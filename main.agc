#include "constants.agc"

// Project: SleepPatrolAlpha 
// Created: 2020-11-07

// show all errors
SetErrorMode(2)

// set window properties
SetWindowTitle( "SleepPatrolAlpha" )
SetWindowSize( 620, 1100, 0 )
SetWindowAllowResize( 1 ) // allow the user to resize the window

//Screen dimension variables
global w = 620
global h = 1100

// set display properties
SetVirtualResolution( 620 , 1100 ) // doesn't have to match the window
SetOrientationAllowed( 1, 1, 1, 1 ) // allow both portrait and landscape on mobile devices
SetSyncRate( 30, 0 ) // 30fps instead of 60 to save battery
SetScissor( 0,0,0,0 ) // use the maximum available screen space, no black borders
UseNewDefaultFonts( 1 ) // since version 2.0.22 we can use nicer default fonts

SetVSync(1)


CreateSprite(1, LoadImage("bananaReal.png"))
SetSpritePosition(1, 100, 100)
SetSpriteSize(1, 50, 50)

SetSpriteColor(1, 255, 0, 0, 255)
SetSpriteAngle(1, 40)

CreateSprite(2, 0)
SetSpritePosition(2, w/2, h-100)
SetSpriteSize(2, 100, 100)


do

	if (GetRawKeyState(37))
		SetSpriteX(1, GetSpriteX(1) - 1)
	elseif (GetRawKeyState(39))
		SetSpriteX(1, GetSpriteX(1) + 1)
	endif
	
	GetRawKeyState(37)
    
    
    SetSpriteColorAlpha(2, 255)
    if GetSpriteCollision(1, 2)
		SetSpriteColorAlpha(2, 100)
		Print("AAAAHHHHHH!")
		
	endif
	

    Print( ScreenFPS() )
    Print( GetRawLastKey() )
    Print( GetRawKeyState(37) )
    Sync()
loop
