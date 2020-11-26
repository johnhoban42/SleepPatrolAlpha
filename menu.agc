#include "constants.agc"

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
	SetSpriteDepth(LOGO, 1)
	FixSpriteToScreen(LOGO, 1)
	
endfunction

/*
Shows the menu state
*/
function showMenu()
	SetViewOffset(0, 0)
	SetSpriteDepth(START_BUTTON, 1)
	SetSpriteDepth(MENU_BACKGROUND, 2)
	
	
	SetSpriteAngle(START_BUTTON, 6.0*cos(startMenuCycle#*4))
	SetSpriteSize(START_BUTTON, 266+9*sin(startMenuCycle#*3), 233+7*cos(startMenuCycle#*5))
	SetSpritePosition(START_BUTTON, w/2-GetSpriteWidth(START_BUTTON)/2-50, 750-GetSpriteHeight(START_BUTTON)/2)
	
	inc startMenuCycle#, 1*fpsr#
	if startMenuCycle# > 720 then inc startMenuCycle#, -720
	
	// Transition game state
	if(GetPointerReleased())
		if(GetSpriteHitTest(START_BUTTON, GetPointerX(), GetPointerY()))
			
			StopMusicOGG(titleS)
			
			Transition()
			PlayMusicOGG(introS, 0)
			for i = 1 to 90/fpsr#
				SetSpriteAngle(START_BUTTON, 6.0*cos(startMenuCycle#*4))
				SetSpriteSize(START_BUTTON, 266+9*sin(startMenuCycle#*3), 233+7*cos(startMenuCycle#*5))
				SetSpritePosition(START_BUTTON, w/2-GetSpriteWidth(START_BUTTON)/2-50, 750-GetSpriteHeight(START_BUTTON)/2)
				
				inc startMenuCycle#, 1
				if startMenuCycle# > 720 then inc startMenuCycle#, -720
				
				if GetMusicPlayingOGG(introS) = 0 and GetMusicPlayingOGG(gameS) = 0 then PlayMusicOGG(gameS, 1)
				
				Sync()
				
			next i
			DeleteSprite(LOGO)
			
			state = GAME
			startMenuCycle# = 0
			SetSpriteDepth(START_BUTTON, 9999)
			//SetSpriteDepth(MENU_BACKGROUND, 9999)
			SetSpriteImage(MENU_BACKGROUND, LoadImage("backgroundgame.png"))
			
			if GetSpriteExists(GAME_BACKGROUND) = 0 then CreateSprite(GAME_BACKGROUND, LoadImage("backgroundtrees.png"))
			SetSpriteSize(GAME_BACKGROUND, 2050/2.7, 2362/2.7)
			//SetSpriteColor(MENU_BACKGROUND, 255, 0, 0, 255)
			SetSpritePosition(GAME_BACKGROUND, W/2 - GetSpriteWidth(GAME_BACKGROUND)/2, -50)
			FixSpriteToScreen(GAME_BACKGROUND, 1)
			SetSpriteDepth(GAME_BACKGROUND, 8000)
			
			
			if GetSpriteExists(moonbar) = 0 then CreateSprite(moonbar, LoadImage("moonbar.png"))
			SetSpriteSize(moonbar, 768/3, 137/3)
			SetSpritePosition(moonbar, W/2 - GetSpriteWidth(moonbar)/2, 120)
			SetSpriteFlip(moonbar, 0, 1)
			FixSpriteToScreen(moonbar, 1)
			
			if GetSpriteExists(moon) = 0 then CreateSprite(moon, LoadImage("minimoon.png"))
			SetSpriteSize(moon, 50, 50)
			SetSpritePosition(moon, w/2-GetSpriteWidth(moon)/2-100, 110)
			SetSpriteDepth(moon, 1)
			FixSpriteToScreen(moon, 1)
			
			CreateText(scoretext, str(score))
			SetTextSize(scoretext, 60)
			SetTextPosition(scoretext, w/2, 30)
			SetTextColor(scoretext, 255, 255, 255, 255)
			SetTextAlignment(scoretext, 1)
			SetTextDepth(scoretext, 1)
			FixTextToScreen(scoretext, 1)
			
			gameTime# = 0
			
		endif
	endif
	
endfunction
