extends Node2D


onready var mainMenuTheme := SoundPlayer.get_node("MainMenuTheme")
onready var levelTheme := SoundPlayer.get_node("LevelMusic")


func initialize() -> void:
	var x = 50
	for _i in range(self.get_parent().get_parent().get_node("Player").health):
		var heart = preload("res://HUD/Heart.tscn").instance()
		heart.position = Vector2(x, 50)
		self.add_child(heart)
		x += 50


func _on_MainMenuButton_pressed() -> void:
	var volume = levelTheme.volume_db
	SoundPlayer.fade(mainMenuTheme.get_node("Tween"), mainMenuTheme, -80, volume, Tween.EASE_OUT, false, true)
	SoundPlayer.fade(levelTheme.get_node("Tween"), levelTheme, volume, -80, Tween.EASE_IN, true, false)
	var _ignored = SceneTransition.change_scene("res://MainMenu/MainMenu.tscn")
