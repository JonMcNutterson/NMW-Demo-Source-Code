function onCreate()
	-- background shit
	makeLuaSprite('tempdeimosbg', 'tempdeimosbg', -500, -350);
	setScrollFactor('tempdeimosbg', 1.0, 1.0);

	addLuaSprite('tempdeimosbg', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end