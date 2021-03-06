extends Node2D

# ======================================
# Node References
# ======================================

onready var sprite = $Sprite
onready var animator = $Animator
onready var projectile_spawner = $ProjectileSpawner
onready var audio_player = $AudioPlayer

# ======================================
# Vars
# ======================================

const base_delay = 3
const base_buildup = 8

var title = ""
var type = null
var rarity: int = Global.rarity.COMMON
var damage: int = 0
var accuracy: float = 1.0
var buildup: float = 1.0
var delay: float = 1.0
var projectile_amount: int = 1
var projectiles: Array = []

var is_attacking: bool = false

# ======================================
# Methods
# ======================================

func attack() -> void:
	if (!is_attacking):
		is_attacking = true
		_play_animation()

# ======================================
# Overrides
# ======================================

func _ready() -> void:
	var sprite_frame = Global.rng.randi() % 5
	if (type == "sword"):
		sprite.frame = sprite_frame
	elif (type == "spear"):
		sprite.frame = 5 + sprite_frame
	elif (type == "hammer"):
		sprite.frame = 10 + sprite_frame

	sprite.modulate = Global.rarity_color[rarity]
	audio_player.set_audio(type)

# ======================================
# Private Methods
# ======================================

func _play_animation() -> void:
	animator.play("buildup", 0, base_buildup / buildup)

func _on_animation_end(anim_name: String) -> void:
	if (anim_name == "buildup"):
		animator.play("attack", 0, 8)
		projectile_spawner.initiate()
		audio_player.play()

	elif (anim_name == "attack"):
		animator.play("drawback", 0, base_delay / delay)
		sprite.modulate = Color(1, 1, 1, 0.1)

	elif (anim_name == "drawback"):
		animator.play("idle", 0, 0)
		sprite.modulate = Global.rarity_color[rarity]
		is_attacking = false
