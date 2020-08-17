extends Node

onready var Weapon = preload("res://Weapon/Weapon.tscn")

onready var projectile_type_set = WeightedSet.new([
	WeightedEntry.new(Database.Projectile.get("Slash"), 1),
	WeightedEntry.new(Database.Projectile.get("Strike"), 1),
	WeightedEntry.new(Database.Projectile.get("Stab"), 1),
])

onready var lifetime_set = WeightedSet.new([
	WeightedEntry.new(0.1, 1),
	WeightedEntry.new(0.2, 5),
	WeightedEntry.new(0.25, 3),
	WeightedEntry.new(0.3, 1),
])

func generate():
	var weapon = Weapon.instance()

	weapon.projectile_patterns = [
	{
		type = projectile_type_set.pick(),
		lifetime = Global.offset_number(lifetime_set.pick(), 0.95, 1.3)
	}
	]

	return weapon
