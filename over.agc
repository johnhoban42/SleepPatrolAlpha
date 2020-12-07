
/*
Initialize all game over assets when the game loads 
*/
function initOver()
	
	SetViewZoom(1)
	
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
	SaveGame()
	
	
	CreateSprite(score_cloud_1, LoadImage("cloudtext.png"))
	SetSpriteSize(score_cloud_1, 400, 90)
	SetSpritePosition(score_cloud_1, 90, 340)
	FixSpriteToScreen(score_cloud_1, 1)
	SetSpriteDepth(score_cloud_1, 2)
	
	CreateText(endScoreText, "Sleep Score: " + Str(score))
	FixTextToScreen(endScoreText, 1)
	SetTextSize(endScoreText, 40)
	SetTextPosition(endScoreText, 240, 380)
	SetTextColor(endScoreText, 75, 0, 128, 255)
	SetTextAlignment(endScoreText, 1)
	SetTextDepth(endScoreText, 2)
	SetTextFontImage(endScoreText, font)
	
	
	CreateSprite(score_cloud_2, LoadImage("cloudtext.png"))
	SetSpriteSize(score_cloud_2, 400, 90)
	SetSpritePosition(score_cloud_2, 90, 440)
	FixSpriteToScreen(score_cloud_2, 1)
	SetSpriteDepth(score_cloud_2, 2)
	
	CreateText(highScoreText, "High Score: " + Str(highScore))
	FixTextToScreen(highScoreText, 1)
	SetTextSize(highScoreText, 40)
	SetTextPosition(highScoreText, 240, 480)
	SetTextColor(highScoreText, 75, 0, 128, 255)
	SetTextAlignment(highScoreText, 1)
	SetTextDepth(highScoreText, 2)
	SetTextFontImage(highScoreText, font)
	
	
	CreateSprite(mission1, LoadImage("patrol.png"))
	SetSpritePosition(mission1, w/2-GetSpriteWidth(mission1)/2-2000, 80)
	FixSpriteToScreen(mission1, 1)
	SetSpriteDepth(mission1, 2)
	
	CreateSprite(mission2, LoadImage("over.png"))
	SetSpritePosition(mission2, w/2-GetSpriteWidth(mission2)/2+3000, 80)
	FixSpriteToScreen(mission2, 1)
	SetSpriteDepth(mission2, 2)
	
	if gameTime# < gameTimeMax
		SetSpriteImage(mission1, LoadImage("mission.png"))
		SetSpriteImage(mission2, LoadImage("failed.png"))
	endif
	
	CreateSprite(leaderboard_cloud, LoadImage("leaderboard.png"))
	SetSpriteSize(leaderboard_cloud, 213, 111)
	SetSpritePosition(leaderboard_cloud, 390, 556)
	FixSpriteToScreen(leaderboard_cloud, 1)
	SetSpriteDepth(leaderboard_cloud, 2)
	
	CreateSprite(score_cloud_new, LoadImage("New.png"))
	SetSpriteSize(score_cloud_new, 100, 66)
	SetSpritePosition(score_cloud_new, 310, 520)
	FixSpriteToScreen(score_cloud_new, 1)
	SetSpriteDepth(score_cloud_new, 2)
	
	if highScore > score then SetSpriteVisible(score_cloud_new, 0)
	
endfunction

/*
Shows the game over state
*/
function showOver()
	SetViewOffset(0, 0)
	SetSpriteDepth(RETRY_BUTTON, 1)
	SetSpriteDepth(OVER_BACKGROUND, 2)
	
	//print("Showing over screen")
	if (GetSpriteX(mission1) < w/2-GetSpriteWidth(mission1)/2)
		SetSpriteX(mission1, GetSpriteX(mission1)+50)
		if (GetSpriteX(mission1) >= w/2-GetSpriteWidth(mission1)/2) then PlaySound(clang, 70)
	endif
	
	if (GetSpriteX(mission2) > w/2-GetSpriteWidth(mission2)/2)
		SetSpriteX(mission2, GetSpriteX(mission2)-50)
		if (GetSpriteX(mission2) <= w/2-GetSpriteWidth(mission2)/2) then PlaySound(clang, 70)
	endif
	
	
	if gameTime# < gameTimeMax
		SetSpriteAngle(RETRY_BUTTON, 6.0*cos(startMenuCycle#*4))
		SetSpriteSize(RETRY_BUTTON, 266+9*sin(startMenuCycle#*3), 233+7*cos(startMenuCycle#*5))
		SetSpritePosition(RETRY_BUTTON, w/2-GetSpriteWidth(RETRY_BUTTON)/2-50, 790-GetSpriteHeight(RETRY_BUTTON)/2)
	endif
	
	SetSpriteAngle(score_cloud_1, 2.0*cos(startMenuCycle#*3))
	SetSpriteSize(score_cloud_1, 400+14*sin(startMenuCycle#*3), 90+4*cos(startMenuCycle#*5))
	SetSpritePosition(score_cloud_1, 300-GetSpriteWidth(score_cloud_1)/2-50, 400-GetSpriteHeight(score_cloud_1)/2)
	SetTextAngle(endScoreText, GetSpriteAngle(score_cloud_1))
	
	SetSpriteAngle(score_cloud_2, 2.0*cos(startMenuCycle#*2))
	SetSpriteSize(score_cloud_2, 400+14*sin(startMenuCycle#*3), 90+3*cos(startMenuCycle#*5))
	SetSpritePosition(score_cloud_2, 300-GetSpriteWidth(score_cloud_2)/2-50, 500-GetSpriteHeight(score_cloud_2)/2)
	SetTextAngle(highScoreText, GetSpriteAngle(score_cloud_2))
	
	SetSpriteAngle(score_cloud_new, 10*cos(startMenuCycle#*4))
	
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
	PlayMusicOGG(gameS, 0)
	for i = 1 to 90/fpsr#
		SetSpriteAngle(RETRY_BUTTON, 6.0*cos(startMenuCycle#*4))
		SetSpriteSize(RETRY_BUTTON, 266+9*sin(startMenuCycle#*3), 233+7*cos(startMenuCycle#*5))
		SetSpritePosition(RETRY_BUTTON, w/2-GetSpriteWidth(RETRY_BUTTON)/2-50, 790-GetSpriteHeight(RETRY_BUTTON)/2)		
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
		if GetSpriteExists(i+69) then SetSpritePosition(i+69, 9999, 9999)
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
	DeleteSprite(mission1)
	DeleteSprite(mission2)
	DeleteSprite(leaderboard_cloud)
	DeleteSprite(score_cloud_new)
	CreateInGameScore()
	
	if GetSpriteExists(MENU_BACKGROUND) = 0 then CreateSprite(MENU_BACKGROUND, LoadImage("backgroundgame.png"))
	SetSpriteSize(MENU_BACKGROUND, W+100, H+100)
	//SetSpriteColor(MENU_BACKGROUND, 255, 0, 0, 255)
	SetSpritePosition(MENU_BACKGROUND, -50, -50)
	FixSpriteToScreen(MENU_BACKGROUND, 1)
	
	
	
endfunction

function NextNight()
	
	CreateSprite(175, 0)
	SetSpriteSize(175, w, h)
	SetSpritePosition(175, w, 0)
	PlaySound(fwip)
	SetSpriteDepth(175, 1)
	SetSpriteColor(175, 135, 206, 235, 255)
	for i = 1 to 20
		SetSpriteX(175, (20-i)*h/20.0)
		Sync()
	next i
	
	
	
	DeleteSprite(START_BUTTON)
	DeleteSprite(MENU_BACKGROUND)
	DeleteSprite(LOGO)
	for i = 2 to 30
		if GetSpriteExists(i) then SetSpritePosition(i, 9999, 9999)
		if GetSpriteExists(i+69) then SetSpritePosition(i+69, 9999, 9999)
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
	DeleteSprite(mission1)
	DeleteSprite(mission2)
	DeleteSprite(leaderboard_cloud)
	DeleteSprite(score_cloud_new)
	
	
	initMenu()
	showMenu()
	
	SetSpriteDepth(175, 1)
	
	CreateSprite(176, LoadImage("sun.png"))
	SetSpriteSize(176, 120, 120)
	SetSpriteDepth(176, 1)
	
	for i = 1 to 40
		SetSpriteX(176, -100 + 20*i)
		SetSpriteY(176, 210+((i*i*4)/(20))-i*8)
		if i > 15
			SetSpriteColor(175, 135+(i-15)*5, 206-(i-15)*2, 235-(i-15)*8, 255)
		endif
		Sync()
	next i
	
	PlayMusicOGG(titleS, 1)
	PlaySound(fwip)
	for i = 1 to 20
		SetSpriteX(175, (0-i)*h/20.0)
		Sync()
	next i
	
	
	
	DeleteSprite(175)
	DeleteSprite(176)

endfunction
