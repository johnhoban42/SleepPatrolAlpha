#include "constants.agc"

// Sheep velocity
global velocityX as float


global velocityY as float

// Whether the sheep is on the ground
global jumping = 0
global doubleJump = 0

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
			SetSpriteAngle(1, 352)
		else
			SetSpriteAngle(1, 8)
		endif
		PlaySound(dJumpS)
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
	SetSpriteX(SHEEP, GetSpriteX(SHEEP) + velocityX*physicsSpeedUp#)
	SetSpriteX(SHADOW, GetSpriteX(SHEEP))
	
	
	if(GetPointerPressed() or GetRawKeyPressed(32))
		jump()
	endif
	
	// Freefall
	if(jumping)
		SetSpriteY(SHEEP, GetSpriteY(SHEEP) + velocityY)
		SetSpriteY(SHADOW, GetSpriteY(SHEEP) + GetSpriteHeight(SHEEP))
		velocityY = velocityY + 5.6/30*physicsSpeedUp#
	else
		SetSpriteY(SHADOW, GetSpriteY(SHEEP) + GetSpriteHeight(SHEEP))
		if((GetSpriteHitGroup(GROUND, GetSpriteX(SHADOW), GetSpriteY(SHADOW)+GetSpriteHeight(SHADOW)) or GetSpriteHitGroup(GROUND, GetSpriteX(SHADOW)+GetSpriteWidth(SHADOW), GetSpriteY(SHADOW)+GetSpriteHeight(SHADOW)) = 0))
			jumping = TRUE
			doubleJump = TRUE
		endif
	endif
	
	// On collision with the ground, stop falling and match the sheep's Y with the ground
	g = GetSpriteHitGroup(10, GetSpriteX(SHEEP) + GetSpriteWidth(SHEEP)/2, GetSpriteY(SHEEP) + GetSpriteHeight(SHEEP))
	if(g)
		jumping = FALSE
		doubleJump = FALSE
		SetSpriteY(SHEEP, GetSpriteY(g) - GetSpriteHeight(SHEEP))
		if scoreFlag
			scoreIncrement()
			sheepHistory[1].scored = TRUE
		endif
		scoreFlag = FALSE
		velocityY = 0
	endif
	
	if GetSpriteHitGroup(14, GetSpriteX(1)+GetSpriteWidth(1)/2, GetSpriteY(1)+GetSpriteHeight(1)/2)
		if sheepFlip
			sheepFlip = 0
		else
			sheepFlip = 1
		endif
		SetSpriteFlip(1, sheepFlip, 0)
		sheepTurn()
	endif
	
	//Bonus visual movement stuff
	if GetSpriteAngle(1) <> 0
		mult = 1
		//if jumping = FALSE then mult = 2 
		if sheepFlip
			SetSpriteAngle(1, Round(GetSpriteAngle(1))-8*mult)
			//SetSpriteAngle(1, 0)
		else
			SetSpriteAngle(1, Round(GetSpriteAngle(1))+8*mult)
			//SetSpriteAngle(1, 0)
		endif
		if GetSpriteAngle(1) = 360 then SetSpriteAngle(1, 0)
		//Print(GetSpriteAngle(1))
	endif
	
endfunction

function sheepTurn()
	
	velocityX = -velocityX
	
	//print ("BaaAaaaA!")
	
endfunction


