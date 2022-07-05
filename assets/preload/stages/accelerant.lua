function onCreate()
	-- background shit
	makeLuaSprite('sky', 'sky', -1320, -430);
	setScrollFactor('sky', 0.9, 0.9);

	makeLuaSprite('city', 'city', -1320, -430);
	setScrollFactor('city', 0.8, 0.8);

	makeLuaSprite('cliffs', 'cliffs', -1320, -500);
	setScrollFactor('cliffs', 0.9, 0.9);

	makeLuaSprite('ground', 'ground', -1320, -430);
	setScrollFactor('ground', 1.0, 1.0);

	makeLuaSprite('ground', 'ground', -1320, -430);
	setScrollFactor('ground', 1.0, 1.0);

	addLuaSprite('sky', false);
	addLuaSprite('city', false);
	addLuaSprite('cliffs', false);
	addLuaSprite('ground', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end