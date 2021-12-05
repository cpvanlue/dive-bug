extends Node2D


func _ready() -> void:
	$CanvasLayer/Control/MusicSlider.value = SoundPlayer.get_node("MainMenuTheme").volume_db
	$CanvasLayer/Control/SFXSlider.value = SoundPlayer.get_node("EnemyDamaged").volume_db


func _on_MusicSlider_value_changed(value: float) -> void:
	for node in get_tree().get_nodes_in_group("Music"):
		node.volume_db = value


func _on_SFXSlider_value_changed(value: float) -> void:
	for node in get_tree().get_nodes_in_group("SoundEffects"):
		node.volume_db = value


func _on_BackButton_pressed() -> void:
	$CanvasLayer/Control.visible = false
