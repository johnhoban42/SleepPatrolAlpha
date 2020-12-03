
global map_w as integer
global map_h as integer

function importFromPNG()
	
	mem = CreateMemblockFromImage(LoadImage("map1.png"))
	map_w = GetMemblockInt(mem, 0)
	map_h = GetMemblockInt(mem, 4)
	
	global map as integer[2,2]
	dim map[map_w, map_h]
	
	for i = 1 to map_w
		for j = 1 to map_h
			blockPos = 12+((i-1)+(j-1)*map_w)*4
			if GetMemblockByte(mem, blockPos) = 255 and GetMemblockByte(mem, blockPos+1) = 255 and GetMemblockByte(mem, blockPos+2) = 255
				map[i, j] = 1	//Ground
			elseif GetMemblockByte(mem, blockPos) = 255 and GetMemblockByte(mem, blockPos+1) = 0 and GetMemblockByte(mem, blockPos+2) = 0
				map[i, j] = 2	//Fence
			elseif GetMemblockByte(mem, blockPos) = 0 and GetMemblockByte(mem, blockPos+1) = 255 and GetMemblockByte(mem, blockPos+2) = 0
				map[i, j] = 3	//Extra Sheep
			elseif GetMemblockByte(mem, blockPos) = 0 and GetMemblockByte(mem, blockPos+1) = 0 and GetMemblockByte(mem, blockPos+2) = 255
				map[i, j] = 4	//Turn Around
			endif
		next j
	next i
	
	drawMap(map_w, map_h)
	
endfunction


function drawMap(wid, hei)
	
	for i = 1 to wid
		for j = 1 to hei
			if map[i, j] = 1	//Ground
				spr = 1000+i+j*(wid)
				if(GetSpriteExists(spr) = 0)
					img = LoadImage("groundgrass2.png")
					CreateSprite(spr, img)
					SetSpriteSize(spr, 64, 64)
					SetSpritePosition(spr, 100 + (i-1)*64, 100 + (j-1)*64)
					SetSpriteGroup(spr, 10)
					SetSpriteDepth(spr, 12)
					SetSpriteColor(spr, 180, 180, 180, 255)
				endif
				
			elseif map[i, j] = 2	//Fence
				spr = 1000+i+j*(wid)
				if(GetSpriteExists(spr) = 0)
					CreateSprite(spr, LoadImage("fence.png"))
					SetSpriteSize(spr, 64, 64)
					SetSpritePosition(spr, 100 + (i-1)*64, 100 + (j-1)*64+16)
					SetSpriteGroup(spr, 11)
					SetSpriteDepth(spr, 10)
				endif
			
				spr = 1000+i+j*(wid)+100000
				if(GetSpriteExists(spr) = 0)
					CreateSprite(spr, 0)
					SetSpriteSize(spr, 64, 64*4)
					SetSpritePosition(spr, 100 + (i-1)*64, 100 + (j-5)*64)
					SetSpriteGroup(spr, 12)
					SetSpriteColorAlpha(spr, 0)
				endif
				
			elseif map[i, j] = 3	//Extra Sheep
				spr = 1000+i+j*(wid)

				if(GetSpriteExists(spr) = 0)
					CreateSprite(spr, LoadImage("SheepTemp.png"))
										
					AddSpriteAnimationFrame(spr, LoadImage("sleepsheep1.png"))
					AddSpriteAnimationFrame(spr, LoadImage("sleepsheep2.png"))
					AddSpriteAnimationFrame(spr, LoadImage("sleepsheep3.png"))
					AddSpriteAnimationFrame(spr, LoadImage("sleepsheep4.png"))
					AddSpriteAnimationFrame(spr, LoadImage("sleepsheep5.png"))
					AddSpriteAnimationFrame(spr, LoadImage("sleepsheep6.png"))
					AddSpriteAnimationFrame(spr, LoadImage("sleepsheep7.png"))
					AddSpriteAnimationFrame(spr, LoadImage("sleepsheep8.png"))
				
				endif
				
				SetSpriteSize(spr, 90, 78)
				SetSpritePosition(spr, 100 + (i-1)*64, 100 + (j-1)*64-10)
				SetSpriteGroup(spr, EXTRA_SHEEP)
				SetSpriteDepth(spr, 10)
				
				PlaySprite(spr, 10, 1, 1, 8)

					
			elseif map[i, j] = 4 // reverse sign
				spr = 1000+i+j*(wid)
				if(GetSpriteExists(spr) = 0)
					CreateSprite(spr, LoadImage("pillow.png"))
					SetSpriteSize(spr, 64, 64)
					SetSpritePosition(spr, 100 + (i-1)*64, 100 + (j-1)*64)
					SetSpriteGroup(spr, 14)
					SetSpriteDepth(spr, 9)
				endif
				
			
			endif
			
			
		next j
	next i
	
endfunction
