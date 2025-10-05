extends Control

var text = ""

func _process(delta: float) -> void:
	$RichTextLabel.text = text 
