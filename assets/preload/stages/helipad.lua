function onCreate()
	-- background shit
	makeLuaSprite('helisky', 'helisky', -1320, -740);
	setScrollFactor('sky', 0.9, 0.9);

	makeLuaSprite('helicity', 'helicity', -1320, -740);
	setScrollFactor('helicity', 0.8, 0.8);

	makeLuaSprite('helipad', 'helipad', -1320, -740);
	setScrollFactor('helipad', 1.0, 1.0);

	addLuaSprite('helisky', false);
	addLuaSprite('helicity', false);
	addLuaSprite('helipad', false);
end