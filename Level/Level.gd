extends Node2D


signal player_eliminated


func _on_KillZone_body_entered(body: Node) -> void:
	print(str(body.name) + " has been eliminated via a kill zone.")
	if (body.name == "Player"):
		$Player.gravity = 0
		$Player.speed = 0
		$Player.velocity = Vector2(0,0)
		$Player/Animations/AnimationPlayer.play("death"); yield($Player/Animations/AnimationPlayer, "animation_finished")
		emit_signal("player_eliminated")
		body.queue_free()
		$ReplayButton.visible = true
	else:
		body.queue_free()



func _on_Enemy_Killed() -> void:
	print("Score increased by 10.")


func _on_ReplayButton_pressed() -> void:
	var _returnValue = get_tree().change_scene("MainMenu/MainMenu.tscn")
