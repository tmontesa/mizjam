extends Node2D

onready var target = null

func spawn(position_, rotation_, projectile_patterns):

	print(projectile_patterns.size())

	for projectile_pattern in projectile_patterns:

		var projectile_type = projectile_pattern.get("type")
		var projectile = projectile_type.instance()

		projectile.position = position_
		projectile.rotation = rotation_ + deg2rad(projectile_pattern.get("rot_add", 0.0))
		projectile.lifetime = projectile_pattern.get("lifetime", 1.0)
		projectile.scale = projectile_pattern.get("scale", projectile.scale)
		projectile.speed = projectile_pattern.get("speed", 0)

		projectile.chained_projectile_patterns = projectile_pattern.get("chain", [])

		target.add_child(projectile)
		projectile.connect("chain", self, "spawn")
