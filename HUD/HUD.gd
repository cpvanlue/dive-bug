extends Node2D


func _on_MainMenuButton_pressed() -> void:
	var _ignored = get_tree().change_scene("res://MainMenu/MainMenu.tscn")
