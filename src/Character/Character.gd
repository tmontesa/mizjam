extends KinematicBody2D
class_name Character

onready var DamageText = preload("res://DamageText/DamageText.tscn")

# ======================================
# Node References
# ======================================

onready var health_bar = $HealthBar
onready var health_number = $HealthBar/Node2D/HealthNumber
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

var health: int = 0
var direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO

var is_moving: bool = false

# ======================================
# Overrides
# ======================================

func _ready() -> void:
	animation_tree.active = true
	health = stats.max_health
	_update_health_bar()

func _physics_process(delta: float) -> void:
	_move(delta)

func _process(_delta: float) -> void:
	_animate()


# ======================================
# Methods
# ======================================

func knockback(velocity_: Vector2):
	velocity += velocity_

func damage(value: float) -> void:
	health = int(clamp(health - value, -1, stats.max_health))

	if (health <= 0):
		kill()

	_update_health_bar()

	_spawn_damage_number(value)

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

# ======================================
# Private Methods: Health Bar Coloring
# ======================================

func _update_health_bar():
	var fg_color_index = int(clamp((health / 100) + 1, 0, 20))
	var bg_color_index = int(clamp(fg_color_index - 1, 0, 20))
	health_bar.get_stylebox("fg").bg_color = Global.health_bar_colors[fg_color_index]
	health_bar.get_stylebox("bg").bg_color = Global.health_bar_colors[bg_color_index]
	health_bar.value = health % 100
	health_number.text = str(health)

func _spawn_damage_number(value):
	var damage_text = DamageText.instance()
	get_parent().add_child(damage_text)
	damage_text.damage(value)
	damage_text.position = global_position + Vector2(0, -16) + Vector2(Global.rng.randf_range(-4 , 4), Global.rng.randf_range(-4 , 4))

	var s = Global.rng.randf_range(0.2, 0.3) + (0.2 * (value/50))
	damage_text.scale = Vector2(s, s)

