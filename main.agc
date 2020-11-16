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
global remSleep = 0
global highScore = 0

global gameTime = 0
global gameTimeMax = 10000

LoadGame()

global introS = 1
global gameS = 2

LoadMusicOGG(introS, "SheepIntro.ogg")
LoadMusicOGG(gameS, "SheepLoop.ogg")
//CHANGE VOLUME QUICKLY HERE
SetMusicSystemVolumeOGG(50)

global jumpS = 1
global dJumpS = 2
global bleat = 3

LoadSound(jumpS, "jump1.wav")
LoadSound(dJumpS, "jump2.wav")
LoadSound(bleat, "bleat.wav")
//CHANGE VOLUME QUICKLY HERE
SetSoundSystemVolume(100)

importFromPNG()
velocityX = 4
global state = MENU
initMenu()
jumping = TRUE
SetViewZoomMode(1)

SetPrintSize(30)


do
	/* MENU SCREEN */
	if(state = MENU)
		showMenu()

	/* GAME LOOP */
	elseif(state = GAME)
		
		
		if GetMusicPlayingOGG(introS) = 0 and GetMusicPlayingOGG(gameS) = 0 then PlayMusicOGG(gameS, 1)
		
		move()

		
		if GetRawKeyPressed(82) then remSleep = 1
		//This block triggers during rem sleep
		if remSleep
			//Make sure the cycleLength is divisible by 6!
			cycleLength = 180
			colorTime = Mod(gameTime, cycleLength)
			phaseLen = cycleLength/6
			
			//Each colorphase will last for one phaseLen
			if colorTime <= phaseLen	//Red -> O
				t = colorTime
				SetSpriteColor(1, 255, (t*127.0)/phaseLen, 0, 255)
				
			elseif colorTime <= phaseLen*2	//Orange -> Y
				t = colorTime-phaseLen
				SetSpriteColor(1, 255, 128+(t*127.0)/phaseLen, 0, 255)
				
			elseif colorTime <= phaseLen*3	//Yellow -> G
				t = colorTime-phaseLen*2
				SetSpriteColor(1, 255-(t*255.0/phaseLen), 255, 0, 255)
				
			elseif colorTime <= phaseLen*4	//Green -> B
				t = colorTime-phaseLen*3
				SetSpriteColor(1, 0, 255-(t*255.0/phaseLen), (t*255.0/phaseLen), 255)
				
			elseif colorTime <= phaseLen*5	//Blue -> P
				t = colorTime-phaseLen*4
				SetSpriteColor(1, (t*139.0/phaseLen), 0, 255, 255)
				
			else 	//Purple -> R
				t = colorTime-phaseLen*5
				SetSpriteColor(1, 139+(t*116.0/phaseLen), 0, 255-(t*255.0/phaseLen), 255)
				
			endif
			
			SetTextAngle(scoretext, -3+6.0*cos(gameTime*5))
			
			
		endif

		// Colliding with a fence causes a game over
		sprite = GetSpriteHitGroup(FENCE, GetSpriteX(SHEEP)+GetSpriteWidth(SHEEP)/2, GetSpriteY(SHEEP)+GetSpriteHeight(SHEEP))
		if(sprite) or gameTime >= gameTimeMax
			initOver()
			if score < 20 then SetSpriteImage(OVER_BACKGROUND, LoadImage("backgroundendbad.png"))
			if score >= 20 then SetSpriteImage(OVER_BACKGROUND, LoadImage("backgroundend.png"))
			state = OVER
			continue
		endif
		
		// Adding a sheep
		sprite = GetSpriteHitGroup(EXTRA_SHEEP, GetSpriteX(SHEEP)+GetSpriteWidth(SHEEP)/2, GetSpriteY(SHEEP)+GetSpriteHeight(SHEEP))
		if(sprite)
			PlaySound(bleat)
			sheepHistory[1].sound = bleat
			CreateNewSheep()
			DeleteSprite(sprite)
		endif
	
		//Updates the sheep that are following #1
		TrackSheep()
		if totalFollow >= 1
			UpdateFollowers()
		endif
		
		//Score increaser and size adjuster
		scoreFlagCheck()
		if GetTextSize(scoretext) > 70 then SetTextSize(scoreText, GetTextSize(scoreText)-1)
		
		//Live Camera adjustments during the game
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
		
		//Updating the game time and time indicator
		inc gameTime, 1
		SetSpritePosition(moon, w/2-GetSpriteWidth(moon)/2-100+(200.0*gameTime/gameTimeMax), 110-((gameTime*gameTime)/(gameTimeMax)-gameTime)/110.0)
		SetSpriteAngle(moon, -10+20.0*cos(gameTime*3))
		
		
	/* GAME OVER SCREEN */
	elseif(state = OVER)
		showOver()
		
	endif

	

    Print( ScreenFPS() )
    Print( GetRawLastKey())
    Print ("Game Time: " + Str(gameTime))
    Print ("Max Game Time: " + Str(gameTimeMax))
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

function SaveGame()
	SetFolder("/media")
	OpenToWrite(1, "sheepSave.txt")
	WriteInteger(1, highScore)
	CloseFile(1)
endfunction

function LoadGame()
	SetFolder("/media")
	if GetFileExists("sheepSave.txt") = 0 then SaveGame()
	OpenToRead(1, "sheepSave.txt")
	highScore = ReadInteger(1)
	CloseFile(1)
endfunction

function Transition()
	
	CreateParticles ( 1, w/2, h/2 )
	SetParticlesImage ( 1, LoadImage("cloud.png"))
	FixParticlesToScreen(1, 1)
	SetParticlesStartZone(1, 0, 0, 0, 0)
	//SetParticlesStartZone(1, w/2-200, h/2, w/2+1, h/2+1)
	SetParticlesDirection( 1, 0, -550 )
	SetParticlesAngle ( 1, 360 )
	SetParticlesFrequency ( 1, 100 )
	SetParticlesLife ( 1, 5 )
	SetParticlesSize ( 1, 260 )
	AddParticlesColorKeyFrame ( 1, 0, 255, 255, 255, 255 )
	AddParticlesColorKeyFrame ( 1, 4, 255, 255, 255, 0 )
	SetParticlesDepth(1, 1)
	SetParticlesMax(1, 170)
	
endfunction
