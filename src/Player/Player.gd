extends Character

signal weapon_index_changed
signal weapons_changed

# ======================================
# Node References
# ======================================

var weapons = [null, null, null]
var weapon_index = 0
var weapon = weapons[weapon_index]

# ======================================
# Vars
# ======================================

const weapon_distance: float = 8.0

var is_dodging: bool = false

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
	sprite.modulate = Color(0, 0, 0, 0.2)
	collision_shape.disabled = true
	timers.dodge.start()

func _dodge_end() -> void:
	is_dodging = false
	collision_shape.disabled = false
	sprite.modulate = Color(1, 1, 1, 1)

# ======================================
# Private Methods: Input
# ======================================

func _check_input() -> void:
	if (Input.is_action_just_pressed("dodge")):
		_dodge()
	if (Input.is_action_pressed("attack")):
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


