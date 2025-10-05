extends Control

func _on_recipient_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/recipient.tscn")


func _on_transcription_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/transcription.tscn")
