extends Area2D

signal chain(position_, rotation_, projectile_patterns)
onready var lifetime_timer = $Lifetime

var velocity: Vector2 = Vector2.ZERO
var speed: float = 0.0
var lifetime: float = 0.0
var chained_projectile_patterns: Array = []

# TODO: Make this less complicated
func _ready():
	var angle = rotation - (PI / 2)
	velocity = Vector2(cos(angle), sin(angle)) * speed
	lifetime_timer.wait_time = lifetime
	lifetime_timer.start()

func _physics_process(delta: float) -> void:
	position += velocity


func _on_expiry() -> void:
	if (chained_projectile_patterns != []):
		emit_signal("chain", global_position, rotation, chained_projectile_patterns)
	queue_free()
