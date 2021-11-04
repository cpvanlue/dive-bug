extends Node2D


signal player_eliminated


func _on_KillZone_body_entered(body: Node) -> void:
	print(str(body.name) + " has been eliminated via a kill zone.")
	if (body.name == "Player"):
		$Player.GRAVITY = 0
		$Player.SPEED = 0
		$Player.velocity = Vector2(0,0)
		$Player/Node2D/AnimationPlayer.play("death"); yield($Player/Node2D/AnimationPlayer, "animation_finished")
		emit_signal("player_eliminated")
		body.queue_free()
	else:
		body.queue_free()
	$ReplayButton.visible = true


func _on_Enemy_Killed() -> void:
	print("Score increased by 10.")


func _on_ReplayButton_pressed():
	var _ignored = get_tree().change_scene("res://src/MainMenu.tscn")
