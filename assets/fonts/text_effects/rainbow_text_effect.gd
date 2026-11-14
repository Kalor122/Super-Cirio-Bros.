extends RichTextEffect
class_name RainbowTextEffect

var bbcode = "rnb"

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	char_fx.color = Color.from_hsv(0.0 + char_fx.elapsed_time, 1.0, 1.0, 1.0)
	
	return true
