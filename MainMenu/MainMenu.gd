extends Node2D


onready var mainMenuTheme := SoundPlayer.get_node("MainMenuTheme")
onready var levelMusic := SoundPlayer.get_node("LevelMusic")


func _ready() -> void:
	mainMenuTheme.play()


func _on_PlayButton_pressed() -> void:
	for button in get_tree().get_nodes_in_group("buttons"):
		button.disabled = false
	$DifficultySelect/AnimationPlayer.play("slide")


func _on_TextureButton_pressed() -> void:
	$Settings/AnimationPlayer.play("settings")


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "load":
		$SettingsButton.visible = true


func _on_DifficultySelect_change_music() -> void:
	var volume = mainMenuTheme.volume_db
	SoundPlayer.fade(mainMenuTheme.get_node("Tween"), mainMenuTheme, mainMenuTheme.volume_db, -80, Tween.EASE_IN, true, false)
	SoundPlayer.fade(levelMusic.get_node("Tween"), levelMusic, -80, volume, Tween.EASE_OUT, false, true)
