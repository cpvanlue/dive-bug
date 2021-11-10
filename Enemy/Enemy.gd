extends KinematicBody2D


export var speed := 100

var health := 1
var velocity := Vector2.ZERO
var height := randi() % 640
var dir := true

func _init() -> void:
	if randi() % 2:
		dir = false
	if dir:
		velocity.x = speed
		position = Vector2(-100, height)
	else:
		velocity.x = -speed
		position = Vector2(1100, height)


func _physics_process(delta: float) -> void:
	var _collision = move_and_collide(velocity * delta)
	
