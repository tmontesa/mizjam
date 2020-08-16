extends Node2D

# -------------------------------------
# Node References
# -------------------------------------

onready var animator = $Animator
onready var projectile_patterns = [
{
	type = Database.Projectile.get("Slash"),
	speed = 0,
	chain = [
	{
		type = Database.Projectile.get("Strike"),
		lifetime = 1.0,
		chain = [
{
	type = Database.Projectile.get("Slash"),
	speed = 3,
	chain = [
	{
		type = Database.Projectile.get("Strike"),
		lifetime = 1.0
	}
	]
},
{
	type = Database.Projectile.get("Slash"),
	rot_add = -15,
	speed = 0,
	chain = [
	{
		type = Database.Projectile.get("Strike"),
		lifetime = 1.0
	}
	]
},
{
	type = Database.Projectile.get("Slash"),
	rot_add = 15,
	speed = 0,
	chain = [
	{
		type = Database.Projectile.get("Strike"),
		lifetime = 1.0
	}
	]
}
]
	}
	]
},
{
	type = Database.Projectile.get("Slash"),
	rot_add = -15,
	speed = 3,
	chain = [
	{
		type = Database.Projectile.get("Strike"),
		lifetime = 1.0
	}
	]
},
{
	type = Database.Projectile.get("Slash"),
	rot_add = 15,
	speed = 3,
	chain = [
	{
		type = Database.Projectile.get("Strike"),
		lifetime = 1.0
	}
	]
}
]
