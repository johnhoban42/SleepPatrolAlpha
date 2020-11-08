
function importFromPNG()
	
	mem = CreateMemblockFromImage(LoadImage("map1.png"))
	wid = GetMemblockInt(mem, 0)
	hei = GetMemblockInt(mem, 4)
	
	global map as integer[2,2]
	dim map[wid, hei]
	
	for i = 1 to wid
		for j = 1 to hei
			blockPos = 12+((i-1)+(j-1)*wid)*4
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
	
	drawMap(wid, hei)
	
endfunction


function drawMap(wid, hei)
	
	for i = 1 to wid
		for j = 1 to hei
			if map[i, j] = 1	//Ground
				spr = 1000+i+j*(wid)
				CreateSprite(spr, LoadImage("groundgrass.png"))
				SetSpriteSize(spr, 64, 64)
				SetSpritePosition(spr, 100 + (i-1)*64, 100 + (j-1)*64)
				SetSpriteGroup(spr, 10)
				SetSpriteDepth(spr, 12)
				SetSpriteColor(spr, 180, 180, 180, 255)
			elseif map[i, j] = 2	//Fence
				spr = 1000+i+j*(wid)
				CreateSprite(spr, LoadImage("fence.png"))
				SetSpriteSize(spr, 64, 64)
				SetSpritePosition(spr, 100 + (i-1)*64, 100 + (j-1)*64+16)
				SetSpriteGroup(spr, 11)
				SetSpriteDepth(spr, 10)
			
				spr = 1000+i+j*(wid)+10000
				CreateSprite(spr, 0)
				SetSpriteSize(spr, 64, 64*4)
				SetSpritePosition(spr, 100 + (i-1)*64, 100 + (j-5)*64)
				SetSpriteGroup(spr, 12)
				SetSpriteColorAlpha(spr, 0)
				
			elseif map[i, j] = 3	//Extra Sheep
				spr = 1000+i+j*(wid)
				CreateSprite(spr, LoadImage("SheepTemp.png"))
				SetSpriteSize(spr, 100, 50)
				SetSpritePosition(spr, 100 + (i-1)*64, 100 + (j-1)*64+16)
				SetSpriteGroup(spr, EXTRA_SHEEP)
				SetSpriteDepth(spr, 10)
					
			elseif map[i, j] = 4 // reverse sign
				spr = 1000+i+j*(wid)
				CreateSprite(spr, LoadImage("reverse.png"))
				SetSpriteSize(spr, 64, 64)
				SetSpritePosition(spr, 100 + (i-1)*64, 100 + (j-1)*64)
				SetSpriteGroup(spr, 14)
				SetSpriteDepth(spr, 9)
				
			
			endif
			
			
		next j
	next i
	
endfunction
