extends Node

var currentTheme = "Cei";#theme used by the player
var avalaibleTheme #theme avalaible

func _ready():
	print( colorScheme["Cei"] );
	pass;

func getCurrentTheme():
	return currentTheme;

func getThemes():
	return colorScheme.keys();

func getThemeValues(themeName):
	return colorScheme[themeName];

func setCurrentTheme(themeName):
	currentTheme = themeName;
	pass

var colorScheme := {
	"Cei" : {
		"main" : "#24263b",
		"secondary" : "#ffd42a",
		"Text" : "#ffffff",
	},
	"CH" : {
		"main" : "#000000",
		"secondary" : "#FD6402",
		"Text" : "#ffffff",
	}
}
