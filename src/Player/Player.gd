extends KinematicBody2D


export var swim_impulse := -400

var health
var lethal := true
var velocity := Vector2(0, 0)
var SPEED := 200
var GRAVITY := 150

func _ready():
	health = 100


func _physics_process(delta: float) -> void:
	velocity.y = clamp(velocity.y, -250, 150)
	set_direction()
	check_abilities(delta)
	if is_on_ceiling():
		velocity.y = 50
	var _ignored = move_and_slide(velocity, Vector2(0, -1))
	if velocity.y > GRAVITY:
		velocity.y = GRAVITY
	velocity.x = lerp(velocity.x, 0, 0.25)


func set_direction() -> void:
	if Input.is_action_pressed("left"):
		velocity.x = -SPEED
		if Input.is_action_pressed("sprint"):
			velocity.x = -SPEED * 1.5
		$Node2D/AnimatedSprite.flip_h = true
		if is_on_floor():
			velocity.x = velocity.x / 1.25
			$Node2D/AnimatedSprite.play("walk")
	elif Input.is_action_pressed("right"):
		velocity.x = SPEED
		if Input.is_action_pressed("sprint"):
			velocity.x = SPEED * 1.5
		$Node2D/AnimatedSprite.flip_h = false
		if is_on_floor():
			velocity.x = velocity.x / 1.25
			$Node2D/AnimatedSprite.play("walk")


func check_abilities(delta: float) -> void:
	if Input.is_action_just_pressed("swim"):
		$Node2D/AnimatedSprite.frame = 0
		$Node2D/AnimatedSprite.play("swim")
		if Input.is_action_pressed("sprint"):
				velocity.y += swim_impulse * 1.15
		else:
			velocity.y += swim_impulse
	elif Input.is_action_just_pressed("shoot"):
		if lethal:
			if $Node2D/AnimatedSprite.flip_h == true:
				create_fireball(-SPEED * 2)
			else:
				create_fireball(SPEED * 2)
			lethal_recovery()
	else:
		velocity.y += GRAVITY * 4 * delta


func lethal_recovery() -> void:
	lethal = false
	$Node2D/RecoveryTimer.start(0.2); yield($Node2D/RecoveryTimer, "timeout")
	lethal = true


func create_fireball(var speed: float) -> void:
	var fireball = preload("res://src/Fireball/Fireball.tscn").instance()
	fireball.init(speed)
	if speed > 0:
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
		or $Node2D/AnimatedSprite.animation == "swim"):
			$Node2D/AnimatedSprite.play("idle")
