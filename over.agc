#include "constants.agc"
#include "follower.agc"
#include "mapLoad.agc"
#include "main.agc"

/*
Initialize all game over assets when the game loads 
*/
function initOver()
	CreateSprite(RETRY_BUTTON, 0)
	SetSpriteSize(RETRY_BUTTON, 200, 100)
	SetSpritePosition(RETRY_BUTTON, W/2 - GetSpriteWidth(RETRY_BUTTON)/2, 500)
	
	CreateSprite(OVER_BACKGROUND, LoadImage("backgroundend.png"))
	SetSpriteSize(OVER_BACKGROUND, W+100, H+100)
	SetSpritePosition(OVER_BACKGROUND, -50, -50)
	
endfunction

/*
Shows the game over state
*/
function showOver()
	SetViewOffset(0, 0)
	SetViewZoomMode(1)
	SetSpriteDepth(RETRY_BUTTON, 1)
	SetSpriteDepth(OVER_BACKGROUND, 2)
	
	print("Showing over screen")
	
	// Transition game state
	if(GetPointerReleased())
		if(GetSpriteHitTest(RETRY_BUTTON, GetPointerX(), GetPointerY()))
			SetSpriteDepth(RETRY_BUTTON, 9999)
			SetSpriteDepth(OVER_BACKGROUND, 9999)
			resetGame()
			state = GAME
		endif
	endif
	
endfunction

/*
Reset the game.
*/
function resetGame()
	drawMap(map_w, map_h)
	SetViewZoomMode(1)
	SetSpritePosition(SHEEP, 120, 5100)
	PlaySprite(SHEEP, 10, 1, 1, 8)
	totalFollow = 0
	score = 0
	scoreFlag = FALSE
	SetTextString(scoretext, str(0))
	
endfunction
