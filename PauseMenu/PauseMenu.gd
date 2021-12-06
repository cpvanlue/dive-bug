extends CanvasLayer


func _on_Resume_pressed() -> void:
	$AnimationPlayer.play_backwards("pause"); yield($AnimationPlayer, "animation_finished")
	$Resume.disabled = true
	get_parent().get_tree().paused = false


func _on_Quit_pressed():
	get_parent().get_tree().paused = false
	SceneTransition.change_scene("MainMenu/MainMenu.tscn")


func _on_SettingsButton_pressed():
	$Settings/AnimationPlayer.play("settings")
