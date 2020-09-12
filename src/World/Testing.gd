extends Node2D

onready var Player = preload("res://Player/Player.tscn")

onready var WorldGenerator = preload("res://WorldGenerator/WorldGenerator.gd")

onready var entities = null

onready var debug_hud = $DebugHUD
onready var hud = $HUD
onready var spawn_points = $Map/SpawnPoints
onready var next_wave_timer = $WaveTimer
onready var spawn_timer = $SpawnTimer
onready var map = $Map

onready var audio_level_up = $LevelUp
onready var audio_danger = $Danger
onready var audio_death = $EnemyDeath

var player = null

var wave = 1
var enemy_count = 0
var enemy_points_max = 16
var enemy_points = enemy_points_max

var loop = 1
var loop_points = 0
var loop_points_max = 8

var score = 0

onready var enemy_by_cost = [
	[
		Database.Enemies.get("Goblin"),
		Database.Enemies.get("Chungy"),
		Database.Enemies.get("Banshee"),
	],
	[
		Database.Enemies.get("Warrior"),
		Database.Enemies.get("Mage"),
	],
	[
		Database.Enemies.get("Bungy"),
		Database.Enemies.get("Knight"),
	],
	[
		Database.Enemies.get("Archknight"),
	],
	[
		Database.Enemies.get("Sage"),
	],
	[
		Database.Enemies.get("Queen"),
	],
	[
		Database.Enemies.get("King"),
		Database.Enemies.get("Sage"),
	]
]

func _process(delta: float) -> void:
	hud.update_next_wave_timer(str(round(next_wave_timer.time_left * 10)))
	#debug_hud.update_enemy_points(enemy_points, enemy_points_max)


func _spawn_enemy():

	var min_spend = int(clamp(wave - 5, 0, enemy_by_cost.size() - 1))
	if (enemy_points <= min_spend):
		enemy_points = 0
		return
	var max_spend = int(clamp(wave - 1, 0, enemy_by_cost.size() - 1))
	var spend = int(clamp(Global.rng.randi() % enemy_by_cost.size(), min_spend, max_spend))
	var choices = enemy_by_cost[spend]
	var e = choices[Global.rng.randi() % choices.size()].instance()
	e.position = spawn_points.get_random().position + Vector2(Global.rng.randf_range(-8, 8), 0)
	e.points = spend + 1
	entities.add_child(e)
	e.connect("died", self, "_redeem_points")
	enemy_points -= e.points
	enemy_count += 1

func _redeem_points(points):
	enemy_points = int(clamp(enemy_points + points, 1 , enemy_points_max))
	loop_points += points
	hud.update_loop_points(loop_points)

	enemy_count -= 1
	if (loop_points >= loop_points_max):
		next_loop()

	player.damage(-points)

	audio_death.pitch_scale = Global.rng.randf_range(0.9, 1.5)
	audio_death.play()
	add_score(points * wave)

func _spawn_wave():
	while(enemy_points > 0 && enemy_count <= 32):
		_spawn_enemy()


func _increase_wave():
	wave += 1
	enemy_points_max += 8
	level_down_player()
	hud.increase_wave()
	if (player != null):
		player.damage(10 + (10 * wave))
	add_score(loop * wave * 3)


func next_loop():
	loop += 1
	loop_points = 0
	loop_points_max += loop
	enemy_points_max += 8
	hud.update_loop(loop, loop_points_max)
	hud.update_loop_points(loop_points)
	level_up_player()
	add_score(loop * wave * 3)

func level_up_player():
	player.stats.max_health += 5
	player.stats.max_speed += 5
	player.timers.dodge_recovery.wait_time -= 0.025
	hud.health_bar.max_value += 5
	player.damage(-loop * 5)
	hud.warning.display_message("You are now Level " + str(loop) + "!", "You are now slightly more agile and resilient.")
	audio_level_up.play()

func level_down_player():
	player.stats.max_health += -10
	player.stats.max_speed += -5
	player.timers.dodge_recovery.wait_time += 0.05
	hud.health_bar.max_value -= 10
	player.damage(-player.stats.max_health / 2)
	hud.warning.display_message("The danger has grown to " + str(wave) + "!", "You are now significantly less agile and resilient.\nEnemies are now more dangerous.", Color(1, 0, 0, 1))
	audio_danger.play()

func _ready() -> void:
	entities = $Map/Entities
	player = Player.instance()
	player.position = map.get_node("PlayerSpawn").position
	entities.add_child(player)

	$HUD.player = player
	$HUD.update_items()
	$HUD.update_selected_item()
	player.connect("weapon_index_changed", $HUD, "update_selected_item")
	player.connect("weapons_changed", $HUD, "update_items")
	player.connect("game_over", self, "game_over")

	hud.update_loop(loop, loop_points_max)
	hud.update_loop_points(loop_points)

	_spawn_wave()
	add_score(0)

	hud.warning.display_message("The battle begins!", "Keep fighting to retain your strength!", Color(1,1,0,1))

	remove_child(debug_hud)

func game_over():
	Global.score = score
	get_tree().change_scene("res://Screen/GameOverScreen.tscn")

func _remove_enemies():
	for e in entities.get_children():
		if (e.is_in_group("enemy")):
			e.queue_free()
	enemy_points = enemy_points_max
	enemy_count = 0

func _on_wave_timer_expiry() -> void:
	_increase_wave()

func add_score(p):
	score += p
	hud.score.text = str(score)


func _on_spawn_timer() -> void:

	_spawn_wave()
	print("spawned enemy")
	spawn_timer.start()



