#include "constants.agc"

/*
Initialize all menu assets when the game loads 
*/
function initMenu()
	CreateSprite(START_BUTTON, 0)
	SetSpriteSize(START_BUTTON, 200, 100)
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
	SetSpriteDepth(START_BUTTON, 1)
	SetSpriteDepth(MENU_BACKGROUND, 2)
	
	// Transition game state
	if(GetPointerReleased())
		if(GetSpriteHitTest(START_BUTTON, GetPointerX(), GetPointerY()))
			state = GAME
			SetSpriteDepth(START_BUTTON, 9999)
			SetSpriteDepth(MENU_BACKGROUND, 9999)
		endif
	endif
	
endfunction
