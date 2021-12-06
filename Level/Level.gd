extends Node2D


export var enemyHealth := 1

var spawning := true
var difficultyIncreasing := true
var spawnInterval := 5.0
var minEnemySpeed := 75.0
var maxEnemySpeed := 150.0
var score := 0


func _process(_delta: float) -> void:
	if $Player.position.y < 0:
		$Player.position.y = 0
	difficultyIncrease()
	if spawning:
		var enemy = preload("res://Enemy/BlueEnemy.tscn").instance().initialize(enemyHealth, minEnemySpeed, maxEnemySpeed)
		var enemy2 = preload("res://Enemy/BlueEnemy.tscn").instance().initialize(enemyHealth, minEnemySpeed, maxEnemySpeed)
		var secondaryEnemy = preload("res://Enemy/RedEnemy.tscn").instance().initialize(enemyHealth * 2, minEnemySpeed / 2, maxEnemySpeed / 2)
		if !enemy.dir:
			enemy.get_node("AnimatedSprite").flip_h = true
		if !enemy2.dir:
			enemy2.get_node("AnimatedSprite").flip_h = true
		if !secondaryEnemy.dir:
			secondaryEnemy.get_node("AnimatedSprite").flip_h = true
		add_child_below_node($TileMap, enemy)
		add_child_below_node($TileMap, enemy2)
		add_child_below_node($TileMap, secondaryEnemy)
		spawnTimer()
	if Input.is_action_just_pressed("pause"):
		$PauseMenu/AnimationPlayer.play("pause")
		$PauseMenu/Resume.disabled = false
		get_tree().paused = true


func _on_KillZone_body_entered(body: Node) -> void:
	if (body.name == "Player"):
		_on_Player_player_death()
	else:
		body.queue_free()


func _on_Enemy_Killed() -> void:
	score += 100
	$CanvasLayer/HUD/ScoreLabel.text = "%06d" % score


func _on_ReplayButton_pressed() -> void:
	var _returnValue = get_tree().change_scene("MainMenu/MainMenu.tscn")


func _on_Player_player_death() -> void:
	$Player/Animations/AnimationPlayer.play("death"); yield($Player/Animations/AnimationPlayer, "animation_finished")
	set_process(false)
	$Player.queue_free()
	$CenteredCamera.current = true
	$CanvasLayer/HUD/GameOver/Visibility.visible = true


func spawnTimer() -> void:
	spawning = false
	$EnemySpawnTimer.start(spawnInterval); yield($EnemySpawnTimer, "timeout")
	spawning = true


func difficultyIncrease() -> void:
	if difficultyIncreasing:
		difficultyIncreasing = false
		minEnemySpeed += 7
		maxEnemySpeed += 7
		spawnInterval = spawnInterval * 0.95
		$DifficultyTimer.start(5); yield($DifficultyTimer, "timeout")
		difficultyIncreasing = true


func initialize(interval: float, minSpeed: float, maxSpeed: float, health: int) -> void:
	self.spawnInterval = interval
	self.minEnemySpeed = minSpeed
	self.maxEnemySpeed = maxSpeed
	self.enemyHealth = health
