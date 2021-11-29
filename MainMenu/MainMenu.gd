extends Node2D


func _on_PlayButton_pressed() -> void:
	var _returnValue = SceneTransition.change_scene("Level/Level.tscn")
