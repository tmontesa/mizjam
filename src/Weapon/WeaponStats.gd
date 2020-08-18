extends Node

# ======================================
# Vars
# ======================================

export(float) var buildup_time
var buildup_speed

export(float) var attack_time
var attack_speed

export(float) var delay_time
var delay_speed

export(float) var damage

# ======================================
# Overrides
# ======================================

func _ready() -> void:
	buildup_speed = 1 / buildup_time
	attack_speed = 1 / attack_time
	delay_speed = 1 / delay_time
