extends Node2D


func _on_PlayButton_pressed() -> void:
	var _returnValue = get_tree().change_scene("project/Level/Level.tscn")
