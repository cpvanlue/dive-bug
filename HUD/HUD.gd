extends Node2D


onready var mainMenuTheme = SoundPlayer.get_node("MainMenuTheme")
onready var levelTheme = SoundPlayer.get_node("LevelMusic")


func _on_MainMenuButton_pressed() -> void:
	var _ignored = SceneTransition.change_scene("res://MainMenu/MainMenu.tscn")
	SoundPlayer.fade(mainMenuTheme.get_node("Tween"), mainMenuTheme, -80, -10, Tween.EASE_OUT, false, true)
	SoundPlayer.fade(levelTheme.get_node("Tween"), levelTheme, -15, -80, Tween.EASE_IN, true, false)

