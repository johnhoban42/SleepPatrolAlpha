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
SetSpriteSize(SHEEP, 100, 50)
SetSpritePosition(SHEEP, 120, 5100)
AddSpriteAnimationFrame(SHEEP, LoadImage("SheepTemp.png"))

CreateSprite(SHADOW, 0)
SetSpriteSize(SHADOW, 100, 10)
SetSpriteVisible(SHADOW, FALSE)

global score = 0
global scoreFlag = 0


importFromPNG()
velocityX = 3
global state = MENU
initMenu()
jumping = TRUE
SetViewZoomMode(1)

SetPrintSize(30)

do
	if(state = MENU)
		showMenu()

	elseif(state = GAME)
		if(GetPointerPressed() or GetRawKeyPressed(32))
			jump()
		endif
		
		move()

		if GetRawKeyPressed(187)
			CreateNewSheep()
		endif

		TrackSheep()
		if totalFollow >= 1
			UpdateFollowers()
		endif
		
		scoreFlagCheck()

		SetViewZoom(1-(totalFollow/40.0))

		if GetSpriteFlippedH(1) = 0 and (GetSpriteX(SHEEP) > w/4+GetViewOffsetX())
			SetViewOffset(GetSpriteX(SHEEP)-(w/4), GetViewOffsetY())
		elseif GetSpriteFlippedH(1) and (GetSpriteX(SHEEP) < w*3/4+GetViewOffsetX())
			SetViewOffset(GetSpriteX(SHEEP)-(w*3/4), GetViewOffsetY())
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
    Print( "Score: " + Str(score))
    Sync()
loop

function scoreFlagCheck()
	if jumping
		if GetSpriteHitGroup(12, GetSpriteX(SHEEP), GetSpriteY(SHEEP))
			scoreFlag = TRUE
		endif
	endif
endfunction

function scoreIncrement()

	inc score, 1


endfunction
