function onCreate()
	-- background shit
	makeLuaSprite('wanksky', 'wanksky', -1320, -890);
	setScrollFactor('wanksky', 0.7, 0.7);
	addLuaSprite('wanksky', false);

	makeLuaSprite('hills', 'hills', -1320, -890);
	setScrollFactor('hills', 0.9, 0.9);
	addLuaSprite('hills', false);

	makeLuaSprite('wankground', 'wankground', -1320, -890);
	setScrollFactor('wankground', 1.0, 1.0);
	addLuaSprite('wankground', false);
end