extends KinematicBody2D
class_name Character

# ======================================
# Node References
# ======================================

onready var collision_shape = $CollisionShape
onready var sprite = $Sprite
onready var animator = $Animator
onready var animation_tree = $AnimationTree
onready var animation_tree_state = $AnimationTree.get("parameters/playback")

onready var detect_area = $DetectArea
onready var undetect_area = $UndetectArea

onready var stats = $Stats
onready var timers = $Timers

# ======================================
# Vars
# ======================================

var direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO

var is_moving: bool = false

# ======================================
# Overrides
# ======================================

func _ready() -> void:
	animation_tree.active = true

func _physics_process(delta: float) -> void:
	_move(delta)

func _process(delta: float) -> void:
	_animate()

	# TEMP
	$Label.text = str(stats.health)

# ======================================
# Methods
# ======================================

func knockback(velocity_: Vector2):
	velocity += velocity_

func damage(value: float) -> void:
	stats.health -= value

	if (stats.health <= 0):
		kill()

func kill() -> void:
	queue_free()

# ======================================
# Private Methods: Movement
# ======================================

func _move(delta: float)-> void:
	_update_direction()

	if (direction != Vector2.ZERO):
		velocity = velocity.move_toward(direction * _get_max_speed(), _get_acceleration() * delta)
		is_moving = true
	else:
		velocity = velocity.move_toward(Vector2.ZERO, _get_friction() * delta)
		is_moving = false

	velocity = move_and_slide(velocity)

func _update_direction() -> void:
	pass

func _get_max_speed() -> float:
	return stats.max_speed

func _get_acceleration() -> float:
	return stats.acceleration

func _get_friction() -> float:
	return stats.friction

# ======================================
# Private Methods: Animation
# ======================================

func _animate() -> void:
	if (is_moving):
		_play_walk_animation()
	else:
		_play_idle_animation()

func _play_idle_animation() -> void:
	animation_tree_state.travel("idle")

func _play_walk_animation() -> void:
	animation_tree_state.travel("walk")
	animation_tree.set("parameters/walk/blend_position", direction)
