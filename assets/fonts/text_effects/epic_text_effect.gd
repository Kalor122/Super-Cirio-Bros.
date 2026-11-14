extends RichTextEffect
class_name EpicTextEffect

var bbcode = "epic"

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	char_fx.color = Color(1.0, 0.3, 0.312, 1.0)
	return true
