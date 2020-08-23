extends Character

signal weapon_index_changed
signal weapons_changed
signal game_over

# ======================================
# Node References
# ======================================

onready var audio_player = $AudioPlayer
var weapons = [null, null, null]
var weapon = weapons[0]

# ======================================
# Vars
# ======================================

const weapon_distance: float = 8.0
var weapon_index = 0
var is_dodging: bool = false
var is_dodge_recovered: bool = true

# ======================================
# Overrides
# ======================================

func _physics_process(delta: float) -> void:
	_move(delta)
	_check_input()

func _process(_delta: float) -> void:
	_animate()
	_position_weapon()

func _ready() -> void:
	weapons[0] = WeaponGenerator.generate(0)
	weapons[1] = WeaponGenerator.generate(0)
	weapons[2] = WeaponGenerator.generate(0)
	weapon = weapons[0]

	# NOTE: Super hacky
	# Need to ready all 3 weapons for its texture
	# But don't need right now
	add_child(weapons[0])
	add_child(weapons[1])
	add_child(weapons[2])
	remove_child(weapons[1])
	remove_child(weapons[2])

	health = stats.max_health

# ======================================
# Methods
# ======================================

func swap_weapon(new_weapon):
	var old_weapon = weapon
	remove_child(old_weapon)
	add_child(new_weapon)
	weapons[weapon_index] = new_weapon
	weapon = weapons[weapon_index]
	emit_signal("weapons_changed")
	return old_weapon

func kill():
	emit_signal("game_over")

func damage(value: float) -> void:
	health = int(clamp(health - value, -1, stats.max_health))

	if (value > 0):
		audio_player.play_sound("hurt")

	if (health <= 0):
		kill()

	_update_health_bar()

	_spawn_damage_number(value)


# ======================================
# Private Methods: Movement
# ======================================

func _update_direction() -> void:
	var left_influece = Input.get_action_strength("move_left")
	var right_inluence = Input.get_action_strength("move_right")
	var up_influece = Input.get_action_strength("move_up")
	var down_inluence = Input.get_action_strength("move_down")

	var raw_direction = Vector2.ZERO
	raw_direction.x = right_inluence - left_influece
	raw_direction.y = down_inluence - up_influece
	direction = raw_direction.normalized()

func _get_max_speed() -> float:
	var max_speed = stats.max_speed
	if (is_dodging): max_speed *= stats.dodge_max_speed_multiplier
	return max_speed

func _get_acceleration() -> float:
	var acceleration = stats.acceleration
	if (is_dodging): acceleration *= stats.dodge_acceleration_multiplier
	return acceleration

func _get_friction() -> float:
	var friction = stats.friction
	if (is_dodging): friction *= stats.dodge_friction_multiplier
	return friction

# ======================================
# Private Methods: Dodge
# ======================================

func _dodge() -> void:
	is_dodging = true
	is_dodge_recovered = false
	sprite.modulate = Color(0, 0, 0, 0.2)
	#collision_shape.disabled = true
	audio_player.play_sound("dodge")
	timers.dodge.start()
	timers.dodge_recovery.start()

func _dodge_end() -> void:
	is_dodging = false
	#collision_shape.disabled = false


func _on_dodge_recovery() -> void:
	is_dodge_recovered = true
	sprite.modulate = Color(1, 1, 1, 1)


# ======================================
# Private Methods: Input
# ======================================

func _check_input() -> void:
	if (Input.is_action_just_pressed("dodge") && is_dodge_recovered):
		_dodge()
	if (Input.is_action_pressed("attack") && is_dodge_recovered):
		_attack()
	if (Input.is_action_just_pressed("item_1")):
		remove_child(weapon)
		weapon = weapons[0]
		add_child(weapon)
		weapon_index = 0
		emit_signal("weapon_index_changed")
	if (Input.is_action_just_pressed("item_2")):
		remove_child(weapon)
		weapon = weapons[1]
		add_child(weapon)
		weapon_index = 1
		emit_signal("weapon_index_changed")
	if (Input.is_action_just_pressed("item_3")):
		remove_child(weapon)
		weapon = weapons[2]
		add_child(weapon)
		weapon_index = 2
		emit_signal("weapon_index_changed")

# ======================================
# Private Methods: Weapon
# ======================================

func _position_weapon() -> void:
	var mouse_direction = get_local_mouse_position().normalized()
	weapon.position = mouse_direction * weapon_distance
	weapon.rotation = ((PI / 2) + atan2(mouse_direction.y, mouse_direction .x))

func _attack() -> void:
	weapon.attack()
	pass

func _spawn_damage_number(value):
	var damage_text = DamageText.instance()
	get_parent().add_child(damage_text)
	damage_text.damage(abs(value))
	damage_text.position = global_position + Vector2(0, -16) + Vector2(Global.rng.randf_range(-4 , 4), Global.rng.randf_range(-4 , 4))

	if (value > 0):
		damage_text.modulate = Color(1, 0, 0, 1)
	else:
		damage_text.modulate = Color(0.1, 0.8, 0.1, 1)

	var s = Global.rng.randf_range(0.2, 0.3) + (0.5 * (abs(value)/50))
	if (value < 0):
		s += .2
	damage_text.scale = Vector2(s, s)




