extends Node2D


export var enemyHealth := 1.0

var spawning := true
var difficultyIncreasing := true
var spawnInterval := 5.0
var minEnemySpeed := 75.0
var maxEnemySpeed := 150.0
var score := 0


func _ready():
	if self.name == "EasyLevel":
		initialize(5.0, 75.0, 150.0, 1.0, 3)
	elif self.name == "MediumLevel":
		initialize(4.0, 90.0, 160.0, 1.5, 4)
	elif self.name == "HardLevel":
		initialize(3.5, 100.0, 180.0, 2.0, 5)
	$CanvasLayer/HUD.initialize()


func _process(_delta: float) -> void:
	if $Player.position.y < 0:
		$Player.position.y = 0
	difficultyIncrease()
	if spawning:
		var enemy = preload("res://Enemy/BlueEnemy.tscn").instance().initialize(enemyHealth, minEnemySpeed, maxEnemySpeed)
		var enemy2 = preload("res://Enemy/BlueEnemy.tscn").instance().initialize(enemyHealth, minEnemySpeed, maxEnemySpeed)
		var secondaryEnemy = preload("res://Enemy/RedEnemy.tscn").instance().initialize(enemyHealth * 2.0, minEnemySpeed / 2.0, maxEnemySpeed / 2.0)
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


func initialize(interval: float, minSpeed: float, maxSpeed: float, enemyhealth: float, playerHealth: int) -> void:
	self.spawnInterval = interval
	self.minEnemySpeed = minSpeed
	self.maxEnemySpeed = maxSpeed
	self.enemyHealth = enemyhealth
	$Player.set_health(playerHealth)

