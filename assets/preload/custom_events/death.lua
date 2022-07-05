function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'hankded'); --Character json file for the death animation
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'hankded'); --put in mods/sounds/
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'trickyondapiano'); --put in mods/music/
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'YAY'); --put in mods/music/
end