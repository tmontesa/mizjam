extends Node2D

onready var target = null

func spawn(position_, rotation_, projectile_patterns):

	print("called spawn")
	for projectile_pattern in projectile_patterns:

		var projectile_type = projectile_pattern.get("type")
		var projectile = projectile_type.instance()


		projectile.position = position_
		projectile.rotation = rotation_ + deg2rad(projectile_pattern.get("rot_add", 0.0))
		projectile.lifetime = projectile_pattern.get("lifetime", 1.0)
		projectile.chained_projectile_patterns = projectile_pattern.get("chain", [])

		projectile.speed = projectile_pattern.get("speed", 0)
		target.add_child(projectile)
		projectile.connect("chain", self, "spawn")
