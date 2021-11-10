extends KinematicBody2D


export var speed := 150.0

var minSpeed := 75.0
var maxSpeed := 200.0
var health := 1
var velocity := Vector2.ZERO
var height := rand_range(0, 640)
var dir := true

func _init() -> void:
	speed = rand_range(minSpeed, maxSpeed)
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
	