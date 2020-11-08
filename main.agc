#include "constants.agc"
#include "mapLoad.agc"
#include "follower.agc"
#include "physics.agc"
#include "menu.agc"
#include "over.agc"

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
SetSpriteSize(SHEEP, 96, 50)
SetSpritePosition(SHEEP, 140, 5100)
AddSpriteAnimationFrame(SHEEP, LoadImage("sheepwalk1.png"))
AddSpriteAnimationFrame(SHEEP, LoadImage("sheepwalk2.png"))
AddSpriteAnimationFrame(SHEEP, LoadImage("sheepwalk3.png"))
AddSpriteAnimationFrame(SHEEP, LoadImage("sheepwalk4.png"))
AddSpriteAnimationFrame(SHEEP, LoadImage("sheepwalk5.png"))
AddSpriteAnimationFrame(SHEEP, LoadImage("sheepwalk6.png"))
AddSpriteAnimationFrame(SHEEP, LoadImage("sheepwalk7.png"))
AddSpriteAnimationFrame(SHEEP, LoadImage("sheepwalk8.png"))
PlaySprite(SHEEP, 10, 1, 1, 8)
global sheepFlip = 0

CreateSprite(SHADOW, 0)
SetSpriteSize(SHADOW, 100, 10)
SetSpriteVisible(SHADOW, FALSE)

global score = 0
global scoreFlag = 0


importFromPNG()
velocityX = 4
global state = MENU
initMenu()
initOver()
jumping = TRUE
SetViewZoomMode(1)

SetPrintSize(30)

do
	/* MENU SCREEN */
	if(state = MENU)
		showMenu()

	/* GAME LOOP */
	elseif(state = GAME)
		if(GetPointerPressed() or GetRawKeyPressed(32))
			jump()
		endif
		
		move()

		// Colliding with a fence causes a game over
		sprite = GetSpriteHitGroup(FENCE, GetSpriteX(SHEEP)+GetSpriteWidth(SHEEP)/2, GetSpriteY(SHEEP)+GetSpriteHeight(SHEEP))
		if(sprite)
			if score < 20 then SetSpriteImage(OVER_BACKGROUND, LoadImage("backgroundendbad.png"))
			if score >= 20 then SetSpriteImage(OVER_BACKGROUND, LoadImage("backgroundend.png"))
			state = OVER
			continue
		endif
		// Adding a sheep
		sprite = GetSpriteHitGroup(EXTRA_SHEEP, GetSpriteX(SHEEP)+GetSpriteWidth(SHEEP)/2, GetSpriteY(SHEEP)+GetSpriteHeight(SHEEP))
		if(sprite)
			CreateNewSheep()
			DeleteSprite(sprite)
		endif

		TrackSheep()
		if totalFollow >= 1
			UpdateFollowers()
		endif
		
		scoreFlagCheck()
		if GetTextSize(scoretext) > 70 then SetTextSize(scoreText, GetTextSize(scoreText)-1)

		SetViewZoom(((1-(totalFollow/40.0))+GetViewZoom()*14)/15.0)

		if sheepFlip = 0 and (GetSpriteX(SHEEP)+GetSpriteWidth(SHEEP) > w*3/8+GetViewOffsetX())
			SetViewOffset(((GetSpriteX(SHEEP)+GetSpriteWidth(SHEEP)-(w*3/8))+GetViewOffsetX()*7)/8, GetViewOffsetY())
		elseif sheepFlip and (GetSpriteX(SHEEP) < w*5/8+GetViewOffsetX())
			SetViewOffset(((GetSpriteX(SHEEP)-(w*5/8))+GetViewOffsetX()*7)/8, GetViewOffsetY())
		endif
		
		if GetSpriteY(SHEEP) > h/2+GetViewOffsetY()
			SetViewOffset(GetViewOffsetX(), (GetSpriteY(SHEEP)-(h/2)+GetViewOffsetY()*7)/8)
		elseif GetSpriteY(SHEEP) < h/2+GetViewOffsetY()
			SetViewOffset(GetViewOffsetX(), (GetSpriteY(SHEEP)-(h/2)+GetViewOffsetY()*7)/8)
		endif
		
		
	/* GAME OVER SCREEN */
	elseif(state = OVER)
		showOver()
		
	endif

	

    Print( ScreenFPS() )
    //Print( "Score: " + Str(score))
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
	SetTextString(scoretext, Str(score))
	SetTextSize(scoretext, 96)

endfunction
