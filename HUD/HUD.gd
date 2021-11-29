extends Node2D


func _on_MainMenuButton_pressed() -> void:
	var _ignored = SceneTransition.change_scene("res://MainMenu/MainMenu.tscn")
	
