extends CanvasLayer


func _ready() -> void:
	$Control/MusicSlider.value = SoundPlayer.get_node("MainMenuTheme").volume_db
	$Control/SFXSlider.value = SoundPlayer.get_node("EnemyDamaged").volume_db


func _on_MusicSlider_value_changed(value: float) -> void:
	for node in get_tree().get_nodes_in_group("Music"):
		node.volume_db = value


func _on_SFXSlider_value_changed(value: float) -> void:
	for node in get_tree().get_nodes_in_group("SoundEffects"):
		node.volume_db = value


func _on_BackButton_pressed() -> void:
	$AnimationPlayer.play_backwards("settings")
