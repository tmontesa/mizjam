extends Node
onready var Db = load("res://Database/Database.class.gd")

onready var Projectile = Db.new("res://Projectile/Projectiles")
onready var Enemies = Db.new("res://Enemy/Enemies")

onready var WeaponTextures = {
	Sword = Db.new("res://Weapon/assets/Sword"),
	Spear = Db.new("res://Weapon/assets/Spear"),
	Hammer = Db.new("res://Weapon/assets/Hammer"),
}

onready var Prop = {
	Tree = Db.new("res://Prop/Tree"),
	Rock = Db.new("res://Prop/Rock"),
	Tent = Db.new("res://Prop/Tent"),
	House = Db.new("res://Prop/House"),
	Skull = Db.new("res://Prop/Skull"),
}

onready var Decoration = {
	Grass = Db.new("res://Decoration/Grass"),
	Dirt = Db.new("res://Decoration/Dirt"),
	Road = Db.new("res://Decoration/Road"),
}
