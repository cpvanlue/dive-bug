extends Node2D


signal player_eliminated

export var enemyHealth := 1

var spawning := true
var difficultyIncreasing := true
var spawnInterval := 2.0
var minEnemySpeed := 200.0
var maxEnemySpeed := 75.0

func _process(_delta: float) -> void:
	difficultyIncrease()
	if spawning:
		var enemy = preload("res://Enemy/Enemy.tscn").instance().init(enemyHealth, minEnemySpeed, maxEnemySpeed)
		if !enemy.dir:
			enemy.get_child(1).flip_h = true
		add_child_below_node($TileMap, enemy)
		spawnTimer()

func _on_KillZone_body_entered(body: Node) -> void:
	print(str(body.name) + " has been eliminated via a kill zone.")
	if (body.name == "Player"):
		$Player.gravity = 0
		$Player.speed = 0
		$Player.velocity = Vector2(0,0)
		$Player/Animations/AnimationPlayer.play("death"); yield($Player/Animations/AnimationPlayer, "animation_finished")
		emit_signal("player_eliminated")
		body.queue_free()
		$ReplayButton.visible = true
	else:
		body.queue_free()


func _on_Enemy_Killed() -> void:
	print("Score increased by 10.")


func _on_ReplayButton_pressed() -> void:
	var _returnValue = get_tree().change_scene("MainMenu/MainMenu.tscn")


func spawnTimer() -> void:
	spawning = false
	$EnemySpawnTimer.start(spawnInterval); yield($EnemySpawnTimer, "timeout")
	spawning = true


func difficultyIncrease() -> void:
	if difficultyIncreasing:
		difficultyIncreasing = false
		minEnemySpeed += 10
		maxEnemySpeed += 10
		spawnInterval = spawnInterval * 0.95
		$DifficultyTimer.start(5); yield($DifficultyTimer, "timeout")
		difficultyIncreasing = true
