function onCreate()
	-- background shit
	makeLuaSprite('helisky', 'helisky', -1320, -740);
	setScrollFactor('helisky', 0.9, 0.9);
	addLuaSprite('helisky', false);

	makeLuaSprite('helicity', 'helicity', -1320, -740);
	setScrollFactor('helicity', 0.8, 0.8);
	addLuaSprite('helicity', false);

	makeLuaSprite('helipad', 'helipad', -1320, -740);
	setScrollFactor('helipad', 1.0, 1.0);
	addLuaSprite('helipad', false);
end