extends Node2D


func fade(tweenNode: Tween, sound: AudioStreamPlayer2D, startdB: int, enddB: int, 
		  easeType, stopValue: bool, startValue: bool) -> void:
	if startValue:
		sound.play()
	## These returned values are unused booleans; removed in future version of GDScript
	var _returnValue = tweenNode.interpolate_property(sound, 
		"volume_db", startdB, enddB, 1, 1, easeType, 0)
	var _returnBool = tweenNode.start()
	var _ignored = tweenNode.connect("tween_completed", self, "_on_Tween_Finished", [stopValue, sound, tweenNode])


func _on_Tween_Finished(_object: Object, _key: NodePath, stop: bool, 
					   sound: AudioStreamPlayer2D, tweenNode: Tween) -> void:
	if stop:
		sound.stop()
	tweenNode.disconnect("tween_completed", self, "_on_Tween_Finished")
