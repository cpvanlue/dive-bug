extends KinematicBody2D


export var speed := 150.0

var minSpeed := 75.0
var maxSpeed := 200.0
var health
var velocity := Vector2.ZERO
var height := rand_range(0, 640)
var dir := true

func init(parameterHealth: int, minimumSpeed: float, maximumSpeed: float) -> KinematicBody2D:
	health = parameterHealth
	minSpeed = minimumSpeed
	maxSpeed = maximumSpeed
	speed = rand_range(minSpeed, maxSpeed)
	if randi() % 2:
		dir = false
	if dir:
		velocity.x = speed
		position = Vector2(-100, height)
	else:
		velocity.x = -speed
		position = Vector2(1100, height)
	return self


func _physics_process(delta: float) -> void:
	if health == 0:
		deathAnimation()
		set_physics_process(false)
	else:
		var _collision = move_and_collide(velocity * delta)


func deathAnimation() -> void:
	$AnimatedSprite.animation = "death"
	$EnemyBody.disabled = true
	$DeathTimer.start(0.25); yield($DeathTimer, "timeout")
	self.queue_free()
