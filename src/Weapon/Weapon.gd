extends Node2D

# -------------------------------------
# Node References
# -------------------------------------

onready var animator = $Animator
onready var projectile_spawner = $ProjectileSpawner
onready var delay_timer = $Delay
var projectile_patterns = []

# -------------------------------------
# Vars
# -------------------------------------

var attack_type = "stab"
var delay = 0.5

# -------------------------------------
# Overrides
# -------------------------------------

func _ready():
	delay_timer.wait_time = delay

# -------------------------------------
# Methods
# -------------------------------------

func attack():
	if (delay_timer.time_left == 0):
		animator.stop()
		animator.play(attack_type)
		delay_timer.start()
		projectile_spawner.spawn(global_position, rotation, projectile_patterns)

