
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
			elseif GetMemblockByte(mem, blockPos) = 0 and GetMemblockByte(mem, blockPos+1) = 255 and GetMemblockByte(mem, blockPos+2) = 255
				map[i, j] = 5	//Landmark
			endif
		next j
	next i
	
	drawMap(map_w, map_h)
	
endfunction


function drawMap(wid, hei)
	
	landmarkNum = 1
	img = LoadImage("groundgrass2.png")
	
	for i = 1 to wid
		for j = 1 to hei
			if map[i, j] = 1	//Ground
				spr = 1000+i+j*(wid)
				if(GetSpriteExists(spr) = 0)
					CreateSprite(spr, img)
					SetSpriteSize(spr, 64, 64)
					SetSpritePosition(spr, 100 + (i-1)*64, 100 + (j-1)*64)
					SetSpriteGroup(spr, 10)
					SetSpriteDepth(spr, 12)
					SetSpriteColor(spr, 180, 180, 180, 255)
					if map[i+1, j] = 1 and map[i-1, j] <> 1 then SetSpriteImage(spr, LoadImage("platformleft.png"))
					if map[i+1, j] <> 1 and map[i-1, j] = 1 then SetSpriteImage(spr, LoadImage("platformright.png"))
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
					CreateSprite(spr, 0)
										
					AddSpriteAnimationFrame(spr, LoadImage("sleepsheep1.png"))
					AddSpriteAnimationFrame(spr, LoadImage("sleepsheep2.png"))
					AddSpriteAnimationFrame(spr, LoadImage("sleepsheep3.png"))
					AddSpriteAnimationFrame(spr, LoadImage("sleepsheep4.png"))
					AddSpriteAnimationFrame(spr, LoadImage("sleepsheep5.png"))
					AddSpriteAnimationFrame(spr, LoadImage("sleepsheep6.png"))
					AddSpriteAnimationFrame(spr, LoadImage("sleepsheep7.png"))
					AddSpriteAnimationFrame(spr, LoadImage("sleepsheep8.png"))
					AddSpriteAnimationFrame(spr, LoadImage("crabsleep.png"))
				
				endif
				
				SetSpriteSize(spr, 90, 78)
				SetSpritePosition(spr, 100 + (i-1)*64, 100 + (j-1)*64-10)
				if crabMode = 1
					SetSpriteSize(spr, 90, 60)
					SetSpritePosition(spr, 100 + (i-1)*64, 100 + (j-1)*64-10+18)
				endif
				SetSpriteGroup(spr, EXTRA_SHEEP)
				SetSpriteDepth(spr, 10)
				
				if crabMode = 0 then PlaySprite(spr, 10, 1, 1, 8)
				if crabMode = 1 then PlaySprite(spr, 10, 0, 9, 9)

					
			elseif map[i, j] = 4 // reverse sign
				spr = 1000+i+j*(wid)
				if(GetSpriteExists(spr) = 0)
					CreateSprite(spr, LoadImage("pillow.png"))
					SetSpriteSize(spr, 64, 64)
					SetSpritePosition(spr, 100 + (i-1)*64, 100 + (j-1)*64)
					SetSpriteGroup(spr, 14)
					SetSpriteDepth(spr, 9)
				endif
				
				
			elseif map[i, j] = 4 // reverse sign
				spr = 1000+i+j*(wid)
				if(GetSpriteExists(spr) = 0)
					CreateSprite(spr, LoadImage("pillow.png"))
					SetSpriteSize(spr, 64, 64)
					SetSpritePosition(spr, 100 + (i-1)*64, 100 + (j-1)*64)
					SetSpriteGroup(spr, 14)
					SetSpriteDepth(spr, 9)
				endif
				
			elseif map[i, j] = 5 //Landmark
				spr = 1000+i+j*(wid)
				
				if(GetSpriteExists(spr) = 0)
					CreateSprite(spr, 0)
					//SetSpriteSize(spr, 64, 64)
					//SetSpritePosition(spr, (i-1)*64, (j-1)*64)
					SetSpriteGroup(spr, 15)
					SetSpriteDepth(spr, 9)
					
					if landmarkNum = 4	//Z with legs
						SetSpriteImage(spr, LoadImage("landmark1.png"))
						SetSpriteSize(spr, 224, 256)
						SetSpritePosition(spr, (i-1)*64, (j-1)*64-24)
						SetSpriteDepth(spr, 30)
						
						
					elseif landmarkNum = 2	//Crashed UFO
						SetSpriteImage(spr, LoadImage("landmark2.png"))
						SetSpriteSize(spr, 222, 132)
						SetSpritePosition(spr, (i-1)*64, (j-1)*64+64)
						
					elseif landmarkNum = 5 //Lightbulb
						SetSpriteImage(spr, LoadImage("landmark3.png"))
						SetSpriteSize(spr, 226, 300)
						SetSpritePosition(spr, (i-1)*64, (j-1)*64)
					
					elseif landmarkNum = 8	//Eye bush
						SetSpriteImage(spr, LoadImage("landmark4.png"))
						SetSpriteSize(spr, 280, 160)
						SetSpritePosition(spr, (i-1)*64, (j-1)*64+32)
						SetSpriteDepth(spr, 30)
					
					elseif landmarkNum = 1	//Mountain
						SetSpriteImage(spr, LoadImage("landmark5.png"))
						SetSpriteSize(spr, 1216, 1432)
						SetSpritePosition(spr, (i-1)*64, (j-1)*64-16-64)
						SetSpriteDepth(spr, 30)
					
					elseif landmarkNum = 7 //3D glasses
						SetSpriteImage(spr, LoadImage("landmark6.png"))
						SetSpriteSize(spr, 300, 295)
						SetSpritePosition(spr, (i-1)*64, (j-1)*64+32)
						//SetSpriteDepth(spr, 13)
						
					elseif landmarkNum = 6 //Instrument aquarium
						SetSpriteImage(spr, LoadImage("landmark7.png"))
						SetSpriteSize(spr, 400, 243)
						SetSpritePosition(spr, (i-1)*64, (j-1)*64+32)
						//SetSpriteDepth(spr, 13)
						
					elseif landmarkNum = 3	//Fleshcub
						SetSpriteImage(spr, LoadImage("landmark8.png"))
						SetSpriteSize(spr, 180, 306)
						SetSpritePosition(spr, (i-1)*64, (j-1)*64+16)
						SetSpriteDepth(spr, 30)
					
					endif
					
					if landmarkT[landmarkNum] <> 1
						landmarkT[landmarkNum] = spr
						SetSpriteColor(spr, 120, 120, 120, 255)
					endif
					inc landmarkNum, 1
					//Maybe can assign sprite number to the array of having
				endif
				
			
			endif
			
			
		next j
	next i
	
endfunction
