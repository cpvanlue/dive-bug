extends KinematicBody2D


export var swim_impulse := -400
export var speed := 200
export var gravity := 150

var health
var lethal := true
var velocity := Vector2(0, 0)


func _ready() -> void:
	health = 100


func _physics_process(delta: float) -> void:
	velocity.y = clamp(velocity.y, -250, 150)
	_set_direction()
	_check_abilities(delta)
	if is_on_ceiling():
		velocity.y = 50
	var _ignored = move_and_slide(velocity, Vector2(0, -1))
	if velocity.y > gravity:
		velocity.y = gravity
	velocity.x = lerp(velocity.x, 0, 0.25)


func _set_direction() -> void:
	if Input.is_action_pressed("left"):
		velocity.x = -speed
		if Input.is_action_pressed("sprint"):
			velocity.x = -speed * 1.5
		$Animations/AnimatedSprite.flip_h = true
		if is_on_floor():
			velocity.x = velocity.x / 1.25
			$Animations/AnimatedSprite.play("walk")
	elif Input.is_action_pressed("right"):
		velocity.x = speed
		if Input.is_action_pressed("sprint"):
			velocity.x = speed * 1.5
		$Animations/AnimatedSprite.flip_h = false
		if is_on_floor():
			velocity.x = velocity.x / 1.25
			$Animations/AnimatedSprite.play("walk")


func _check_abilities(delta: float) -> void:
	if Input.is_action_just_pressed("swim"):
		$Animations/AnimatedSprite.frame = 0
		$Animations/AnimatedSprite.play("swim")
		if Input.is_action_pressed("sprint"):
				velocity.y += swim_impulse * 1.15
		else:
			velocity.y += swim_impulse
	elif Input.is_action_just_pressed("shoot"):
		if lethal:
			if $Animations/AnimatedSprite.flip_h == true:
				_create_fireball(-speed * 2)
			else:
				_create_fireball(speed * 2)
			_lethal_recovery()
	else:
		velocity.y += gravity * 4 * delta


func _lethal_recovery() -> void:
	lethal = false
	$Animations/RecoveryTimer.start(0.2); yield($Animations/RecoveryTimer, "timeout")
	lethal = true


func _create_fireball(ballSpeed: float) -> void:
	var fireball = preload("Fireball.tscn").instance()
	fireball.init(ballSpeed)
	if ballSpeed > 0:
		fireball.position.x = self.position.x + 55
	else:
		fireball.position.x = self.position.x - 55
	fireball.position.y = self.position.y
	fireball.connect("enemy_down", get_parent(), "_on_Enemy_Killed")
	get_parent().add_child(fireball)
	get_parent().move_child(fireball, 3)


func _on_AnimatedSprite_animation_finished() -> void:
	if not (Input.is_action_pressed("left") 
		or Input.is_action_pressed("right") 
		or $Animations/AnimatedSprite.animation == "swim"):
			$Animations/AnimatedSprite.play("idle")