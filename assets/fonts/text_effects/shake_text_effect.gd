extends RichTextEffect
class_name ShakeTextEffect

var bbcode = "shk"

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	char_fx.offset.x = randi_range(-1, 1)
	char_fx.offset.y = randi_range(-1, 1)
	return true
