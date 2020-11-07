
function importFromPNG()
	
	mem = CreateMemblockFromImage(LoadImage("mapBasic.png"))
	wid = GetMemblockInt(mem, 0)
	hei = GetMemblockInt(mem, 4)
	
	global map as integer[2,2]
	dim map[wid, hei]
	
	for i = 1 to wid
		for j = 1 to hei
			blockPos = 12+((i-1)+(j-1)*wid)*4
			if GetMemblockByte(mem, blockPos) = 255 and GetMemblockByte(mem, blockPos+1) = 255 and GetMemblockByte(mem, blockPos+2) = 255
				map[i, j] = 1
			endif
		next j
	next i
	
	drawMap(wid, hei)
	
endfunction


function drawMap(wid, hei)
	
	for i = 1 to wid
		for j = 1 to hei
			if map[i, j]
				spr = 1000+i+j*(wid)
				CreateSprite(spr, LoadImage("ground.png"))
				SetSpriteSize(spr, 64, 64)
				SetSpritePosition(spr, 100 + (i-1)*64, 100 + (j-1)*64)
				SetSpriteGroup(spr, 10)
			endif
			
		next j
	next i
	
endfunction
