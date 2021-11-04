extends Node2D


signal player_eliminated

func _on_KillZone_body_entered(body: Node) -> void:
	body.queue_free()
	print(str(body.name) + " has been eliminated via a kill zone.")
	if (body.name == "Player"):
		emit_signal("player_eliminated")
		print("Player death has occurred. Game over.")

func _on_Enemy_Killed() -> void:
	print("Score increased by 10.")
