global totalFollow = 0

global follow as integer[2]
dim follow[totalFollow]

global sheepHistory as history[400]
global followDistance = 40

type history
	x as integer
	y as integer
	anim as integer
	scored as integer
	angle as integer
	flip as integer
	sound as integer
	r as integer
	g as integer
	b as integer
endtype

/*global w1 = 41
global w2 = 42
global w3 = 43
global w4 = 44
global w5 = 45
global w6 = 46
global w7 = 47
global w8 = 48
global j1 = 49
global j2 = 50

LoadImage(w1, "walk1.png")
LoadImage(w2, "walk2.png")
LoadImage(w3, "walk3.png")
LoadImage(w4, "walk4.png")
LoadImage(w5, "walk5.png")
LoadImage(w6, "walk5.png")
LoadImage(w7, "walk6.png")
LoadImage(w8, "walk7.png")
LoadImage(j1, "jump1.png")
LoadImage(j2, "jump2.png")*/

function CreateNewSheep()
	inc totalFollow, 1
	
	dim follow[totalFollow]
	
	spr = totalFollow+1
	if spr > 19 then spr = spr + 3000
	
	// Load sprites and animations
	if GetSpriteExists(spr) = 0
		CreateSprite(spr, 0)
	endif
	if GetSpriteExists(spr+70) = 0
		CreateSprite(spr+70, 0)
	endif
	SetSpriteSize(spr, GetSpriteWidth(1), GetSpriteHeight(1))
	//AddSpriteAnimationFrame(spr, LoadImage("SheepTemp.png"))
	SetSpriteGroup(spr, 1)
	SetSpriteDepth(spr, 10+totalFollow)
	LoadSheepAnimation(spr)

	followDistance = (22 - (totalFollow*1.5))/fpsr#
	if followDistance < 5 then followDistance = 5
	
	if totalFollow = 12
		remSleep = 1
		if crabMode = 1 then PlaySprite(SHEEP, 12, 1, 1+(remSleep*10), 8+(remSleep*10))
	endif
	
	SetSpriteSize(spr+70, GetSpriteWidth(1), GetSpriteHeight(1))
	SetSpriteVisible(spr+70, 0)
	SetSpriteDepth(spr+70, 10+totalFollow)
	if remSleep then SetSpriteVisible(spr+70, 1)

	if crabMode then LoadCrabAnimation(spr)
	
	for i = 1 to 200
		sheepHistory[i].anim = 1
		if crabMode = 1 then sheepHistory[i].anim = 1 + remSleep*10
	next i

endfunction

function TrackSheep()
	
	for i = 200 to 2 step -1
		sheepHistory[i] = sheepHistory[i-1]
	next i
	
	sheepHistory[1].x = GetSpriteX(1)
	sheepHistory[1].y = GetSpriteY(1)
	sheepHistory[1].anim = GetSpriteCurrentFrame(1)
	sheepHistory[1].scored = FALSE
	sheepHistory[1].angle = GetSpriteAngle(1)
	sheepHistory[1].flip = sheepFlip
	sheepHistory[1].sound = 0
	sheepHistory[i].r = GetSpriteColorRed(1)
	sheepHistory[i].g = GetSpriteColorGreen(1)
	sheepHistory[i].b = GetSpriteColorBlue(1)
	
endfunction

function UpdateFollowers()
	
	for i = 1 to totalFollow
		spr = i+1
		if spr > 19 then spr = spr + 3000
		SetSpritePosition(spr, sheepHistory[i*followDistance].x, sheepHistory[i*followDistance].y)
		SetSpriteAngle(spr, sheepHistory[i*followDistance].angle)
		SetSpriteFrame(spr, sheepHistory[i*followDistance].anim)
		SetSpriteFlip(spr, sheepHistory[i*followDistance].flip, 0)
		if sheepHistory[i*followDistance].scored then scoreIncrement()
		if sheepHistory[i*followDistance].sound <> 0 then PlaySound(sheepHistory[i*followDistance].sound, 60-5*i)
		SetSpriteColor(spr, sheepHistory[i*followDistance].r, sheepHistory[i*followDistance].g, sheepHistory[i*followDistance].b, 255)
	next i
	
	for i = 71 to totalFollow+70
		spr = i+1
		if spr > 19+70 then spr = spr + 3000
		i = i-70
		SetSpritePosition(spr, sheepHistory[i*followDistance].x, sheepHistory[i*followDistance].y)
		SetSpriteAngle(spr, sheepHistory[i*followDistance].angle)
		
		if crabMode = 0 or remSleep = 0
			SetSpriteFrame(spr, sheepHistory[i*followDistance].anim)
		else
			SetSpriteFrame(spr, sheepHistory[i*followDistance].anim-10)
		endif
		
		SetSpriteFlip(spr, sheepHistory[i*followDistance].flip, 0)
		i = i+70
	next i
		
	//Print(followDistance)
endfunction
