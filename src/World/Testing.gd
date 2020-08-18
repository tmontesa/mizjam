extends Node2D

onready var Enemy = preload("res://Enemy/Enemy.tscn")

onready var entities = $Entities
const num_enemies = 64


func _ready() -> void:
	for i in range(num_enemies):
		var e = Enemy.instance()
		e.position.x = Global.rng.randf_range(0, ProjectSettings.get_setting("display/window/size/width"))
		e.position.y = Global.rng.randf_range(0, ProjectSettings.get_setting("display/window/size/height"))
		entities.add_child(e)
		print(e.position)
