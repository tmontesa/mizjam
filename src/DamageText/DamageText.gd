extends Node2D

onready var lifetime_timer = $Lifetime
onready var damage_number = $DamageNumber

func _ready() -> void:
	lifetime_timer.start()

func damage(n):
	damage_number.text = str(n)

func _on_expiry() -> void:
	queue_free()
