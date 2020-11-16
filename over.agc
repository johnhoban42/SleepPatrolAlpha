#include "constants.agc"
#include "follower.agc"
#include "mapLoad.agc"
#include "main.agc"

/*
Initialize all game over assets when the game loads 
*/
function initOver()
	
	CreateSprite(RETRY_BUTTON, LoadImage("retry.png"))
	SetSpriteSize(RETRY_BUTTON, 266, 233)
	SetSpritePosition(RETRY_BUTTON, W/2 - GetSpriteWidth(RETRY_BUTTON)/2-50, 500)
	FixSpriteToScreen(RETRY_BUTTON, 1)
	
	CreateSprite(OVER_BACKGROUND, LoadImage("backgroundend.png"))
	SetSpriteSize(OVER_BACKGROUND, W+100, H+100)
	SetSpritePosition(OVER_BACKGROUND, -50, -50)
	FixSpriteToScreen(OVER_BACKGROUND, 1)
	
	if score > highScore
		highScore = score
	endif
	
	CreateText(endScoreText, "Sleep Score: " + Str(score))
	FixTextToScreen(endScoreText, 1)
	
	CreateText(highScoreText, "High Score: " + Str(highScore))
	FixTextToScreen(highScoreText, 1)
	//Need to fix, resize
	
	
	
	//Particle effect for when transitioning
	
endfunction

/*
Shows the game over state
*/
function showOver()
	SetViewOffset(0, 0)
	SetSpriteDepth(RETRY_BUTTON, 1)
	SetSpriteDepth(OVER_BACKGROUND, 2)
	
	//print("Showing over screen")
	
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
	SetViewZoom(1)
	SetSpritePosition(SHEEP, 120, 5100)
	PlaySprite(SHEEP, 10, 1, 1, 8)
	totalFollow = 0
	score = 0
	scoreFlag = FALSE
	DeleteText(endScoreText)
	DeleteText(highScoreText)
	SetTextString(scoretext, str(0))
	gameTime = 0
	remSleep = 0
	SetSpriteColor(1, 255, 255, 255, 255)
endfunction
