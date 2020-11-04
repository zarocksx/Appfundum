extends TextureButton


var themePassed = 0


func _on_Logo_pressed():
	globalTheme.nextTheme();
	AppfundumAchievement.increment_achievement("themeFirst", 1)
	themePassed += 1
	if themePassed >= themeStore.getThemes().size():
		AppfundumAchievement.increment_achievement("themefinishFirst", 1)