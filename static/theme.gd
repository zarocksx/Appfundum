extends Node


func setBackgroundColor(colorSelected = "default"):
	var theme = themeStore.getThemeValues(themeStore.getCurrentTheme())
	var defaultColor = "#ffffff"
	match colorSelected:
		"default":
			defaultColor = theme.main
	VisualServer.set_default_clear_color(Color(defaultColor))
	pass;


func nextTheme():
	var themes = themeStore.getThemes();
	themes.sort();
	var currentThemePos = themes.bsearch(themeStore.getCurrentTheme())
	if (currentThemePos+1) < (themes.size()): # si le theme n'est pas le dernier theme de la liste de themes trié, renvoye le suivant
		themeStore.setCurrentTheme(themes[currentThemePos+1])
	else : # Si pas de theme suivant, passe au premier theme, si il n'y a qu'un theme il renverra toujours le même theme
		themeStore.setCurrentTheme(themes[0]);
	actualize_theme()


func actualize_theme():
	setBackgroundColor()
	var secondary = themeStore.getThemeValues(themeStore.getCurrentTheme()).secondary
	var subSecondary = themeStore.getThemeValues(themeStore.getCurrentTheme()).subSecondary

	var themed = get_tree().get_nodes_in_group('theme')
	for element in themed:
		element.self_modulate = secondary

	var themedIcon = get_tree().get_nodes_in_group('themeIcon');
	var pathIcon = "res://assets/graph/cercles/"+themeStore.getCurrentTheme()+".png"
	for element in themedIcon:
		element.set_normal_texture(load(pathIcon))

	var themedtheme = get_tree().get_nodes_in_group('themedtheme')
	for element in themedtheme:
		element.set_style(secondary,subSecondary)
	#TODO: update each element who is affected by the theme