extends TextureRect

onready var blur = $Blur
var blur_amount = 0

func _process(_delta):
    blur_amount = wrapf(blur_amount + 0.05, 0.0, 5.0)
    blur.material.set_shader_param("blur_amount", blur_amount)