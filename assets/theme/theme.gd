extends Node


var currentTheme = "CEI";#theme used by the player
var avalaibleTheme #theme avalaible


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
	"CEI": {
		"main": "#24263b",
		"secondary": "#ffd42a",
		"subSecondary": "#404968",
		"Text": "#ffffff"
	},
	"CH": {
		"main": "#000000",
		"secondary": "#fd6402",
		"subSecondary": "#404968",
		"Text": "#ffffff"
	},
	"CCS": {
		"main": "#000000",
		"secondary": "#a31d1f",
		"subSecondary": "#404968",
		"Text": "#ffffff"
	},
	"CDF": {
		"main": "#318ce7",
		"secondary": "#C0C0C0",
		"subSecondary": "#404968",
		"Text": "#ffffff"
	},
	"CERIA": {
		"main": "#040b76",
		"secondary": "#dd0000",
		"subSecondary": "#404968",
		"Text": "#ffffff"
	},
	"CEMA": {
		"main": "#000000",
		"secondary": "#8B4513",
		"subSecondary": "#404968",
		"Text": "#ffffff"
	},
	"CIESSID": {
		"main": "#000000",
		"secondary": "#ce3131",
		"subSecondary": "#404968",
		"Text": "#ffffff"
	},
	"CMH": {
		"main": "#33999b",
		"secondary": "#c90002",
		"subSecondary": "#404968",
		"Text": "#ffffff"
	},
	"CPC": {
		"main": "#000000",
		"secondary": "#197717",
		"subSecondary": "#404968",
		"Text": "#ffffff"
	},
	"CPG": {
		"main": "#ffffff",
		"secondary": "#042144",
		"subSecondary": "#404968",
		"Text": "#000000"
	},
	"CSL": {
		"main": "#ffffff",
		"secondary": "#000000",
		"subSecondary": "#404968",
		"Text": "#000000"
	},
	"LUKOT": {
		"main": "#106738",
		"secondary": "#feeb00",
		"subSecondary": "#404968",
		"Text": "#000000"
	},
	"IMC": {
		"main": "#000000",
		"secondary": "#6600A1",
		"subSecondary": "#404968",
		"Text": "#000000"
	}
}
