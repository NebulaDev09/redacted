extends Control

var text = ""
var editable = false

func _process(delta: float) -> void:
	$TextEdit.text = text 
	$TextEdit.editable = editable
