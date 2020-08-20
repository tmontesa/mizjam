extends Node2D

# ======================================
# Node References
# ======================================

var weapon: Node2D = null
var destination: Node2D = null

# ======================================
# Overrides
# ======================================

func _ready() -> void:
	weapon = get_parent()
	destination = weapon.get_parent().get_parent()
	# TODO: Assign better

# ======================================
# Methods
# ======================================

func initiate():
	spawn(global_position, weapon.rotation, weapon.projectiles)

func spawn(position_, rotation_, patterns) -> void:
	for pattern in patterns:

		# Instance projectile using type
		var projectile = pattern.type.instance()

		# Assign mandatory variables
		projectile.damage = weapon.damage
		projectile.position = position_
		projectile.rotation = rotation_ + deg2rad(pattern.get("rotate", 0.0))

		# Assign other variables
		projectile.scale = pattern.get("scale", Vector2(2, 2))
		projectile.lifetime = pattern.get("lifetime", 1.0)
		projectile.speed = pattern.get("speed", 0.1)
		projectile.knockback = pattern.get("knockback", 1.0)
		projectile.detonate = pattern.get("detonate", false)

		# Continue chain if patterns exist
		var chained_patterns = pattern.get("chain", null)
		if (chained_patterns != null):
			projectile.chained_patterns = chained_patterns
			projectile.connect("chain", self, "spawn")

		# Spawn to game node
		destination.add_child(projectile)




