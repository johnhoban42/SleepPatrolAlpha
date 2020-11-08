#include "constants.agc"

/*
Initialize all game over assets when the game loads 
*/
function initOver()
	CreateSprite(RETRY_BUTTON, 0)
	SetSpriteSize(RETRY_BUTTON, 200, 100)
	SetSpritePosition(RETRY_BUTTON, W/2 - GetSpriteWidth(START_BUTTON)/2, 500)
	
	CreateSprite(OVER_BACKGROUND, 0)
	SetSpriteSize(OVER_BACKGROUND, W+100, H+100)
	SetSpriteColor(OVER_BACKGROUND, 0, 0, 255, 255)
	SetSpritePosition(OVER_BACKGROUND, -50, -50)
	
endfunction

/*
Shows the game over state
*/
function showOver()
	SetSpriteDepth(RETRY_BUTTON, 1)
	SetSpriteDepth(OVER_BACKGROUND, 2)
	
	// Transition game state
	if(GetPointerReleased())
		if(GetSpriteHitTest(RETRY_BUTTON, GetPointerX(), GetPointerY()))
			state = GAME
			SetSpriteDepth(RETRY_BUTTON, 9999)
			SetSpriteDepth(OVER_BACKGROUND, 9999)
		endif
	endif
	
endfunction
