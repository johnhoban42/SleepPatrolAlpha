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
SetSyncRate( 60, 0 ) // 30fps instead of 60 to save battery
SetScissor( 0,0,0,0 ) // use the maximum available screen space, no black borders
UseNewDefaultFonts( 1 ) // since version 2.0.22 we can use nicer default fonts

//SetVSync(1)

SetScissor(0, 0, w, h)

global font = 99
LoadImage(font, "mainFont.png")
SetTextDefaultFontImage(font)

CreateSprite(SHEEP, 0)
SetSpriteSize(SHEEP, 96, 54)
SetSpritePosition(SHEEP, 140, 5100)
AddSpriteAnimationFrame(SHEEP, LoadImage("walk5.png"))
AddSpriteAnimationFrame(SHEEP, LoadImage("walk6.png"))
AddSpriteAnimationFrame(SHEEP, LoadImage("walk7.png"))
AddSpriteAnimationFrame(SHEEP, LoadImage("walk8.png"))
AddSpriteAnimationFrame(SHEEP, LoadImage("walk1.png"))
AddSpriteAnimationFrame(SHEEP, LoadImage("walk2.png"))
AddSpriteAnimationFrame(SHEEP, LoadImage("walk3.png"))
AddSpriteAnimationFrame(SHEEP, LoadImage("walk4.png"))
AddSpriteAnimationFrame(SHEEP, LoadImage("jump2.png"))
AddSpriteAnimationFrame(SHEEP, LoadImage("jump1.png"))

CreateSprite(71, 0)
SetSpriteSize(71, GetSpriteWidth(1), GetSpriteHeight(1))
AddSpriteAnimationFrame(71, LoadImage("spa5.png"))
AddSpriteAnimationFrame(71, LoadImage("spa6.png"))
AddSpriteAnimationFrame(71, LoadImage("spa7.png"))
AddSpriteAnimationFrame(71, LoadImage("spa8.png"))
AddSpriteAnimationFrame(71, LoadImage("spa1.png"))
AddSpriteAnimationFrame(71, LoadImage("spa2.png"))
AddSpriteAnimationFrame(71, LoadImage("spa3.png"))
AddSpriteAnimationFrame(71, LoadImage("spa4.png"))
AddSpriteAnimationFrame(71, LoadImage("spajump2.png"))
AddSpriteAnimationFrame(71, LoadImage("spajump1.png"))
SetSpriteVisible(71, 0)
//SetSpriteDepth(71, 10+totalFollow)


PlaySprite(SHEEP, 12, 1, 1, 8)
global sheepFlip = 0

CreateSprite(SHADOW, 0)
SetSpriteSize(SHADOW, 100, 10)
SetSpriteVisible(SHADOW, FALSE)

global score = 0
global scoreFlag = 0
global remSleep = 0
global highScore = 0
global spaceCrabUnlock = 1
global landmarkT as integer[8]
for i = 1 to 8
	landmarkT[i] = 0
next i
LoadGame()
for i = 1 to 8
	if landmarkT[i] = 0 then spaceCrabUnlock = 0
next i


global gameTime# = 0
global gameTimeMax = 10000
global soonLose# = 0

//LoadGame()

global introS = 1
global gameS = 2
global titleS = 3
global gameoverB = 4
global gameoverG = 5
global gameoverR = 6

LoadMusicOGG(introS, "SheepIntro.ogg")
LoadMusicOGG(gameS, "SheepLoop.ogg")
LoadMusicOGG(titleS, "TitleMusic.ogg")
LoadMusicOGG(gameoverB, "gameoverb.ogg")
//CHANGE VOLUME QUICKLY HERE
SetMusicSystemVolumeOGG(60)

global jumpS = 1
global dJumpS = 2
global bleat = 3
global thud = 4
global fwip = 5
global clang = 6

LoadSound(jumpS, "jump1.wav")
LoadSound(dJumpS, "jump2.wav")
LoadSound(bleat, "bleat.wav")
LoadSound(thud, "explode.wav")
LoadSound(fwip, "fwip.wav")
LoadSound(clang, "clang.wav")

//CHANGE VOLUME QUICKLY HERE
SetSoundSystemVolume(100)

importFromPNG()
velocityX = 4
global state = MENU
initMenu()
jumping = TRUE
SetViewZoomMode(1)

SetPrintSize(30)

global fpsr#

PlayMusicOGG(titleS, 1)

do
	
	fpsr# = 75.0*GetFrameTime()
	
	/* MENU SCREEN */
	if(state = MENU)
		showMenu()

	/* GAME LOOP */
	elseif(state = GAME)
		
		if soonLose# = 0
			if GetMusicPlayingOGG(introS) = 0 and GetMusicPlayingOGG(gameS) = 0 then PlayMusicOGG(gameS, 1)
		endif
		
		move()

		
		if GetRawKeyPressed(82) then remSleep = 1
		//This block triggers during rem sleep
		if remSleep
			if GetSpriteVisible(72) = 0
				for i = 71 to 90
					if GetSpriteExists(i) then SetSpriteVisible(i, 1)
					
				next i
				CreateSprite(b1, LoadImage("boader.png"))
				SetSpriteDepth(b1, 1)
				FixSpriteToScreen(b1, 1)
				SetSpriteSize(b1, 50, h)
				
				CreateSprite(b2, LoadImage("boader.png"))
				SetSpriteDepth(b2, 1)
				FixSpriteToScreen(b2, 1)
				SetSpriteSize(b2, 50, h)
				SetSpriteFlip(b2, 1, 0)
				SetSpritePosition(b2, w-50, 0)
				
				CreateSprite(b3, LoadImage("boader.png"))
				SetSpriteDepth(b3, 1)
				FixSpriteToScreen(b3, 1)
				SetSpriteSize(b3, 50, w)
				//SetSpriteFlip(b3, 1, 0)
				SetSpritePosition(b3, w/2-25, -w/2+25)
				SetSpriteAngle(b3, 90)
				
				CreateSprite(b4, LoadImage("boader.png"))
				SetSpriteDepth(b4, 1)
				FixSpriteToScreen(b4, 1)
				SetSpriteSize(b4, 50, w)
				//SetSpriteFlip(b3, 1, 0)
				SetSpritePosition(b4, w/2-25, h-w/2-25)
				SetSpriteAngle(b4, 270)
			endif
			
			SetSpritePosition(71, GetSpriteX(1), GetSpriteY(1))
			SetSpriteAngle(71, GetSpriteAngle(1))
			SetSpriteFrame(71, GetSpriteCurrentFrame(1))
			SetSpriteFlip(71, sheepFlip, 0)
			
			//Make sure the cycleLength is divisible by 6!
			cycleLength = 180
			colorTime = Mod(gameTime#, cycleLength)
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
			r = 255-GetSpriteColorRed(1)
			g = 255-GetSpriteColorGreen(1)
			b = 255-GetSpriteColorBlue(1)
			SetSpriteColor(b1, r, g, b, 255)
			SetSpriteColor(b2, r, g, b, 255)
			SetSpriteColor(b3, r, g, b, 255)
			SetSpriteColor(b4, r, g, b, 255)
			
			SetTextAngle(scoretext, -3+6.0*cos(gameTime#*5))
			
			
		endif

		// Colliding with a fence causes a game over
		sprite = GetSpriteHitGroup(FENCE, GetSpriteX(SHEEP)+GetSpriteWidth(SHEEP)/2, GetSpriteY(SHEEP)+GetSpriteHeight(SHEEP))
		if(sprite) and soonLose# = 0
			PlaySound(thud)
			soonLose# = 80
			jumping = TRUE
			sheepHistory[1].sound = thud
			StopSprite(SHEEP)
			velocityY = 0
			if GetMusicPlayingOGG(introS) then StopMusicOGG(introS)
			if GetMusicPlayingOGG(gameS) then StopMusicOGG(gameS)
			//initOver()
			//if score < 20 then SetSpriteImage(OVER_BACKGROUND, LoadImage("backgroundendbad.png"))
			//if score >= 20 then SetSpriteImage(OVER_BACKGROUND, LoadImage("backgroundend.png"))
			//state = OVER
			//continue
			Transition()
		endif
		//
		if gameTime# >= gameTimeMax and soonLose# = 0
			soonLose# = 80
			if GetMusicPlayingOGG(introS) then StopMusicOGG(introS)
			if GetMusicPlayingOGG(gameS) then StopMusicOGG(gameS)
			//initOver()
			//if score < 20 then SetSpriteImage(OVER_BACKGROUND, LoadImage("backgroundendbad.png"))
			//if score >= 20 then SetSpriteImage(OVER_BACKGROUND, LoadImage("backgroundend.png"))
			//state = OVER
			//continue
			Transition()
		endif
		
		if soonLose# > 0 and soonLose# < 5
			soonLose# = 0
			initOver()
			if gameTime# < gameTimeMax
				SetSpriteImage(OVER_BACKGROUND, LoadImage("backgroundendbad.png"))
				PlayMusicOGG(gameOverB, 0)
			else
				SetSpriteImage(OVER_BACKGROUND, LoadImage("backgroundendgood.png"))
				SetSpriteImage(RETRY_BUTTON, LoadImage("TheNextNight.png"))
				SetSpriteSize(RETRY_BUTTON, 266, 118)
			endif
			if GetSpriteExists(b1)
				DeleteSprite(b1)
				DeleteSprite(b2)
				DeleteSprite(b3)
				DeleteSprite(b4)
			endif
			state = OVER
			continue
		endif
		
		// Adding a sheep
		sprite = GetSpriteHitGroup(EXTRA_SHEEP, GetSpriteX(SHEEP)+GetSpriteWidth(SHEEP)/2, GetSpriteY(SHEEP)+GetSpriteHeight(SHEEP))
		if(sprite) or GetRawKeyPressed(187)
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
		
		//Dev Hotkeys
		if GetRawKeyPressed(84) then gameTime# = gameTime# + 10000 //T = Game End Good
		
		//Score increaser and size adjuster
		scoreFlagCheck()
		if GetTextSize(scoretext) > 70 then SetTextSize(scoreText, GetTextSize(scoreText)-1)
		
		//Live Camera adjustments during the game
		SetViewZoom(((1-(totalFollow/40.0))+GetViewZoom()*14)/15.0)

		if soonLose# = 0
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
		endif
		
		//Updating the game time and time indicator
		inc gameTime#, 1*fpsr#
		SetSpritePosition(moon, w/2-GetSpriteWidth(moon)/2-100+(200.0*gameTime#/gameTimeMax), 110-((gameTime#*gameTime#)/(gameTimeMax)-gameTime#)/110.0)
		SetSpriteAngle(moon, -10+20.0*cos(gameTime#*3))
		
		if soonLose# <> 0 then inc soonLose#, -1*fpsr#
		
	/* GAME OVER SCREEN */
	elseif(state = OVER)
		showOver()
		
	endif

	

    Print( ScreenFPS() )
    Print( GetRawLastKey())
    Print ("Game Time: " + Str(Round(gameTime#)))
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
	for i = 1 to 8
		WriteInteger(1, landmarkT[i])
	next i
	CloseFile(1)
endfunction

function LoadGame()
	SetFolder("/media")
	if GetFileExists("sheepSave.txt") = 0 then SaveGame()
	OpenToRead(1, "sheepSave.txt")
	highScore = ReadInteger(1)
	for i = 1 to 8
		landmarkT[i] = ReadInteger(1)
	next i
	CloseFile(1)
endfunction

function Transition()
	if soonLose# = 0
		if GetParticlesExists(1) then DeleteParticles(1)
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
		AddParticlesColorKeyFrame ( 1, 4, 255, 255, 255, 100 )
		SetParticlesDepth(1, 1)
		SetParticlesMax(1, 220)
	else
		if GetParticlesExists(1) then DeleteParticles(1)
		CreateParticles(1, 0, 0)
		SetParticlesImage ( 1, LoadImage("cloud.png"))
		FixParticlesToScreen(1, 1)
		SetParticlesStartZone(1, 0, h+700, w, h+700)
		//SetParticlesStartZone(1, w/2-200, h/2, w/2+1, h/2+1)
		SetParticlesDirection( 1, 50, -1900 )
		SetParticlesAngle ( 1, 20 )
		SetParticlesFrequency ( 1, 100 )
		SetParticlesLife ( 1, 2 )
		SetParticlesSize ( 1, 260 )
		AddParticlesColorKeyFrame ( 1, 0, 255, 255, 255, 255 )
		AddParticlesColorKeyFrame ( 1, 4, 255, 255, 255, 100 )
		SetParticlesDepth(1, 1)
		SetParticlesMax(1, 80)
		
	endif
	
endfunction
