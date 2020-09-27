extends Node

var text = "hello"

func setBackgroundColor(colorSelected = "default"):
    print('1')
    var defaultColor = "#ffffff"
    match colorSelected :
        "default" :
            defaultColor = "#24263b"

    print('2')
    VisualServer.set_default_clear_color(Color(defaultColor))
    pass;

func nextTheme():
    var themes = themeStore.getThemes();
    themes.sort();
    var currentThemePos = themeStore.getCurrentTheme()
    if themes.find(currentThemePos) > -1 :
        print("theme found");
        if (currentThemePos+1) <= (themes.count()): # si le theme n'est pas le dernier theme de la liste de themes trié, renvoye le suivant
            print(themes[currentThemePos+1])
            themeStore.setCurrentTheme(themes[currentThemePos+1])
        else : # Si pas de theme suivant, passe au premier theme, si il n'y a qu'un theme il renverra toujours le même theme
            themeStore.setCurrentTheme(themes[0]);
    pass;