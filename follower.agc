global totalFollow = 0

global follow as integer[2]
dim follow[totalFollow]

global sheepHistory as history[200]

type history
	x as integer
	y as integer
	anim as integer
endtype

function CreateNewSheep()
	inc totalFollow, 1
	
	dim follow[totalFollow]
	
	spr = totalFollow+1
	if GetSpriteExists(spr) = 0 then CreateSprite(spr, LoadImage("bananaReal.png"))
	SetSpriteSize(spr, GetSpriteWidth(1), GetSpriteHeight(1))

endfunction

function TrackSheep()
	
	for i = 1 to 199
		sheepHistory[i].x = sheepHistory[i+1].x 
		sheepHistory[i].y = sheepHistory[i+1].y
		sheepHistory[i].anim = sheepHistory[i+1].anim
	next i
	
	sheepHistory[1].x = GetSpriteX(1)
	sheepHistory[1].y = GetSpriteY(1)
	sheepHistory[1].anim = GetSpriteCurrentFrame(1)
	
endfunction

function UpdateFollowers()
	
	for i = 1 to totalFollow
		spr = i+1
		SetSpritePosition(spr, sheepHistory[i*10].x, sheepHistory[i*10].y)
		SetSpriteFrame(spr, sheepHistory[i*10].anim)
	next i
		
	
endfunction
