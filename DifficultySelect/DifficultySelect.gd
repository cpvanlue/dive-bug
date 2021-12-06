extends CanvasLayer




func _on_EasyButton_pressed():
	layer = -0
	SceneTransition.change_scene("Level/EasyLevel.tscn")


func _on_TextureButton_pressed():
	$AnimationPlayer.play_backwards("slide")
	for button in get_tree().get_nodes_in_group("buttons"):
		button.disabled = true
