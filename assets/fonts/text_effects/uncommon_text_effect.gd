extends RichTextEffect
class_name UncommonTextEffect

var bbcode = "uncommon"

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	char_fx.color = Color(0.3, 0.732, 1.0, 1.0)
	return true
