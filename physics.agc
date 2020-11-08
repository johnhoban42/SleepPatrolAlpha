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
		velocityY = -8
		print(velocityY)
		jumping = TRUE
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
	endif
endfunction

/*
Move the sheep and its shadowin both X and Y
*/
function move()
	
	// Moves sheep horizontally (scrolls)
	
	SetSpriteX(SHEEP, GetSpriteX(SHEEP) + velocityX)
	SetSpriteX(SHADOW, GetSpriteX(SHEEP))
	
	// Freefall
	if(jumping)
		SetSpriteY(SHEEP, GetSpriteY(SHEEP) + velocityY)
		SetSpriteY(SHADOW, GetSpriteY(SHEEP) + GetSpriteHeight(SHEEP))
		velocityY = velocityY + 5.6/30
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
		if sheepFlip
			SetSpriteAngle(1, Round(GetSpriteAngle(1))-8)
			//SetSpriteAngle(1, 0)
		else
			SetSpriteAngle(1, Round(GetSpriteAngle(1))+8)
			//SetSpriteAngle(1, 0)
		endif
		if GetSpriteAngle(1) = 360 then SetSpriteAngle(1, 0)
		Print(GetSpriteAngle(1))
	endif
	
endfunction

function sheepTurn()
	
	velocityX = -velocityX
	
	print ("BaaAaaaA!")
	
endfunction


