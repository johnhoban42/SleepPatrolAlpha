
// Sheep velocity
global velocityX as float


global velocityY as float

// Whether the sheep is on the ground
global jumping = 0
global doubleJump = 0
global oneLoop = 0
global touchedPillow = 0


/*
Initiate a jump if the sheep is on the ground.
*/
function jump()
	if(jumping = FALSE)
		velocityY = -8.1
		//print(velocityY)
		jumping = TRUE
		PlaySound(jumpS)
		sheepHistory[1].sound = jumpS
	elseif (doubleJump = FALSE)
		if velocityY < -2
			inc velocityY, -2
		else
			velocityY = -5
		endif
		doubleJump = TRUE
		if sheepFlip
			SetSpriteAngle(1, 345)
		else
			SetSpriteAngle(1, 15)
		endif
		PlaySound(dJumpS)
		oneLoop = 1
		//SetSpriteAngle(SHEEP, 0)
		sheepHistory[1].sound = dJumpS
	endif
endfunction

/*
Move the sheep and its shadowin both X and Y
*/
function move()
	
	//Variable for quick speed adjustments
	physicsSpeedUp# = 1.1
	
	// Moves sheep horizontally (scrolls)
	if soonLose# = 0
		SetSpriteX(SHEEP, GetSpriteX(SHEEP) + velocityX*physicsSpeedUp#*fpsr#+remSleep*velocityX*.2)
		SetSpriteX(SHADOW, GetSpriteX(SHEEP))
	endif
	
	//Print(oneLoop)
	
	if(GetPointerPressed() or GetRawKeyPressed(32))
		jump()
	endif
	
	// Freefall
	if(jumping)
		SetSpriteY(SHEEP, GetSpriteY(SHEEP) + velocityY*fpsr#)
		SetSpriteY(SHADOW, GetSpriteY(SHEEP) + GetSpriteHeight(SHEEP))
		velocityY = velocityY + 5.6/30*physicsSpeedUp#*fpsr#
		if abs(velocityY) > 3
			PlaySprite(SHEEP, 12, 0, 9, 9)
		else
			PlaySprite(SHEEP, 12, 0, 10, 10)
		endif
		if oneLoop = 0
			if sheepFlip = 0
				SetSpriteAngle(SHEEP, 360+velocityY*2.9)
			else
				SetSpriteAngle(SHEEP, 360-velocityY*2.9)
			endif
		endif
	else
		SetSpriteY(SHADOW, GetSpriteY(SHEEP) + GetSpriteHeight(SHEEP))
		if((GetSpriteHitGroup(GROUND, GetSpriteX(SHADOW), GetSpriteY(SHADOW)+GetSpriteHeight(SHADOW)) or GetSpriteHitGroup(GROUND, GetSpriteX(SHADOW)+GetSpriteWidth(SHADOW), GetSpriteY(SHADOW)+GetSpriteHeight(SHADOW)) = 0))
			jumping = TRUE
			doubleJump = TRUE
		endif
		SetSpriteAngle(SHEEP, 0)
	endif
	
	// On collision with the ground, stop falling and match the sheep's Y with the ground
	g = GetSpriteHitGroup(10, GetSpriteX(SHEEP) + GetSpriteWidth(SHEEP)/2, GetSpriteY(SHEEP) + GetSpriteHeight(SHEEP))
	if(g) and soonLose# = 0
		jumping = FALSE
		doubleJump = FALSE
		SetSpriteY(SHEEP, GetSpriteY(g) - GetSpriteHeight(SHEEP))
		if scoreFlag
			scoreIncrement()
			sheepHistory[1].scored = TRUE
		endif
		scoreFlag = FALSE
		if GetSpritePlaying(SHEEP) = 0 then PlaySprite(SHEEP, 12, 1, 1, 8)
		oneLoop = 0
		velocityY = 0
	endif
	
	//Whenever touching a Pillow
	if GetSpriteHitGroup(14, GetSpriteX(1)+GetSpriteWidth(1)/2, GetSpriteY(1)+GetSpriteHeight(1)/2) and touchedPillow <> GetSpriteHitGroup(14, GetSpriteX(1)+GetSpriteWidth(1)/2, GetSpriteY(1)+GetSpriteHeight(1)/2)
		PillowTouch()
		spr = GetSpriteHitGroup(14, GetSpriteX(1)+GetSpriteWidth(1)/2, GetSpriteY(1)+GetSpriteHeight(1)/2)
		
		if velocityY <= 0
			//Running into the pillow from the side
			if sheepFlip
				sheepFlip = 0
			else
				sheepFlip = 1
			endif
			SetSpriteFlip(1, sheepFlip, 0)
			velocityX = -velocityX
			
			SetSpriteX(SHEEP, GetSpriteX(SHEEP) + velocityX*physicsSpeedUp#*fpsr#)
			SetSpriteX(SHADOW, GetSpriteX(SHEEP))
			velocityY = -2
			SetSpriteY(SHEEP, GetSpriteY(SHEEP) + velocityY*fpsr#)
			SetSpriteY(SHADOW, GetSpriteY(SHEEP) + GetSpriteHeight(SHEEP))
			jumping = TRUE
			doubleJump = FALSE
		else
			//For when the sheep bounces off of the pillow
			velocityY = -7
			SetSpriteY(SHEEP, GetSpriteY(SHEEP) + velocityY*fpsr#)
			SetSpriteY(SHADOW, GetSpriteY(SHEEP) + GetSpriteHeight(SHEEP))
			jumping = TRUE
			doubleJump = FALSE
		endif
		
	endif
	
	//Visual Effects for the pillow that was last touched
	if touchedPillow <> 0
		spr = touchedPillow
		SetSpriteSize(spr, GetSpriteWidth(spr)-pShrink*2, GetSpriteHeight(spr)-pShrink*2)
		SetSpritePosition(spr, GetSpriteX(spr)+pShrink*1, GetSpriteY(spr)+pShrink*1)
		
		if Mod(GetSpriteAngle(spr), 360) <> 0
			if sheepFlip = 0
				SetSpriteAngle(spr, GetSpriteAngle(spr)-pShrink*3)
			else
				SetSpriteAngle(spr, GetSpriteAngle(spr)+pShrink*3)
			endif
		endif
		
		//If effects are done
		if GetSpriteWidth(spr) <= 64
			touchedPillow = 0
		endif
	endif
	
	//Bonus visual movement stuff
	if GetSpriteAngle(1) <> 0 and oneLoop
		mult = 1
		//if jumping = FALSE then mult = 2 
		if sheepFlip
			SetSpriteAngle(1, Round(GetSpriteAngle(1))-15*mult)
			//SetSpriteAngle(1, 0)
		else
			SetSpriteAngle(1, Round(GetSpriteAngle(1))+15*mult)
			//SetSpriteAngle(1, 0)
		endif
		if GetSpriteAngle(1) = 360
			SetSpriteAngle(1, 0)	
		endif
		
		if GetSpriteAngle(1) = 0 then oneLoop = 0
		
		//Print(GetSpriteAngle(1))
	endif
	
endfunction

function PillowTouch()
	touchedPillow = GetSpriteHitGroup(14, GetSpriteX(1)+GetSpriteWidth(1)/2, GetSpriteY(1)+GetSpriteHeight(1)/2)
	spr = touchedPillow
	
	SetSpriteSize(spr, GetSpriteWidth(spr)+pShrink*20, GetSpriteHeight(spr)+pShrink*20)
	SetSpritePosition(spr, GetSpriteX(spr)-pShrink*10, GetSpriteY(spr)-pShrink*10)
	
	//This angle changing triggers if the sheep is on level with the pillow
	if velocityY <= 0
		if sheepFlip = 0
			SetSpriteAngle(spr, 360-pShrink*30)
		else
			SetSpriteAngle(spr, pShrink*30)
		endif
	endif
	
	//Print(GetSpriteY(SHEEP))
	//Print(GetSpriteY(spr))
	
	//Sync()
	//Sleep(4000)
	
	//This is where the pillow code will go
	
	//print ("BaaAaaaA!")
	
endfunction
