extends Character

# ======================================
# Node References
# ======================================

onready var weapon = $Weapon

# ======================================
# Vars
# ======================================

const weapon_distance: float = 16.0

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
	timers.dodge.start()

func _dodge_end() -> void:
	is_dodging = false
	sprite.modulate = Color(1, 1, 1, 1)

# ======================================
# Private Methods: Input
# ======================================

func _check_input() -> void:
	if (Input.is_action_just_pressed("dodge")):
		_dodge()
	if (Input.is_action_pressed("attack")):
		_attack()

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


