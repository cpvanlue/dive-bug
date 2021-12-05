extends KinematicBody2D


signal player_death

export var swim_impulse := -400
export var speed := 200
export var gravity := 150

var health
var lethal := true
var immunity := false
var velocity := Vector2(0, 0)


func _ready() -> void:
	health = 3


func _physics_process(delta: float) -> void:
	if health == 0:
		emit_signal("player_death")
		set_physics_process(false)
	velocity.y = clamp(velocity.y, -250, 150)
	_set_direction()
	_check_abilities(delta)
	if is_on_ceiling():
		velocity.y = 50
	var _velocity = move_and_slide(velocity, Vector2(0, -1))
	for i in get_slide_count():
		if "Enemy" in get_slide_collision(i).collider.name and !immunity:
			_reduceHealth()
			SoundPlayer.get_node("PlayerDamaged").play()
			_immunityTimer()
			health -= 1
			self.get_parent().get_node("Player/Camera2D").shake(375)
	if velocity.y > gravity:
		velocity.y = gravity
	velocity.x = lerp(velocity.x, 0, 0.25)


func _reduceHealth() -> void:
	var hud = get_parent().get_node("CanvasLayer/HUD")
	var rightMostHeart = hud.get_child(hud.get_child_count()-1)
	rightMostHeart.get_node("AnimatedSprite").animation = "lost"
	rightMostHeart.get_node("HealthLostTimer").start(1); yield(rightMostHeart.get_node("HealthLostTimer"), "timeout")
	rightMostHeart.queue_free()


func _immunityTimer() -> void:
	immunity = true
	set_collision_mask_bit(1, false)
	set_collision_layer_bit(1, false)
	$Animations/AnimatedSprite.animation = "dead"
	$Animations/ImmunityTimer.start(2); yield($Animations/ImmunityTimer, "timeout")
	$Animations/AnimatedSprite.animation = "idle"
	set_collision_mask_bit(1, true)
	set_collision_layer_bit(1, true)
	immunity = false
	


func _set_direction() -> void:
	if Input.is_action_pressed("left"):
		velocity.x = -speed
		if Input.is_action_pressed("sprint"):
			velocity.x = -speed * 1.5
		$Animations/AnimatedSprite.flip_h = true
		if is_on_floor():
			velocity.x = velocity.x / 1.25
			if !immunity:
				$Animations/AnimatedSprite.play("walk")
	elif Input.is_action_pressed("right"):
		velocity.x = speed
		if Input.is_action_pressed("sprint"):
			velocity.x = speed * 1.5
		$Animations/AnimatedSprite.flip_h = false
		if is_on_floor():
			velocity.x = velocity.x / 1.25
			if !immunity:
				$Animations/AnimatedSprite.play("walk")


func _check_abilities(delta: float) -> void:
	if Input.is_action_just_pressed("swim"):
		SoundPlayer.get_node("PlayerSwim").play()
		$Animations/AnimatedSprite.frame = 0
		if !immunity:
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
	fireball.connect("enemy_down", get_parent(), "_on_Enemy_Killed", [], CONNECT_ONESHOT)
	get_parent().add_child(fireball)
	get_parent().move_child(fireball, 3)


func _on_AnimatedSprite_animation_finished() -> void:
	if not (Input.is_action_pressed("left") 
		or Input.is_action_pressed("right") 
		or $Animations/AnimatedSprite.animation == "swim"):
			if !immunity:
				$Animations/AnimatedSprite.play("idle")
