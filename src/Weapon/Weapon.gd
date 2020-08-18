extends Node2D

# ======================================
# Node References
# ======================================

onready var animator = $Animator
onready var stats = $Stats
onready var projectile_spawner = $ProjectileSpawner

# ======================================
# Vars
# ======================================

var is_attacking: bool = false

# ======================================
# Methods
# ======================================

func attack() -> void:
	if (!is_attacking):
		is_attacking = true
		_play_animation()
		projectile_spawner.initiate()

# ======================================
# Private Methods
# ======================================

func _play_animation() -> void:
	animator.play("buildup", 0, stats.buildup_speed)

func _on_animation_end(anim_name: String) -> void:
	if (anim_name == "buildup"):
		animator.play("attack", 0, stats.attack_speed)

	elif (anim_name == "attack"):
		animator.play("drawback", 0, stats.delay_speed)

	elif (anim_name == "drawback"):
		animator.play("idle", 0, 0)
		is_attacking = false
