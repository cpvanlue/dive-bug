extends CanvasLayer


signal change_music


func _on_EasyButton_pressed() -> void:
	SceneTransition.change_scene("Level/EasyLevel.tscn")
	emit_signal("change_music")


func _on_TextureButton_pressed() -> void:
	$AnimationPlayer.play_backwards("slide")
	for button in get_tree().get_nodes_in_group("buttons"):
		button.disabled = true
