extends CanvasLayer


onready var mainMenuTheme := SoundPlayer.get_node("MainMenuTheme")
onready var levelMusic := SoundPlayer.get_node("LevelMusic")


func _on_Resume_pressed() -> void:
	$AnimationPlayer.play_backwards("pause"); yield($AnimationPlayer, "animation_finished")
	$Resume.disabled = true
	get_parent().get_tree().paused = false


func _on_Quit_pressed() -> void:
	get_parent().get_tree().paused = false
	var volume = levelMusic.volume_db
	SoundPlayer.fade(levelMusic.get_node("Tween"), levelMusic, volume, -80, Tween.EASE_IN, true, false)
	SoundPlayer.fade(mainMenuTheme.get_node("Tween"), mainMenuTheme, -80, volume, Tween.EASE_OUT, false, true)
	SceneTransition.change_scene("MainMenu/MainMenu.tscn")


func _on_SettingsButton_pressed() -> void:
	$Settings/AnimationPlayer.play("settings")
