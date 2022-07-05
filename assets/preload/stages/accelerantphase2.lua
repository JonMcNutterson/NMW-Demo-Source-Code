function onCreate()
	-- background shit
	makeLuaSprite('sky', 'Sky', -1320, -430);
	setScrollFactor('sky', 0.9, 0.9);
	addLuaSprite('sky', false);

	makeLuaSprite('city', 'City', -1320, -430);
	setScrollFactor('city', 0.8, 0.8);
	addLuaSprite('city', false);

	makeLuaSprite('cliffs', 'Cliffs', -1320, -500);
	setScrollFactor('cliffs', 0.9, 0.9);
	addLuaSprite('cliffs', false);

	makeLuaSprite('ground', 'Ground', -1320, -430);
	setScrollFactor('ground', 1.0, 1.0);
	addLuaSprite('ground', false);
end