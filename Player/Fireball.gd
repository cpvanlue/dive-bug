extends KinematicBody2D


signal enemy_down


var velocity := Vector2(0,0)


func init(speed: float) -> void:
	velocity.x = speed


func _physics_process(delta: float) -> void:
	var collision := move_and_collide(velocity * delta)
	if collision:
		if (collision.collider.name == "TileMap"):
			self.queue_free()
		elif ("Enemy" in collision.collider.name):
			emit_signal("enemy_down")
			get_parent().get_node(collision.collider.name).queue_free()
			self.queue_free()

