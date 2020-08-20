extends Node

onready var Weapon = preload("res://Weapon/Weapon.tscn")

const base_damage = 10

enum rarity {
	COMMON = 0,
	UNCOMMON = 1,
	RARE = 2,
	EPIC = 3,
	LEGENDARY = 4
}

var rarity_names = [
	"Junk",
	"Standard",
	"High-Quality",
	"Top-of-the-Line",
	"One-of-a-Kind"
]

var type_index = [
	"sword",
	"hammer",
	"spear"
]


var options = [{
	sword = {
		damage = {min = 0.90, max = 1.1},
		accuracy = {min = 0.90, max = 1.0},
		buildup = {min = 0.90, max = 1.1},
		delay = {min = 0.90, max = 1.1},
		projectile_amount = {min = 1, max = 1},
	},
	hammer = {
		damage = {min = 1.5, max = 1.75},
		accuracy = {min = 0.90, max = 0.95},
		buildup = {min = 1.1, max = 1.25},
		delay = {min = 1.1, max = 1.25},
		projectile_amount = {min = 1, max = 1},
	},
	spear = {
		damage = {min = 0.75, max = 0.85},
		accuracy = {min = 0.80, max = 0.90},
		buildup = {min = 0.6, max = 0.7},
		delay = {min = 0.5, max = 0.6},
		projectile_amount = {min = 1, max = 1},
	},
},
{
	sword = {
		damage = {min = 1.1, max = 1.3},
		accuracy = {min = 0.90, max = 1.0},
		buildup = {min = 0.85, max = 1.0},
		delay = {min = 0.85, max = 1.0},
		projectile_amount = {min = 1, max = 2},
	},
	hammer = {
		damage = {min = 1.75, max = 1.95},
		accuracy = {min = 0.93, max = 0.97},
		buildup = {min = 1.05, max = 1.15},
		delay = {min = 1.0, max = 1.05},
		projectile_amount = {min = 1, max = 2},
	},
	spear = {
		damage = {min = 0.82, max = 0.92},
		accuracy = {min = 0.82, max = 0.92},
		buildup = {min = 0.5, max = 0.6},
		delay = {min = 0.4, max = 0.5},
		projectile_amount = {min = 1, max = 2},
	},
},
{
	sword = {
		damage = {min = 1.4, max = 1.7},
		accuracy = {min = 0.95, max = 1.0},
		buildup = {min = 0.6, max = 0.8},
		delay = {min = 0.65, max = 0.85},
		projectile_amount = {min = 2, max = 4},
	},
	hammer = {
		damage = {min = 2.0, max = 2.5},
		accuracy = {min = 0.97, max = 0.99},
		buildup = {min = 0.9, max = 1.0},
		delay = {min = 0.8, max = 0.9},
		projectile_amount = {min = 2, max = 3},
	},
	spear = {
		damage = {min = 0.97, max = 1.12},
		accuracy = {min = 0.87, max = 0.97},
		buildup = {min = 0.3, max = 0.4},
		delay = {min = 0.2, max = 0.3},
		projectile_amount = {min = 3, max = 4},
	},
},
{
	sword = {
		damage = {min = 1.8, max = 2.25},
		accuracy = {min = 0.98, max = 1.0},
		buildup = {min = 0.4, max = 0.5},
		delay = {min = 0.5, max = 0.6},
		projectile_amount = {min = 3, max = 5},
	},
	hammer = {
		damage = {min = 2.5, max = 3.0},
		accuracy = {min = 0.98, max = 0.99},
		buildup = {min = 0.7, max = 0.83},
		delay = {min = 0.7, max = 0.8},
		projectile_amount = {min = 3, max = 4},
	},
	spear = {
		damage = {min = 1.15, max = 1.35},
		accuracy = {min = 0.9, max = 0.98},
		buildup = {min = 0.15, max = 0.25},
		delay = {min = 0.1, max = 0.2},
		projectile_amount = {min = 4, max = 5},
	},
},
{
	sword = {
		damage = {min = 2.5, max = 3.0},
		accuracy = {min = 1.0, max = 1.0},
		buildup = {min = 0.25, max = 0.35},
		delay = {min = 0.3, max = 0.4},
		projectile_amount = {min = 5, max = 7},
	},
	hammer = {
		damage = {min = 3.75, max = 4.25},
		accuracy = {min = 1.0, max = 1.0},
		buildup = {min = 0.6, max = 0.7},
		delay = {min = 0.54, max = 0.64},
		projectile_amount = {min = 4, max = 6},
	},
	spear = {
		damage = {min = 1.45, max = 1.65},
		accuracy = {min = 0.95, max = 0.99},
		buildup = {min = 0.05, max = 0.1},
		delay = {min = 0.025, max = 0.1},
		projectile_amount = {min = 6, max = 8}
	},
}]

var modifiers = [
	{
		title = "Plain",
		damage = 1.0,
		accuracy = 1.0,
		buildup = 1.0,
		delay = 1.0,
		projectile_amount = 0
	},
	{
		title = "Heavy-Hitter",
		damage = 1.25,
		accuracy = 0.9,
		buildup = 1.1,
		delay = 1.0,
		projectile_amount = 0
	},
	{
		title = "Burdensome",
		damage = 1.5,
		accuracy = 0.6,
		buildup = 1.2,
		delay = 1.2,
		projectile_amount = 0
	},
	{
		title = "Used",
		damage = 0.8,
		accuracy = 0.8,
		buildup = 0.8,
		delay = 0.8,
		projectile_amount = 0
	},
	{
		title = "Hand-Me-Down",
		damage = 0.7,
		accuracy = 0.6,
		buildup = 0.6,
		delay = 0.7,
		projectile_amount = 0
	},
	{
		title = "Straight",
		damage = 0.95,
		accuracy = 1.5,
		buildup = 1.0,
		delay = 1.0,
		projectile_amount = 0
	},
	{
		title = "Shapely",
		damage = 0.90,
		accuracy = 2.0,
		buildup = 0.8,
		delay = 0.8,
		projectile_amount = 0
	},
	{
		title = "Crooked",
		damage = 1.1,
		accuracy = 0.6,
		buildup = 1.1,
		delay = 1.1,
		projectile_amount = 0
	},
	{
		title = "Super-Bent",
		damage = 1.2,
		accuracy = 0.3,
		buildup = 0.8,
		delay = 1.0,
		projectile_amount = 0
	},
	{
		title = "Lightweight",
		damage = 0.95,
		accuracy = 0.95,
		buildup = 0.75,
		delay = 1.0,
		projectile_amount = 0
	},
	{
		title = "Featherweight",
		damage = 0.8,
		accuracy = 0.8,
		buildup = 0.4,
		delay = 1.1,
		projectile_amount = 0
	},
	{
		title = "Hefty",
		damage = 1.1,
		accuracy = 0.9,
		buildup = 1.25,
		delay = 1.0,
		projectile_amount = 0
	},
	{
		title = "Substantial",
		damage = 1.25,
		accuracy = 0.8,
		buildup = 1.5,
		delay = 1.0,
		projectile_amount = 0
	},
	{
		title = "Tactical",
		damage = 1.0,
		accuracy = 1.0,
		buildup = 1.0,
		delay = 0.7,
		projectile_amount = 0
	},
	{
		title = "Highly-Technical",
		damage = 1.1,
		accuracy = 0.5,
		buildup = 1.25,
		delay = 0.2,
		projectile_amount = 0
	},
	{
		title = "Beginner-Friendly",
		damage = 1.1,
		accuracy = 1.0,
		buildup = 1.0,
		delay = 1.2,
		projectile_amount = 0
	},
	{
		title = "Child-Safe",
		damage = 0.7,
		accuracy = 0.5,
		buildup = 0.2,
		delay = 1.7,
		projectile_amount = -1
	},
	{
		title = "Energetic",
		damage = 1.0,
		accuracy = 1.0,
		buildup = 1.0,
		delay = 1.0,
		projectile_amount = 1
	},
	{
		title = "Magical",
		damage = 1.0,
		accuracy = 1.0,
		buildup = 1.0,
		delay = 1.0,
		projectile_amount = 2
	},
	{
		title = "Boring",
		damage = 1.0,
		accuracy = 1.0,
		buildup = 1.0,
		delay = 1.0,
		projectile_amount = -1
	},
	{
		title = "Uninspiring",
		damage = 1.0,
		accuracy = 1.0,
		buildup = 1.0,
		delay = 1.0,
		projectile_amount = -2
	},
	{
		title = "Professional",
		damage = 1.2,
		accuracy = 2.0,
		buildup = 0.9,
		delay = 0.9,
		projectile_amount = 1
	},
	{
		title = "Effective",
		damage = 1.2,
		accuracy = 1.0,
		buildup = 0.5,
		delay = 0.75,
		projectile_amount = 0
	},
	{
		title = "Punctual",
		damage = 1.2,
		accuracy = 1.0,
		buildup = 1.0,
		delay = 0.2,
		projectile_amount = 0
	},
	{
		title = "Daring",
		damage = 1.2,
		accuracy = 1.0,
		buildup = 1.0,
		delay = 1.0,
		projectile_amount = 1
	},
	{
		title = "Honed",
		damage = 1.0,
		accuracy = 2.0,
		buildup = 0.5,
		delay = 0.6,
		projectile_amount = 0
	},
	{
		title = "Artisan",
		damage = 1.0,
		accuracy = 2.0,
		buildup = 1.0,
		delay = 0.25,
		projectile_amount = 0
	},
	{
		title = "Marksman",
		damage = 1.1,
		accuracy = 2.5,
		buildup = 1.0,
		delay = 1.0,
		projectile_amount = 1
	},
	{
		title = "Rapid-Fire",
		damage = 1.0,
		accuracy = 1.0,
		buildup = 0.3,
		delay = 0.5,
		projectile_amount = 0
	},
	{
		title = "Happy-Go-Lucky",
		damage = 1.0,
		accuracy = 1.0,
		buildup = 0.4,
		delay = 0.6,
		projectile_amount = 1
	},
	{
		title = "Overclocked",
		damage = 1.2,
		accuracy = 1.0,
		buildup = 0.3,
		delay = 0.5,
		projectile_amount = 0
	},
	{
		title = "Perfected",
		damage = 1.2,
		accuracy = 2.0,
		buildup = 0.5,
		delay = 0.6,
		projectile_amount = 1
	},
	{
		title = "Trash-Bin",
		damage = 0.8,
		accuracy = 0.5,
		buildup = 1.1,
		delay = 1.1,
		projectile_amount = 0
	},
	{
		title = "Insulting",
		damage = 0.7,
		accuracy = 0.2,
		buildup = 1.2,
		delay = 1.0,
		projectile_amount = -1
	},
	{
		title = "One-Shot",
		damage = 2.0,
		accuracy = 2.0,
		buildup = 1.25,
		delay = 1.25,
		projectile_amount = -3
	},
]

func generate(rarity = Global.rng.randi() % 5):
	var weapon = Weapon.instance()

	var modifier = modifiers[Global.rng.randi() % modifiers.size()]

	weapon.rarity = rarity
	weapon.type = type_index[Global.rng.randi() % type_index.size()]
	weapon.damage = round(base_damage * modifier.damage * _get_random_float(options[weapon.rarity][weapon.type].damage))
	weapon.accuracy =  stepify(modifier.accuracy * _get_random_float( options[weapon.rarity][weapon.type].accuracy), 0.01)
	weapon.buildup =  stepify(modifier.buildup * _get_random_float(options[weapon.rarity][weapon.type].buildup), 0.01)
	weapon.delay =  stepify(modifier.delay * _get_random_float(options[weapon.rarity][weapon.type].delay), 0.01)
	weapon.projectile_amount =  clamp(_get_random_int(options[weapon.rarity][weapon.type].projectile_amount) + modifier.projectile_amount, 1, 10)
	weapon.projectiles = _generate_projectile()

	weapon.title = modifier.title + " " + rarity_names[weapon.rarity] + " " + weapon.type.capitalize()
	return weapon

func _generate_projectile():
	var projectiles = []

	projectiles.append({
		type = Database.Projectile.get_random(),
		speed = 3,
		detonate = true,
		chain = [
			{
				type = Database.Projectile.get_random()
			}
		]
	})

	return projectiles


func _get_random_float(values):
	return Global.rng.randf_range(values.min, values.max)

func _get_random_int(values):
	return Global.rng.randf_range(values.min, values.max)
