#include "constants.agc"
#include "follower.agc"
#include "mapLoad.agc"
#include "main.agc"

/*
Initialize all game over assets when the game loads 
*/
function initOver()
	
	DeleteSprite(moon)
	DeleteSprite(moonbar)
	DeleteText(scoretext)
	
	if GetMusicPlayingOgg(gameS) then StopMusicOGG(gameS)
	//PlayMusicOGG(gameOverB, 0)
	
	CreateSprite(RETRY_BUTTON, LoadImage("retry.png"))
	SetSpriteSize(RETRY_BUTTON, 266, 233)
	SetSpritePosition(RETRY_BUTTON, W/2 - GetSpriteWidth(RETRY_BUTTON)/2-50, 700)
	FixSpriteToScreen(RETRY_BUTTON, 1)
	
	CreateSprite(OVER_BACKGROUND, LoadImage("backgroundend.png"))
	SetSpriteSize(OVER_BACKGROUND, W+100, H+100)
	SetSpritePosition(OVER_BACKGROUND, -50, -50)
	FixSpriteToScreen(OVER_BACKGROUND, 1)
	
	if score > highScore
		highScore = score
	endif
	
	
	CreateSprite(score_cloud_1, LoadImage("cloud.png"))
	SetSpriteSize(score_cloud_1, 500, 90)
	SetSpritePosition(score_cloud_1, 60, 380)
	FixSpriteToScreen(score_cloud_1, 1)
	SetSpriteDepth(score_cloud_1, 2)
	
	CreateText(endScoreText, "Sleep Score: " + Str(score))
	FixTextToScreen(endScoreText, 1)
	SetTextSize(endScoreText, 49)
	SetTextPosition(endScoreText, 220, 410)
	SetTextColor(endScoreText, 0, 0, 0, 255)
	SetTextAlignment(endScoreText, 1)
	SetTextDepth(endScoreText, 2)
	
	
	CreateSprite(score_cloud_2, LoadImage("cloud.png"))
	SetSpriteSize(score_cloud_2, 500, 90)
	SetSpritePosition(score_cloud_2, 60, 480)
	FixSpriteToScreen(score_cloud_2, 1)
	SetSpriteDepth(score_cloud_2, 2)
	
	CreateText(highScoreText, "High Score: " + Str(highScore))
	FixTextToScreen(highScoreText, 1)
	SetTextSize(highScoreText, 49)
	SetTextPosition(highScoreText, 220, 510)
	SetTextColor(highScoreText, 0, 0, 0, 255)
	SetTextAlignment(highScoreText, 1)
	SetTextDepth(highScoreText, 2)
	
	
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
	
	SetSpriteAngle(RETRY_BUTTON, 6.0*cos(startMenuCycle#*4))
	SetSpriteSize(RETRY_BUTTON, 266+9*sin(startMenuCycle#*3), 233+7*cos(startMenuCycle#*5))
	SetSpritePosition(RETRY_BUTTON, w/2-GetSpriteWidth(RETRY_BUTTON)/2-50, 750-GetSpriteHeight(RETRY_BUTTON)/2)
	
	
	SetSpriteAngle(score_cloud_1, 2.0*cos(startMenuCycle#*3))
	SetSpriteSize(score_cloud_1, 500+14*sin(startMenuCycle#*3), 90+4*cos(startMenuCycle#*5))
	SetSpritePosition(score_cloud_1, 300-GetSpriteWidth(score_cloud_1)/2-50, 440-GetSpriteHeight(score_cloud_1)/2)
	SetTextAngle(endScoreText, GetSpriteAngle(score_cloud_1))
	
	SetSpriteAngle(score_cloud_2, 2.0*cos(startMenuCycle#*2))
	SetSpriteSize(score_cloud_2, 500+14*sin(startMenuCycle#*3), 90+3*cos(startMenuCycle#*5))
	SetSpritePosition(score_cloud_2, 300-GetSpriteWidth(score_cloud_2)/2-50, 540-GetSpriteHeight(score_cloud_2)/2)
	SetTextAngle(highScoreText, GetSpriteAngle(score_cloud_2))
	
	
	inc startMenuCycle#, 1*fpsr#
	if startMenuCycle# > 720 then inc startMenuCycle#, -720
	
	// Transition game state
	if(GetPointerReleased())
		if(GetSpriteHitTest(RETRY_BUTTON, GetPointerX(), GetPointerY()))
			if gameTime# < gameTimeMax	//Bad end, instant restart
				resetGame()
				state = GAME
			else	//Good end, next night
				NextNight()
				state = MENU
			endif
			
		endif
	endif
	
endfunction

/*
Reset the game.
*/
function resetGame()
	if GetMusicPlayingOGG(gameOverB) then StopMusicOGG(gameOverB)
	Transition()
	PlayMusicOGG(introS, 0)
	for i = 1 to 90/fpsr#
		SetSpriteAngle(RETRY_BUTTON, 6.0*cos(startMenuCycle#*4))
		SetSpriteSize(RETRY_BUTTON, 266+9*sin(startMenuCycle#*3), 233+7*cos(startMenuCycle#*5))
		SetSpritePosition(RETRY_BUTTON, w/2-GetSpriteWidth(RETRY_BUTTON)/2-50, 750-GetSpriteHeight(RETRY_BUTTON)/2)
		
		inc startMenuCycle#, 1
		if startMenuCycle# > 720 then inc startMenuCycle#, -720
		Sync()
	next i
	SetViewOffset(0, 4700)
	drawMap(map_w, map_h)
	SetViewZoom(1)
	SetSpritePosition(SHEEP, 120, 5100)
	PlaySprite(SHEEP, 10, 1, 1, 8)
	velocityY = 0
	totalFollow = 0
	score = 0
	scoreFlag = FALSE
	DeleteText(endScoreText)
	DeleteText(highScoreText)
	for i = 2 to 30
		if GetSpriteExists(i) then SetSpritePosition(i, 9999, 9999)
	next i
	gameTime# = 0
	remSleep = 0
	SetSpriteColor(1, 255, 255, 255, 255)
	DeleteSprite(201)
	DeleteSprite(200)
	DeleteSprite(score_cloud_1)
	DeleteSprite(score_cloud_2)
	DeleteText(endScoreText)
	DeleteText(highScoreText)
	CreateInGameScore()
	
	
	
	
	
endfunction

function NextNight()
	
	CreateSprite(175, 0)
	SetSpriteSize(175, w, h)
	SetSpritePosition(175, w, 0)
	PlaySound(fwip)
	SetSpriteDepth(175, 1)
	SetSpriteColor(175, 0, 0, 0, 255)
	for i = 1 to 20
		SetSpriteX(175, (20-i)*h/20.0)
		Sync()
	next i
	
	DeleteSprite(START_BUTTON)
	DeleteSprite(MENU_BACKGROUND)
	DeleteSprite(LOGO)
	for i = 2 to 30
		if GetSpriteExists(i) then SetSpritePosition(i, 9999, 9999)
	next i
	SetViewZoom(1)
	totalFollow = 0
	score = 0
	scoreFlag = FALSE
	DeleteText(endScoreText)
	DeleteText(highScoreText)
	gameTime# = 0
	remSleep = 0
	SetSpriteColor(1, 255, 255, 255, 255)
	DeleteSprite(201)
	DeleteSprite(200)
	DeleteSprite(score_cloud_1)
	DeleteSprite(score_cloud_2)
	DeleteText(endScoreText)
	DeleteText(highScoreText)
	
	PlayMusicOGG(titleS, 1)
	initMenu()
	showMenu()
	
	SetSpriteDepth(175, 1)
	
	PlaySound(fwip)
	for i = 1 to 20
		SetSpriteX(175, (0-i)*h/20.0)
		Sync()
	next i
	DeleteSprite(175)

endfunction
