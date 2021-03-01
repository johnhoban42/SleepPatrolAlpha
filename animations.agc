
/*
Load sheep animation frames for the n'th sheep
*/
function LoadSheepAnimation(n)
	
	// Clear existing frames
	ClearSpriteAnimationFrames(n)
	ClearSpriteAnimationFrames(70+n)
	
	// Sheep
	AddSpriteAnimationFrame(n, LoadImage("walk5.png"))
	AddSpriteAnimationFrame(n, LoadImage("walk6.png"))
	AddSpriteAnimationFrame(n, LoadImage("walk7.png"))
	AddSpriteAnimationFrame(n, LoadImage("walk8.png"))
	AddSpriteAnimationFrame(n, LoadImage("walk1.png"))
	AddSpriteAnimationFrame(n, LoadImage("walk2.png"))
	AddSpriteAnimationFrame(n, LoadImage("walk3.png"))
	AddSpriteAnimationFrame(n, LoadImage("walk4.png"))
	AddSpriteAnimationFrame(n, LoadImage("jump2.png"))
	AddSpriteAnimationFrame(n, LoadImage("jump1.png"))
	
	// SPA banner
	AddSpriteAnimationFrame(70+n, LoadImage("spa5.png"))
	AddSpriteAnimationFrame(70+n, LoadImage("spa6.png"))
	AddSpriteAnimationFrame(70+n, LoadImage("spa7.png"))
	AddSpriteAnimationFrame(70+n, LoadImage("spa8.png"))
	AddSpriteAnimationFrame(70+n, LoadImage("spa1.png"))
	AddSpriteAnimationFrame(70+n, LoadImage("spa2.png"))
	AddSpriteAnimationFrame(70+n, LoadImage("spa3.png"))
	AddSpriteAnimationFrame(70+n, LoadImage("spa4.png"))
	AddSpriteAnimationFrame(70+n, LoadImage("spajump2.png"))
	AddSpriteAnimationFrame(70+n, LoadImage("spajump1.png"))

endfunction

/*
Load sleeping sheep animation frames for a given sprite
*/
function LoadSleepingSheepAnimation(spr)
	ClearSpriteAnimationFrames(spr)
	AddSpriteAnimationFrame(spr, LoadImage("sleepsheep1.png"))
	AddSpriteAnimationFrame(spr, LoadImage("sleepsheep2.png"))
	AddSpriteAnimationFrame(spr, LoadImage("sleepsheep3.png"))
	AddSpriteAnimationFrame(spr, LoadImage("sleepsheep4.png"))
	AddSpriteAnimationFrame(spr, LoadImage("sleepsheep5.png"))
	AddSpriteAnimationFrame(spr, LoadImage("sleepsheep6.png"))
	AddSpriteAnimationFrame(spr, LoadImage("sleepsheep7.png"))
	AddSpriteAnimationFrame(spr, LoadImage("sleepsheep8.png"))
endfunction

/*
Load crab animation frames for the n'th sheep
*/
function LoadCrabAnimation(n)
	
	// Clear existing frames
	ClearSpriteAnimationFrames(n)
	ClearSpriteAnimationFrames(70+n)
	
	// Crab
	AddSpriteAnimationFrame(n, LoadImage("crabwalk5.png"))
	AddSpriteAnimationFrame(n, LoadImage("crabwalk6.png"))
	AddSpriteAnimationFrame(n, LoadImage("crabwalk7.png"))
	AddSpriteAnimationFrame(n, LoadImage("crabwalk8.png"))
	AddSpriteAnimationFrame(n, LoadImage("crabwalk1.png"))
	AddSpriteAnimationFrame(n, LoadImage("crabwalk2.png"))
	AddSpriteAnimationFrame(n, LoadImage("crabwalk3.png"))
	AddSpriteAnimationFrame(n, LoadImage("crabwalk4.png"))
	AddSpriteAnimationFrame(n, LoadImage("crabjump2.png"))
	AddSpriteAnimationFrame(n, LoadImage("crabjump1.png"))

	// Base REM crab
	AddSpriteAnimationFrame(n, LoadImage("crabrem5.png"))
	AddSpriteAnimationFrame(n, LoadImage("crabrem6.png"))
	AddSpriteAnimationFrame(n, LoadImage("crabrem7.png"))
	AddSpriteAnimationFrame(n, LoadImage("crabrem8.png"))
	AddSpriteAnimationFrame(n, LoadImage("crabrem1.png"))
	AddSpriteAnimationFrame(n, LoadImage("crabrem2.png"))
	AddSpriteAnimationFrame(n, LoadImage("crabrem3.png"))
	AddSpriteAnimationFrame(n, LoadImage("crabrem4.png"))
	AddSpriteAnimationFrame(n, LoadImage("crabremjump2.png"))
	AddSpriteAnimationFrame(n, LoadImage("crabremjump1.png"))

	// SPA banner
	AddSpriteAnimationFrame(70+n, LoadImage("crabspa5.png"))
	AddSpriteAnimationFrame(70+n, LoadImage("crabspa6.png"))
	AddSpriteAnimationFrame(70+n, LoadImage("crabspa7.png"))
	AddSpriteAnimationFrame(70+n, LoadImage("crabspa8.png"))
	AddSpriteAnimationFrame(70+n, LoadImage("crabspa1.png"))
	AddSpriteAnimationFrame(70+n, LoadImage("crabspa2.png"))
	AddSpriteAnimationFrame(70+n, LoadImage("crabspa3.png"))
	AddSpriteAnimationFrame(70+n, LoadImage("crabspa4.png"))
	AddSpriteAnimationFrame(70+n, LoadImage("crabspajump2.png"))
	AddSpriteAnimationFrame(70+n, LoadImage("crabspajump1.png"))
	
endfunction


/*
Load sleeping crab animation frames for a given sprite
TODO: Update once Brad draws this animation
*/
function LoadSleepingCrabAnimation(spr)
	ClearSpriteAnimationFrames(spr)
	AddSpriteAnimationFrame(spr, LoadImage("crabsleep.png"))
endfunction
