extends Node

export var SAVE = 'res://assets/data/save.json'
var data = File.new()
var saveEntries = []


func _ready():
	if not data.file_exists(SAVE):
		printerr("no files", SAVE)
		return false

	data.open(SAVE, File.READ)
	saveEntries = parse_json(data.get_as_text())
	data.close()
	return true


func update_save():
	saveEntries.open(SAVE, File.READ_WRITE)

	if saveEntries.is_open():
		saveEntries.store_string(to_json(saveEntries))
		saveEntries.close()
		print("update")



func get_save(key: String):
	if saveEntries.has(key):
		return saveEntries[key].value

# Save the data if it exist in the save.json file
# @param key String the key of the save object to update
# @param value String the value to put in the save object
func save(key: String, value: String)->void:
	if saveEntries.has(key):
		if saveEntries[key].value != value:
			saveEntries[key].value = value
			update_save()
	else :
		push_warning("No save entry found")

# Increment the value of an save object selected by his key
# @param key String the key of the save object to update
func incr(key: String)->void:
	if saveEntries.has(key):
		if saveEntries[key].value.is_valid_integer():
			var value = String(saveEntries[key].value.to_int() + 1)
			saveEntries[key].value = value
			update_save()
		else:
			push_warning("Not a number")
	else:
		push_warning("No save entry found")

# Decrement the value of an save object selected by his key
# @param key String the key of the save object to update
func decr(key):
	if saveEntries.has(key):
		if saveEntries[key].value.is_valid_integer():
			var value = String(saveEntries[key].value.to_int() - 1)
			saveEntries[key].value = value
			update_save()
		else:
			push_warning("Not a number")
	else :
		push_warning("No save entry found")
