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
SetOrientationAllowed( 1, 0, 0, 0 ) // allow both portrait and landscape on mobile devices
SetSyncRate( 60, 0 ) // 30fps instead of 60 to save battery
SetScissor( 0,0,0,0 ) // use the maximum available screen space, no black borders
UseNewDefaultFonts( 1 ) // since version 2.0.22 we can use nicer default fonts

//SetVSync(1)

if GetGameCenterExists() = 1 // This checks to see if Game Center/Game Services exist on the device
	GameCenterSetup()
endif
//if GetGameCenterLoggedIn() = 0
	GameCenterLogin()

SetScissor(0, 0, w, h)

global font = 99
LoadImage(font, "mainFont.png")
SetTextDefaultFontImage(font)

global tipfont = 98
LoadImage(tipfont, "tipfont.png")

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

LoadCrabFrames()


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
global tipProgress = 0
//global landmarkSpr as integer[8]

LoadGame()

for i = 1 to 8
	if landmarkT[i] <> 1 then spaceCrabUnlock = 0
next i


global gameTime# = 0
global gameTimeMax = 10200
global soonLose# = 0
global tipFlag
global remVol = 0
global crabMode = 0

//LoadGame()

global introS = 1
global gameS = 2
global titleS = 3
global gameoverB = 4
global gameoverG = 5
global gameoverR = 6
global remS = 7
global crabS = 8
global crabSrem = 9

LoadMusicOGG(introS, "SheepIntro.ogg")
LoadMusicOGG(gameS, "SheepLoop.ogg")
LoadMusicOGG(titleS, "TitleMusic.ogg")
LoadMusicOGG(gameoverB, "gameoverB.ogg")
LoadMusicOGG(gameoverG, "gameoverG.ogg")
LoadMusicOGG(gameoverR, "gameoverR.ogg")
LoadMusicOGG(remS, "SheepLoopR.ogg")
LoadMusicOGG(crabS, "CrabLoop.ogg")
LoadMusicOGG(crabSrem, "CrabLoopR.ogg")
//CHANGE VOLUME QUICKLY HERE
SetMusicSystemVolumeOGG(0)	//60

global jumpS = 1
global dJumpS = 2
global bleat = 3
global thud = 4
global fwip = 5
global clang = 6
global scoresound = 7
global scoresound2 = 8
global scoresound3 = 9
global dreamexit = 10
global dreamenter = 11
global pillowsound = 12
global crabsound = 13

LoadSound(jumpS, "jump1.wav")
LoadSound(dJumpS, "jump2.wav")
LoadSound(bleat, "bleat.wav")
LoadSound(thud, "explode.wav")
LoadSound(fwip, "fwip.wav")
LoadSound(clang, "clang.wav")
LoadSound(scoresound, "score.wav")
LoadSound(scoresound2, "score2.wav")
LoadSound(scoresound3, "score3.wav")
LoadSound(dreamexit, "dreamexit.wav")
LoadSound(dreamenter, "dreamenter.wav")
LoadSound(pillowsound, "pillow.wav")
LoadSound(crabsound, "turn.wav")

//CHANGE VOLUME QUICKLY HERE
SetSoundSystemVolume(0)

importFromPNG()
velocityX = 4
global state = MENU
initMenu()
jumping = TRUE
SetViewZoomMode(1)

SetPrintSize(30)

global fpsr#

PlayMusicOGG(titleS, 1)

global testTally

do
	
	fpsr# = 75.0*GetFrameTime()
	
	/* MENU SCREEN */
	if(state = MENU)
		showMenu()

	/* GAME LOOP */
	elseif(state = GAME)
		
		if soonLose# = 0
			//if GetMusicPlayingOGG(introS) = 0 and GetMusicPlayingOGG(gameS) = 0 then PlayMusicOGG(gameS, 0)
		endif
		
		move()

		//SetSpriteSize(scoreBD, 290, 160)
		//SetSpritePosition(scoreBD, w/2-GetSpriteWidth(scoreBD)/2, 20)
	
	
		//In game score cloud movement
		SetSpriteAngle(scoreBD, 2.0*cos(gameTime#*2))
		SetSpriteSize(scoreBD, 290+9*sin(gameTime#*4), 160+12*cos(gameTime#*3))
		SetSpritePosition(scoreBD, w/2-GetSpriteWidth(scoreBD)/2, 100-GetSpriteHeight(scoreBD)/2)
		
		//Game Background scrolling
		SetSpritePosition(GAME_BACKGROUND, W/2 - GetSpriteWidth(GAME_BACKGROUND)/2+10-GetSpriteX(1)/180.0, -10-GetSpriteY(1)/100.0)
		
		//The tip cloud updating
		if GetSpriteExists(tipcloud) then UpdateTip()
		
		if GetRawKeyPressed(82) 
			remSleep = 1
			if crabMode = 1 then PlaySprite(SHEEP, 12, 1, 11+(remSleep*10), 18+(remSleep*10))
		endif
		//This block triggers during rem sleep
		if remSleep
			
			if remVol < 100
				inc remVol, 1
				if crabMode = 0
					SetMusicVolumeOGG(gameS, 100-remVol)
					SetMusicVolumeOGG(remS, remVol)
				else
					SetMusicVolumeOGG(crabS, 100-remVol)
					SetMusicVolumeOGG(crabSrem, remVol)
				endif
			endif
			
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
			if crabMode = 0 or remSleep = 0
				SetSpriteFrame(71, GetSpriteCurrentFrame(1))
			else
				SetSpriteFrame(71, GetSpriteCurrentFrame(1)-10)
			endif
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

		//Touching landmarks
		
		if spaceCrabUnlock = 0
			spr = GetSpriteHitGroup(15, GetSpriteX(SHEEP)+GetSpriteWidth(SHEEP)/2, GetSpriteY(SHEEP)+GetSpriteHeight(SHEEP))
			for i = 1 to 8
				if landmarkT[i] = spr
					landmarkT[i] = 1
					SetSpriteColor(spr, 255, 255, 255, 255)
					//PlaySound(scoresound, 30)
					PlaySound(scoresound2, 40)
					PlaySound(scoresound3, 60)
				endif
			next i
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
			if GetMusicPlayingOGG(remS) then StopMusicOGG(remS)
			if GetMusicPlayingOGG(crabS) then StopMusicOGG(crabS)
			if GetMusicPlayingOGG(crabSrem) then StopMusicOGG(crabSrem)
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
			if GetMusicPlayingOGG(remS) then StopMusicOGG(remS)
			if GetMusicPlayingOGG(crabS) then StopMusicOGG(crabS)
			if GetMusicPlayingOGG(crabSrem) then StopMusicOGG(crabSrem)
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
				SetSpriteFrame(painting, 2)
			else
				if remSleep
					//Best REM end
					SetSpriteImage(OVER_BACKGROUND, LoadImage("backgroundendrem.png"))
					PlayMusicOGG(gameOverR, 0)
					SetSpriteX(RETRY_BUTTON, GetSpriteX(RETRY_BUTTON) - 100)
					SetSpriteFrame(painting, 4)
				else
					//Normal Good end
					SetSpriteImage(OVER_BACKGROUND, LoadImage("backgroundendgood.png"))
					PlayMusicOGG(gameOverG, 0)
					SetSpriteFrame(painting, 3)
				endif
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
			if crabMode = 0
				PlaySound(bleat)
				sheepHistory[1].sound = bleat
			else
				PlaySound(crabsound)
				sheepHistory[1].sound = crabsound
			endif
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
		
		
		if GetRawKeyState(37) then SetSpriteX(1, GetSpriteX(1)-10)
		if GetRawKeyState(39) then SetSpriteX(1, GetSpriteX(1)+10)
		if GetRawKeyState(38) then velocityY = -10
		if GetRawKeyState(40) then velocityY = 10
		
	/* GAME OVER SCREEN */
	elseif(state = OVER)
		showOver()
		
	endif

	

    //Print( ScreenFPS() )
    //Print( GetRawLastKey())
    //Print ("Game Time: " + Str(Round(gameTime#)))
    //Print ("Max Game Time: " + Str(gameTimeMax))
    //Print(tipFlag)
    //Print(tipProgress)
    
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
	rnd = Random(1, 3)
	if rnd = 1
		PlaySound(scoresound, 8)
	elseif rnd = 2
		PlaySound(scoresound2, 8)
	else
		PlaySound(scoresound3, 8)
	endif
		
	//sheepHistory[1].sound = dJumpS

endfunction

function SaveGame()
	SetFolder("/media")
	OpenToWrite(1, "sheepSave.txt")
	WriteInteger(1, highScore)
	for i = 1 to 8
		WriteInteger(1, landmarkT[i])
	next i
	WriteInteger(1, tipProgress)
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
	tipProgress = ReadInteger(1)
	CloseFile(1)
endfunction

function Transition()
	if soonLose# = 0
		PlaySound(dreamenter, 40)
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
		SetParticlesDepth(1, 2)
		SetParticlesMax(1, 220)
		
		if tipFlag
			//Handling the tip cloud
			if GetSpriteExists(tipcloud) then DeleteSprite(tipcloud)
			if GetTextExists(tiptext) then DeleteText(tiptext)
			
			CreateSprite(tipcloud, LoadImage("cloudtext.png"))
			SetSpriteSize(tipcloud, 500, 200)
			SetSpritePosition(tipcloud, w/2 - GetSpriteWidth(tipcloud)/2, 395)
			FixSpriteToScreen(tipcloud, 1)
			SetSpriteDepth(tipcloud, 1)
			SetSpriteColorAlpha(tipcloud, 25)
			
			CreateText(tiptext, GetTipStr())
			SetTextSize(tiptext, 42)
			SetTextColor(tiptext, 75, 0, 128, 25)
			SetTextAlignment(tiptext, 1)
			SetTextPosition(tiptext, w/2, 450)
			FixTextToScreen(tiptext, 1)
			SetTextDepth(tiptext, 1)
			SetTextFontImage(tiptext, tipfont)
		endif
		
	else
		PlaySound(dreamexit, 40)
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

function GetTipStr()
	OpenToRead(2, "tips.txt")
	str$ = ""
	//This if is to make sure that every tip is seen in order
	if tipProgress <= 6
		ct = tipProgress+1
	elseif tipProgress <= 15
		ct = Random(1, 13)
	else
		ct = Random(1, 19)
	endif
	for i = 1 to ct
		str$ = ReadLine(2)
		str$ = str$ + chr(10) + ReadLine(2)
	next i
	inc tipProgress, 1
	CloseFile(2)
endfunction str$

function UpdateTip()
	if tipFlag
		yinc# = GetTextY(tiptext)/480.0
		
		if gameTime# <= 1
			if GetSpriteColorAlpha(tipcloud) <= 255
				SetSpriteColorAlpha(tipcloud, GetSpriteColorAlpha(tipCloud) + 10)
				SetTextColorAlpha(tiptext, GetTextColorAlpha(tiptext) + 10)
			endif
		else
			SetSpriteColorAlpha(tipcloud, GetSpriteColorAlpha(tipCloud) - 2)
			SetTextColorAlpha(tiptext, GetTextColorAlpha(tiptext) - 2)
		endif
		
		SetSpriteY(tipcloud, GetSpriteY(tipcloud) + yinc# + 3.0*cos(gameTime#*3))
		SetTextY(tiptext, GetTextY(tiptext) + yinc# + 3.0*cos(gameTime#*3))
		
		if GetSpriteColorAlpha(tipCloud) < 20
			DeleteSprite(tipcloud)
			DeleteText(tiptext)
		endif

	endif
	
endfunction

function LoadCrabFrames()
	
	AddSpriteAnimationFrame(SHEEP, LoadImage("crabwalk5.png"))
	AddSpriteAnimationFrame(SHEEP, LoadImage("crabwalk6.png"))
	AddSpriteAnimationFrame(SHEEP, LoadImage("crabwalk7.png"))
	AddSpriteAnimationFrame(SHEEP, LoadImage("crabwalk8.png"))
	AddSpriteAnimationFrame(SHEEP, LoadImage("crabwalk1.png"))
	AddSpriteAnimationFrame(SHEEP, LoadImage("crabwalk2.png"))
	AddSpriteAnimationFrame(SHEEP, LoadImage("crabwalk3.png"))
	AddSpriteAnimationFrame(SHEEP, LoadImage("crabwalk4.png"))
	AddSpriteAnimationFrame(SHEEP, LoadImage("crabjump2.png"))
	AddSpriteAnimationFrame(SHEEP, LoadImage("crabjump1.png"))

	AddSpriteAnimationFrame(SHEEP, LoadImage("crabrem5.png"))
	AddSpriteAnimationFrame(SHEEP, LoadImage("crabrem6.png"))
	AddSpriteAnimationFrame(SHEEP, LoadImage("crabrem7.png"))
	AddSpriteAnimationFrame(SHEEP, LoadImage("crabrem8.png"))
	AddSpriteAnimationFrame(SHEEP, LoadImage("crabrem1.png"))
	AddSpriteAnimationFrame(SHEEP, LoadImage("crabrem2.png"))
	AddSpriteAnimationFrame(SHEEP, LoadImage("crabrem3.png"))
	AddSpriteAnimationFrame(SHEEP, LoadImage("crabrem4.png"))
	AddSpriteAnimationFrame(SHEEP, LoadImage("crabremjump2.png"))
	AddSpriteAnimationFrame(SHEEP, LoadImage("crabremjump1.png"))

	AddSpriteAnimationFrame(71, LoadImage("crabspa5.png"))
	AddSpriteAnimationFrame(71, LoadImage("crabspa6.png"))
	AddSpriteAnimationFrame(71, LoadImage("crabspa7.png"))
	AddSpriteAnimationFrame(71, LoadImage("crabspa8.png"))
	AddSpriteAnimationFrame(71, LoadImage("crabspa1.png"))
	AddSpriteAnimationFrame(71, LoadImage("crabspa2.png"))
	AddSpriteAnimationFrame(71, LoadImage("crabspa3.png"))
	AddSpriteAnimationFrame(71, LoadImage("crabspa4.png"))
	AddSpriteAnimationFrame(71, LoadImage("crabspajump2.png"))
	AddSpriteAnimationFrame(71, LoadImage("crabspajump1.png"))
	
endfunction

function ShowLeaderBoard()
	
	board$ = "CgkIyZryvesUEAIQAA"
	/*if num = 1 then board$ = "CgkIhLDGjb8bEAIQAQ"
	if num = 2 then board$ = "CgkIhLDGjb8bEAIQAg"
	if num = 3 then board$ = "CgkIhLDGjb8bEAIQAw"
	if num = 4 then board$ = "CgkIhLDGjb8bEAIQBA"
	if num = 5 then board$ = "CgkIhLDGjb8bEAIQAA"	//Crab Power
	if num = 6 then board$ = "CgkIhLDGjb8bEAIQBw"
	if num = 7 then board$ = "CgkIhLDGjb8bEAIQCA"
	if num = 8 then board$ = "CgkIhLDGjb8bEAIQCQ"*/
	//
	//
	if GetGameCenterLoggedIn()
		//crabPower = (highScore1+highScore2+highScore3+highScore4+highScore6+highscore7+highscore8)
		GameCenterSubmitScore(highScore, "CgkIyZryvesUEAIQAA")
		//GameCenterSubmitScore(highScore2, "CgkIhLDGjb8bEAIQAg")
		//GameCenterSubmitScore(highScore3, "CgkIhLDGjb8bEAIQAw")
		//GameCenterSubmitScore(highScore4, "CgkIhLDGjb8bEAIQBA")
		//GameCenterSubmitScore(crabPower, "CgkIhLDGjb8bEAIQAA")
		//GameCenterSubmitScore(highScore6, "CgkIhLDGjb8bEAIQBw")
		//GameCenterSubmitScore(highScore7, "CgkIhLDGjb8bEAIQCA")
		//GameCenterSubmitScore(highScore8, "CgkIhLDGjb8bEAIQCQ")
		//
		//
		GameCenterShowLeaderBoard(board$)
	else
		GameCenterLogin()
	endif
endfunction
