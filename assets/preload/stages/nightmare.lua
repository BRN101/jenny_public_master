function onCreate()

	makeLuaSprite('nigthmare', 'jenny/aparition', -200, 1900);
	addLuaSprite('nigthmare', false);
	makeAnimatedLuaSprite('gf', 'jenny/GF', 200, 2500);
	addAnimationByPrefix('gf', 'bounce','gf idle', 24, true);
    addLuaSprite('gf', true);
	objectPlayAnimation('gf', 'bounce', true);
end