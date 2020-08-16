extends KinematicBody2D

# -------------------------------------
# Node References
# -------------------------------------

onready var stats = $Stats
onready var weapon = $Weapon
onready var projectile_spawner = $ProjectileSpawner

# -------------------------------------
# Local Vars
# -------------------------------------

var direction = Vector2.ZERO
var velocity = Vector2.ZERO

# -------------------------------------
# Overrides
# -------------------------------------

func _ready() -> void:
	projectile_spawner.target = get_parent()

func _physics_process(delta: float) -> void:
	_calculate_direction()

	if (direction == Vector2.ZERO):
		var friction = _calculate_friction()
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	else:
		var max_speed = _calculate_max_speed()
		var acceleration = _calculate_acceleration()
		velocity = velocity.move_toward(direction * max_speed, acceleration * delta)

	velocity = move_and_slide(velocity)

func _process(_delta: float) -> void:
	var projectile_direction = get_local_mouse_position().normalized()
	weapon.position = projectile_direction * 32
	weapon.rotation = ((PI / 2) + atan2(projectile_direction.y, projectile_direction.x))
	if (Input.is_action_just_pressed("attack")):
		weapon.animator.play("slash")
		projectile_spawner.spawn(weapon.global_position, weapon.rotation, weapon.projectile_patterns)



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
	return stats.max_speed

func _calculate_acceleration() -> float:
	return stats.acceleration

func _calculate_friction() -> float:
	return stats.friction
