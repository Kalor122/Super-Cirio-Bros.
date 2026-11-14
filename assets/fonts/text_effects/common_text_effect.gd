extends RichTextEffect
class_name CommonTextEffect

var bbcode = "common"

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	char_fx.color = Color(0.393, 1.0, 0.3, 1.0)
	return true
