global totalFollow = 0

global follow as integer[2]
dim follow[totalFollow]

global sheepHistory as history[200]
global followDistace = 40

type history
	x as integer
	y as integer
	anim as integer
	scored as integer
	angle as integer
	flip as integer
endtype



function CreateNewSheep()
	inc totalFollow, 1
	
	dim follow[totalFollow]
	
	spr = totalFollow+1
	if GetSpriteExists(spr) = 0 then CreateSprite(spr, LoadImage("bananaReal.png"))
	SetSpriteSize(spr, GetSpriteWidth(1), GetSpriteHeight(1))
	//AddSpriteAnimationFrame(spr, LoadImage("SheepTemp.png"))
	SetSpriteGroup(spr, 1)
	SetSpriteDepth(spr, 10+totalFollow)
	AddSpriteAnimationFrame(spr, LoadImage("sheepwalk1.png"))
	AddSpriteAnimationFrame(spr, LoadImage("sheepwalk2.png"))
	AddSpriteAnimationFrame(spr, LoadImage("sheepwalk3.png"))
	AddSpriteAnimationFrame(spr, LoadImage("sheepwalk4.png"))
	AddSpriteAnimationFrame(spr, LoadImage("sheepwalk5.png"))
	AddSpriteAnimationFrame(spr, LoadImage("sheepwalk6.png"))
	AddSpriteAnimationFrame(spr, LoadImage("sheepwalk7.png"))
	AddSpriteAnimationFrame(spr, LoadImage("sheepwalk8.png"))
	
	
	for i = 1 to 200
	sheepHistory[i].anim = 1
	
	followDistace = 22 - (totalFollow*1.5)
next i

endfunction

function TrackSheep()
	
	for i = 200 to 2 step -1
		sheepHistory[i].x = sheepHistory[i-1].x 
		sheepHistory[i].y = sheepHistory[i-1].y
		sheepHistory[i].anim = sheepHistory[i-1].anim
		sheepHistory[i].scored = sheepHistory[i-1].scored
		sheepHistory[i].angle = sheepHistory[i-1].angle
		sheepHistory[i].flip = sheepHistory[i-1].flip
	next i
	
	sheepHistory[1].x = GetSpriteX(1)
	sheepHistory[1].y = GetSpriteY(1)
	sheepHistory[1].anim = GetSpriteCurrentFrame(1)
	sheepHistory[1].scored = FALSE
	sheepHistory[1].angle = GetSpriteAngle(1)
	sheepHistory[1].flip = sheepFlip
	
endfunction

function UpdateFollowers()
	
	for i = 1 to totalFollow
		spr = i+1
		SetSpritePosition(spr, sheepHistory[i*followDistace].x, sheepHistory[i*followDistace].y)
		SetSpriteAngle(spr, sheepHistory[i*followDistace].angle)
		SetSpriteFrame(spr, sheepHistory[i*followDistace].anim)
		SetSpriteFlip(spr, sheepHistory[i*followDistace].flip, 0)
		if sheepHistory[i*followDistace].scored then scoreIncrement()
	next i
		
	
endfunction
