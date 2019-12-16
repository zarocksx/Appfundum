extends Tween

onready var menu = get_node("../UI");

func ready():
    print(menu);

func _on_settings_pressed():
    print("click");
    print(self.interpolate_property(menu, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN));
    print(menu.get("modulate"))



func _on_Tween_tween_started(object, key):
    print("start : ",object , " : ", key);
    pass;
