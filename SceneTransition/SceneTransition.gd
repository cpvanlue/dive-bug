extends CanvasLayer


onready var animation_player := $AnimationPlayer

func change_scene(path: String) -> void:
	$Control.visible = true
	animation_player.play("Fade")
	yield(animation_player, "animation_finished")
	var _ignored = get_tree().change_scene(path)
	animation_player.play_backwards("Fade")
	yield(animation_player, "animation_finished")
	$Control.visible = false
