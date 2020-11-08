#include "constants.agc"

/*
Initialize all menu assets when the game loads 
*/

global startMenuCycle = 0

function initMenu()
	CreateSprite(START_BUTTON, LoadImage("startstyle2.png"))
	SetSpriteSize(START_BUTTON, 266, 233)
	SetSpritePosition(START_BUTTON, W/2 - GetSpriteWidth(START_BUTTON)/2, 500)
	
	CreateSprite(MENU_BACKGROUND, 0)
	SetSpriteSize(MENU_BACKGROUND, W+100, H+100)
	SetSpriteColor(MENU_BACKGROUND, 255, 0, 0, 255)
	SetSpritePosition(MENU_BACKGROUND, -50, -50)
	
endfunction

/*
Shows the menu state
*/
function showMenu()
	SetViewOffset(0, 0)
	SetSpriteDepth(START_BUTTON, 1)
	SetSpriteDepth(MENU_BACKGROUND, 2)
	
	
	SetSpriteAngle(START_BUTTON, 6.0*cos(startMenuCycle*4))
	SetSpriteSize(START_BUTTON, 266+9*sin(startMenuCycle*3), 233+7*cos(startMenuCycle*5))
	SetSpritePosition(START_BUTTON, w/2-GetSpriteWidth(START_BUTTON)/2, 750-GetSpriteHeight(START_BUTTON)/2)
	
	inc startMenuCycle, 1
	if startMenuCycle > 720 then inc startMenuCycle, -720
	
	// Transition game state
	if(GetPointerReleased())
		if(GetSpriteHitTest(START_BUTTON, GetPointerX(), GetPointerY()))
			state = GAME
			startMenuCycle = 0
			SetSpriteDepth(START_BUTTON, 9999)
			SetSpriteDepth(MENU_BACKGROUND, 9999)
		endif
	endif
	
endfunction
