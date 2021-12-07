extends CanvasLayer


func _ready():
	$Control/MusicSlider.value = SoundPlayer.musicVolume
	$Control/SFXSlider.value = SoundPlayer.sfxVolume

func _on_MusicSlider_value_changed(value: float) -> void:
	for node in get_tree().get_nodes_in_group("Music"):
		node.volume_db = value
	SoundPlayer.musicVolume = value


func _on_SFXSlider_value_changed(value: float) -> void:
	for node in get_tree().get_nodes_in_group("SoundEffects"):
		node.volume_db = value
	SoundPlayer.sfxVolume = value


func _on_BackButton_pressed() -> void:
	$AnimationPlayer.play_backwards("settings")
