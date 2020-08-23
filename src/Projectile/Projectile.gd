extends Area2D

signal chain(position_, rotation_, projectile_patterns)
onready var lifetime_timer = $Lifetime
onready var audio_player_spawn = $AudioPlayerSpawn
onready var audio_player_hit = $AudioPlayerHit
onready var sprite = $Sprite

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
	audio_player_spawn.pitch_scale = Global.rng.randf_range(0.6, 1.4)
	audio_player_spawn.play()
	if (detonate):
		modulate = Color(1, 1, 0, 1)


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
		audio_player_hit.play()

	if (detonate && !body.is_in_group("player")):
		lifetime_timer.wait_time = 0.2
		lifetime_timer.start()
		velocity *= -0.2
		detonate = false
