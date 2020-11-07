#include "constants.agc"
#include "mapLoad.agc"
#include "follower.agc"
#include "physics.agc"
#include "menu.agc"

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


CreateSprite(SHEEP, LoadImage("SheepTemp.png"))
//SetSpriteColor(SHEEP, 255, 0, 0, 255)
SetSpriteSize(SHEEP, 100, 50)
SetSpritePosition(SHEEP, 100, 100)

CreateSprite(2, 0)

SetSpritePosition(2, 100, 1000)
SetSpriteGroup(2, GROUND)

importFromPNG()
velocityX = 2
global state = MENU
initMenu()

do
	if(state = MENU)
		showMenu()
		
	elseif(state = GAME)
		if(GetPointerPressed())
			jump()
		endif
		
		print(jumping)
		
		move()

		if GetSpriteX(SHEEP) > w/2+GetViewOffsetX()
			SetViewOffset(GetSpriteX(SHEEP)-(w/2), GetViewOffsetY())
		elseif GetSpriteX(SHEEP) < w/2+GetViewOffsetX()
			SetViewOffset(GetSpriteX(SHEEP)-(w/2), GetViewOffsetY())
		endif
		
		if GetSpriteY(SHEEP) > h/2+GetViewOffsetY()
			SetViewOffset(GetViewOffsetX(), GetSpriteY(SHEEP)-(h/2))
		elseif GetSpriteY(SHEEP) < h/2+GetViewOffsetY()
			SetViewOffset(GetViewOffsetX(), GetSpriteY(SHEEP)-(h/2))
		endif
		
	elseif(state = OVER)
		// TODO
	endif

    Print( ScreenFPS() )
    Sync()
loop
