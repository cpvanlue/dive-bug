extends Node2D



func _on_MusicSlider_value_changed(value):
	for node in get_tree().get_nodes_in_group("Music"):
		node.volume_db = value


func _on_SFXSlider_value_changed(value):
	for node in get_tree().get_nodes_in_group("SoundEffects"):
		node.volume_db = value


func _on_BackButton_pressed():
	$CanvasLayer/Control.visible = false
