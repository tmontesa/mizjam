extends Character

signal died(points)

onready var Pickup = preload("res://Pickup/Pickup.tscn")

# ======================================
# Node References
# ======================================

onready var detect_shape = $DetectArea/DetectShape
var target: Node2D = null

# ======================================
# Vars
# ======================================

var can_attack = false
var points = 0

# ======================================
# Overrides
# ======================================

func _physics_process(delta: float) -> void:
	_move(delta)
	_check_attack()

# ======================================
# Methods
# ======================================

func damage(value: float) -> void:
	detect_shape.shape.radius *= 4
	health -= value

	if (health <= 0):
		kill()
		emit_signal("died", points)

	_update_health_bar()
	_spawn_damage_number(value)

func kill():
	var v = Global.rng.randi() % 100

	if (v < 25):
		call_deferred("_drop_weapon")
	queue_free()

func _drop_weapon():
	var w = Pickup.instance()
	w.position = global_position
	get_parent().add_child(w)

# ======================================
# Private Methods: Movement
# ======================================

func _update_direction() -> void:
	if (target == null): return
	direction = (target.position - position).normalized()

# ======================================
# Private Methods: Detection
# ======================================


func _on_detect(body: Node) -> void:
	if (body.is_in_group("player")):
		target = body


func _on_undetect(body: Node) -> void:
	if (body == target):
		target = null
		direction = Vector2.ZERO

# ======================================
# Private Methods: Attack
# ======================================

func _check_attack():
	if (timers.attack.time_left <= 0 && can_attack):
		_attack()
		timers.attack.start()

func _attack():
	if (target != null):
		target.damage(stats.damage)


func _on_attack_range_entry(body: Node) -> void:
	if (body.is_in_group("player")):
		can_attack = true

func _on_attack_range_exit(body: Node) -> void:
	if (body.is_in_group("player")):
		can_attack = false
