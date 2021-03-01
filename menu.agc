

/*
Initialize all menu assets when the game loads 
*/

global startMenuCycle# = 0

function initMenu()
	CreateSprite(START_BUTTON, LoadImage("startstyle2.png"))
	SetSpriteSize(START_BUTTON, 266, 233)
	SetSpritePosition(START_BUTTON, W/2 - GetSpriteWidth(START_BUTTON)/2-50, 500)
	
	CreateSprite(MENU_BACKGROUND, LoadImage("backgroundstart.png"))
	SetSpriteSize(MENU_BACKGROUND, W+100, H+100)
	//SetSpriteColor(MENU_BACKGROUND, 255, 0, 0, 255)
	SetSpritePosition(MENU_BACKGROUND, -50, -50)
	FixSpriteToScreen(MENU_BACKGROUND, 1)
	
	CreateSprite(LOGO, LoadImage("sleeppatrolalpha.png"))
	SetSpriteSize(LOGO, 407, 275)
	//SetSpriteColor(MENU_BACKGROUND, 255, 0, 0, 255)
	SetSpritePosition(LOGO, W/2 - GetSpriteWidth(LOGO)/2, 100)
	SetSpriteDepth(LOGO, 2)
	FixSpriteToScreen(LOGO, 1)
	
	CreateSprite(painting, LoadImage("crabportraitnight.png"))
	AddSpriteAnimationFrame(painting, LoadImage("crabportraitnight.png"))
	AddSpriteAnimationFrame(painting, LoadImage("crabportraitnightbad.png"))
	AddSpriteAnimationFrame(painting, LoadImage("crabportraitday.png"))
	AddSpriteAnimationFrame(painting, LoadImage("crabportraitrem.png"))
	SetSpriteSize(painting, 114, 210)
	SetSpritePosition(painting, 480, 350)
	FixSpriteToScreen(painting, 1)
	if spaceCrabUnlock = 0 then SetSpriteVisible(painting, 0)
	
endfunction

/*
Shows the menu state
*/
function showMenu()
	SetViewOffset(0, 0)
	SetSpriteDepth(START_BUTTON, 2)
	SetSpriteDepth(MENU_BACKGROUND, 3)
	SetSpriteDepth(painting, 2)
	
	
	SetSpriteAngle(START_BUTTON, 6.0*cos(startMenuCycle#*4))
	SetSpriteSize(START_BUTTON, 266+9*sin(startMenuCycle#*3), 233+7*cos(startMenuCycle#*5))
	SetSpritePosition(START_BUTTON, w/2-GetSpriteWidth(START_BUTTON)/2-50, 750-GetSpriteHeight(START_BUTTON)/2)
	
	SetSpriteSize(painting, 114+4*cos(startMenuCycle#*2), 210+8*cos(startMenuCycle#*2))
	SetSpritePosition(painting, 470-GetSpriteWidth(painting)/2+63, 356-GetSpriteHeight(painting)/2+117)
	
	inc startMenuCycle#, 1*fpsr#
	if startMenuCycle# > 720 then inc startMenuCycle#, -720
	
	// Transition game state
	if (GetPointerReleased())
		if (GetSpriteHitTest(painting, GetPointerX(), GetPointerY()) and spaceCrabUnlock) then crabMode = 1
		if (GetSpriteHitTest(START_BUTTON, GetPointerX(), GetPointerY()) or crabMode)
			
			StopMusicOGG(titleS)
			
			Transition()
			remVol = 0
			if crabMode = 0
				PlayMusicOGG(gameS, 0)
				PlayMusicOGG(remS, 0)
				SetMusicVolumeOGG(gameS, 100-remVol)
				SetMusicVolumeOGG(remS, remVol)
				LoadSheepAnimation(SHEEP)
			else
				PlayMusicOGG(crabS, 0)
				PlayMusicOGG(crabSrem, 0)
				SetMusicVolumeOGG(crabS, 100-remVol)
				SetMusicVolumeOGG(crabSrem, remVol)
				LoadCrabAnimation(SHEEP)
			endif
			PlaySprite(SHEEP, 12, 1, 1, 8)
			for i = 1 to 90/fpsr#
				SetSpriteAngle(START_BUTTON, 6.0*cos(startMenuCycle#*4))
				SetSpriteSize(START_BUTTON, 266+9*sin(startMenuCycle#*3), 233+7*cos(startMenuCycle#*5))
				SetSpritePosition(START_BUTTON, w/2-GetSpriteWidth(START_BUTTON)/2-50, 750-GetSpriteHeight(START_BUTTON)/2)
				
				inc startMenuCycle#, 1
				if startMenuCycle# > 720 then inc startMenuCycle#, -720
				
				//if GetMusicPlayingOGG(introS) = 0 and GetMusicPlayingOGG(gameS) = 0 then PlayMusicOGG(gameS, 0)
				
				UpdateTip()
				
				Sync()
				
			next i
			drawMap(map_w, map_h)
			
			SetViewOffset(0, 4700)
			
			//SetSpritePosition(SHEEP, 140, 5100)
			SetSpritePosition(SHEEP, 1728, 4992)
			sheepFlip = 0
			SetSpriteFlip(SHEEP, 0, 0)
			velocityY = 0
			jumping = FALSE
			doubleJump = FALSE
			velocityX = 4
			
			DeleteSprite(LOGO)
			
			state = GAME
			startMenuCycle# = 0
			SetSpriteDepth(START_BUTTON, 9999)
			SetSpriteDepth(painting, 9999)
			//SetSpriteDepth(MENU_BACKGROUND, 9999)
			SetSpriteImage(MENU_BACKGROUND, LoadImage("backgroundgame.png"))
			
			if GetSpriteExists(GAME_BACKGROUND) = 0 then CreateSprite(GAME_BACKGROUND, LoadImage("backgroundtrees.png"))
			SetSpriteSize(GAME_BACKGROUND, 2050/2.7, 2362/2.7)
			//SetSpriteColor(MENU_BACKGROUND, 255, 0, 0, 255)
			SetSpritePosition(GAME_BACKGROUND, W/2 - GetSpriteWidth(GAME_BACKGROUND)/2, -50)
			FixSpriteToScreen(GAME_BACKGROUND, 1)
			SetSpriteDepth(GAME_BACKGROUND, 8000)
			
			CreateInGameScore()
			
			
			gameTime# = 0
			
		endif
	endif
	
endfunction

function CreateInGameScore()
	CreateSprite(scoreBD, LoadImage("cloudbd.png"))
	SetSpriteSize(scoreBD, 290, 160)
	SetSpritePosition(scoreBD, w/2-GetSpriteWidth(scoreBD)/2, 20)
	
	SetSpriteDepth(scoreBD, 3)
	FixSpriteToScreen(scoreBD, 1)
	
	if GetSpriteExists(moonbar) = 0 then CreateSprite(moonbar, LoadImage("moonbar.png"))
	SetSpriteSize(moonbar, 768/3, 137/3)
	SetSpritePosition(moonbar, W/2 - GetSpriteWidth(moonbar)/2, 120)
	SetSpriteFlip(moonbar, 0, 1)
	FixSpriteToScreen(moonbar, 1)
	SetSpriteDepth(moonbar, 3)
	
	if GetSpriteExists(moon) = 0 then CreateSprite(moon, LoadImage("minimoon.png"))
	SetSpriteSize(moon, 50, 50)
	SetSpritePosition(moon, w/2-GetSpriteWidth(moon)/2-100, 110)
	SetSpriteDepth(moon, 3)
	FixSpriteToScreen(moon, 1)
	
	CreateText(scoretext, str(score))
	SetTextSize(scoretext, 70)
	SetTextPosition(scoretext, w/2-7, 40)
	SetTextColor(scoretext, 75, 0, 128, 255)
	SetTextAlignment(scoretext, 1)
	SetTextDepth(scoretext, 3)
	FixTextToScreen(scoretext, 1)
	SetTextFontImage(scoretext, font)
	
	
endfunction
