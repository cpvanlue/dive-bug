extends Camera2D


var shakeIntensity := 0.0
var default_offset := offset


func _ready() -> void:
	set_process(false)


func _process(delta: float) -> void:
	offset = Vector2(rand_range(-shakeIntensity, shakeIntensity), rand_range(-shakeIntensity, shakeIntensity)) * delta + default_offset


func shake(intensity: float, duration := 0.3, limit = 500) -> void:
	shakeIntensity += intensity
	if shakeIntensity > limit:
		shakeIntensity = limit
	$Timer.wait_time = duration
	$Tween.stop_all()
	set_process(true)
	$Timer.start()


func _on_Timer_timeout() -> void:
	shakeIntensity = 0
	set_process(false)
	$Tween.interpolate_property(self, "offset", offset, default_offset,
	0.1, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	$Tween.start()
