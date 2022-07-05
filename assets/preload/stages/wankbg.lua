function onCreate()
	-- background shit
	makeLuaSprite('wanksky', 'wanksky', -1320, -890);
	setScrollFactor('wanksky', 0.7, 0.7);

	makeLuaSprite('hills', 'hills', -1320, -890);
	setScrollFactor('hills', 0.9, 0.9);

	makeLuaSprite('wankground', 'wankground', -1320, -890);
	setScrollFactor('wankground', 1.0, 1.0);

	addLuaSprite('wanksky', false);
	addLuaSprite('hills', false);
	addLuaSprite('wankground', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end