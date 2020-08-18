extends Node2D

# ======================================
# Node References
# ======================================

var weapon: Node2D = null
var destination: Node2D = null

# ======================================
# Vars
# ======================================

var projectile_pattern = [
{
	type = "Slash",
	lifetime = 5,
	speed = 5,
	knockback = 150,
	detonate = true,
	chain = [
	{
		type = "Strike",
		lifetime = 0.2,
		scale = Vector2(3, 3),
		knockback = 50,
		chain = [
			{
				type = "Stab",
				lifetime = 0.2,
				speed = -1.5,
				scale = Vector2(1, 3),
				knockback = -100,
				chain = [
				{
					type = "Strike",
					lifetime = 0.2,
					scale = Vector2(1, 1),
					knockback = 100,
				}
				]
			},
			{
				type = "Stab",
				lifetime = 0.2,
				speed = -1.5,
				scale = Vector2(1, 3),
				knockback = -100,
				rotate = 15,
				chain = [
				{
					type = "Strike",
					lifetime = 0.2,
					scale = Vector2(1, 1),
					knockback = 100,
				}
				]
			},
			{
				type = "Stab",
				lifetime = 0.2,
				speed = -1.5,
				scale = Vector2(1, 3),
				knockback = -100,
				rotate = -15,
				chain = [
				{
					type = "Strike",
					lifetime = 0.2,
					scale = Vector2(1, 1),
					knockback = 100,
				}
				]
			}
		]
	}
	]
}
]

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
	spawn(global_position, weapon.rotation, projectile_pattern)

func spawn(position_, rotation_, patterns) -> void:
	for pattern in patterns:

		# Instance projectile using type
		var projectile = Database.Projectile.get(pattern.type).instance()

		# Assign mandatory variables
		projectile.damage = weapon.stats.damage
		projectile.position = position_
		projectile.rotation = rotation_ + pattern.get("rotate", 0.0)

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




