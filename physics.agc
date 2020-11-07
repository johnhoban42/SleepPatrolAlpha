#include "constants.agc"

// Sheep velocity
global velocityX as float
global velocityY as float

// Whether the sheep is on the ground
global jumping = 0

/*
Initiate a jump if the sheep is on the ground.
*/
function jump()
	if(jumping = FALSE)
		velocityY = -2
		print(velocityY)
		jumping = TRUE
	endif
endfunction

/*
Move the sheep in both X and Y
*/
function move()
	// Freefall
	if(jumping)
		SetSpriteY(SHEEP, GetSpriteY(SHEEP) + velocityY)
		print(GetSpriteY(SHEEP))
		velocityY = velocityY + 5.0/60
		print(velocityY)
	endif
	// On collision with the ground, stop falling and match the sheep's Y with the ground
	g = GetSpriteHitGroup(10, GetSpriteX(SHEEP) + GetSpriteWidth(SHEEP)/2, GetSpriteY(SHEEP) + GetSpriteHeight(SHEEP))
	if(g)
		jumping = FALSE
		SetSpriteY(SHEEP, GetSpriteY(g) - GetSpriteHeight(SHEEP))
	endif
endfunction
