extends Area2D

signal chain(position_, rotation_, projectile_patterns)
onready var lifetime_timer = $Lifetime

var damage: float = 0

var direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO
var speed: float = 0.0
var lifetime: float = 1.0
var knockback: float = 1.0
var chained_patterns = []

var detonate = false

# TODO: Make this less complicated
func _ready():
	var angle = rotation - (PI / 2)
	direction = Vector2(cos(angle), sin(angle)).normalized()
	velocity = direction * speed
	lifetime_timer.wait_time = lifetime
	lifetime_timer.start()

func _physics_process(delta: float) -> void:
	position += velocity

func _on_expiry() -> void:
	if (chained_patterns != []):
		emit_signal("chain", global_position, rotation, chained_patterns)
	queue_free()

func _on_hit(body: Node) -> void:
	if (body.is_in_group("enemy")):
		body.damage(damage)
		body.knockback(direction * knockback)

		if (detonate):
			_on_expiry()
