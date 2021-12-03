extends Node2D


onready var mainMenuTheme = SoundPlayer.get_node("MainMenuTheme")
onready var levelMusic = SoundPlayer.get_node("LevelMusic")

func _ready() -> void:
	mainMenuTheme.play()

func _on_PlayButton_pressed() -> void:
	var _returnValue = SceneTransition.change_scene("Level/Level.tscn")
	SoundPlayer.fade(mainMenuTheme.get_node("Tween"), mainMenuTheme, -10, -80, Tween.EASE_IN, true, false)
	SoundPlayer.fade(levelMusic.get_node("Tween"), levelMusic, -80, -15, Tween.EASE_OUT, false, true)


func _on_TextureButton_pressed():
	$Settings/CanvasLayer/Control.visible = true


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "load":
		$SettingsButton.visible = true
