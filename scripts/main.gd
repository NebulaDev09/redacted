extends Control

func _ready():
	_blockScreen()


func _on_employee_1_pressed() -> void:
	_blockScreen()
	get_tree().change_scene_to_file("res://scenes/player.tscn")
	
func _blockScreen():
	var overlay = ColorRect.new()
	overlay.color = Color(0,0,0,1)
	overlay.size = get_viewport_rect().size
	overlay.mouse_filter = Control.MOUSE_FILTER_STOP
	add_child(overlay)
	await get_tree().create_timer(1).timeout
	overlay.queue_free()
