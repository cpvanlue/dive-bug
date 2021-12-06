extends KinematicBody2D


export var speed := 150.0

var minSpeed := 0.0
var maxSpeed := 0.0
var health := 0.0
var velocity := Vector2.ZERO
var height := rand_range(0, 640)
var dir := true


func _physics_process(delta: float) -> void:
	if health <= 0:
		deathAnimation()
		set_physics_process(false)
	else:
		var _collision = move_and_collide(velocity * delta)


func initialize(parameterHealth: float, minimumSpeed: float, maximumSpeed: float) -> KinematicBody2D:
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


func deathAnimation() -> void:
	$AnimatedSprite.animation = "death"
	$EnemyBody.disabled = true
	$DeathParticles.emitting = true
	$DeathTimer.start(0.25); yield($DeathTimer, "timeout")
	self.queue_free()
