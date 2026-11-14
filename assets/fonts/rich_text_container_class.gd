extends RichTextLabel
class_name RichTextContiner

func _ready() -> void:
	install_effect(RainbowTextEffect.new())
	install_effect(ShakeTextEffect.new())
	install_effect(CommonTextEffect.new())
	install_effect(UncommonTextEffect.new())
	install_effect(RareTextEffect.new())
	install_effect(EpicTextEffect.new())
	_start()

func _start():
	pass
