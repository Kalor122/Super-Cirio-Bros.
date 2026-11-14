extends RichTextEffect
class_name RareTextEffect

var bbcode = "rare"

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	char_fx.color = Color(0.428, 0.3, 1.0, 1.0)
	return true
