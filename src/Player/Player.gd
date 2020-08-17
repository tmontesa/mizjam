extends KinematicBody2D

# -------------------------------------
# Node References
# -------------------------------------

onready var stats = $Stats
onready var weapon = null
onready var projectile_spawner = $ProjectileSpawner
onready var timer = $Timers

onready var collision_shape = $CollisionShape
onready var sprite = $Sprite
onready var animation_tree = $AnimationTree
onready var animation_tree_state = $AnimationTree.get("parameters/playback")
onready var weapon_generator = $WeaponGenerator

# -------------------------------------
# Local Vars
# -------------------------------------

var direction = Vector2.ZERO
var velocity = Vector2.ZERO

var is_moving = false
var is_dodging = false

# -------------------------------------
# Overrides
# -------------------------------------

func _ready() -> void:
	animation_tree.active = true

	weapon = weapon_generator.generate()
	add_child(weapon)
	weapon.projectile_spawner.target = get_parent()

func _physics_process(delta: float) -> void:
	_calculate_direction()

	if (direction == Vector2.ZERO):
		var friction = _calculate_friction()
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		is_moving = false
	else:
		var max_speed = _calculate_max_speed()
		var acceleration = _calculate_acceleration()
		velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
		is_moving = true

	velocity = move_and_slide(velocity)

func _process(_delta: float) -> void:
	_play_animation()
	_position_weapon()
	_check_input()

# -------------------------------------
# Private Methods: Movement
# -------------------------------------

func _calculate_direction() -> void:
	var left_influece = Input.get_action_strength("move_left")
	var right_inluence = Input.get_action_strength("move_right")
	var up_influece = Input.get_action_strength("move_up")
	var down_inluence = Input.get_action_strength("move_down")

	var raw_direction = Vector2.ZERO
	raw_direction.x = right_inluence - left_influece
	raw_direction.y = down_inluence - up_influece
	direction = raw_direction.normalized()

func _calculate_max_speed() -> float:
	if (is_dodging):
		return stats.dodge_max_speed
	else:
		return stats.max_speed

func _calculate_acceleration() -> float:
	if (is_dodging):
		return stats.dodge_acceleration
	else:
		return stats.acceleration

func _calculate_friction() -> float:
	if (is_dodging):
		return stats.friction
	else:
		return stats.friction

# -------------------------------------
# Private Methods: Weapon
# -------------------------------------

func _position_weapon():
	var projectile_direction = get_local_mouse_position().normalized()
	weapon.position = projectile_direction * 32
	weapon.rotation = ((PI / 2) + atan2(projectile_direction.y, projectile_direction.x))

# -------------------------------------
# Private Methods: Input
# -------------------------------------

func _check_input() -> void:
	if (Input.is_action_just_pressed("dodge")):
		_initiate_dodge()
	if (Input.is_action_pressed("attack")):
		_initiate_attack()

func _initiate_dodge() -> void:
	if (!is_dodging):
		is_dodging = true
		timer.dodge.start()
		sprite.modulate = Color(0, 0, 0, 0.3)
		collision_shape.disabled = true


func _initiate_attack():
	if (!is_dodging):
		weapon.attack()



# -------------------------------------
# Private Methods: Animation
# -------------------------------------

func _play_animation():
	if (is_moving):
		animation_tree_state.travel("walk")
		animation_tree.set("parameters/walk/blend_position", direction)
	else:
		animation_tree_state.travel("idle")

# -------------------------------------
# Signals
# -------------------------------------

func _on_dodge_timeout() -> void:
	is_dodging = false
	sprite.modulate = Color(1, 1, 1, 1)
	collision_shape.disabled = false
