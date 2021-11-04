extends KinematicBody2D

const SPEED := 200
const GRAVITY := 150

export var swim_impulse := -400

var health
var velocity := Vector2(0, 0)


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
		$AnimatedSprite.flip_h = true
		if is_on_floor():
			velocity.x = velocity.x / 2
			$AnimatedSprite.play("walk")
	elif Input.is_action_pressed("right"):
		velocity.x = SPEED
		if Input.is_action_pressed("sprint"):
			velocity.x = SPEED * 1.5
		$AnimatedSprite.flip_h = false
		if is_on_floor():
			velocity.x = velocity.x / 1.25
			$AnimatedSprite.play("walk")
	

func check_abilities(delta: float) -> void:
	if Input.is_action_just_pressed("swim"):
		$AnimatedSprite.frame = 0
		$AnimatedSprite.play("swim")
		if Input.is_action_pressed("sprint"):
				velocity.y += swim_impulse * 1.15
		else:
			velocity.y += swim_impulse
	else:
		velocity.y += GRAVITY * 4 * delta


func _on_AnimatedSprite_animation_finished():
	if not (Input.is_action_pressed("left") 
		or Input.is_action_pressed("right") 
		or $AnimatedSprite.animation == "swim"):
			$AnimatedSprite.play("idle")
