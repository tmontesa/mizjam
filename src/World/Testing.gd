extends Node2D

onready var Enemy = preload("res://Enemy/Enemy.tscn")

onready var WorldGenerator = preload("res://WorldGenerator/WorldGenerator.gd")

onready var entities = $Entities


func _ready() -> void:
	var world_generator = WorldGenerator.new(entities)
	world_generator.generate()
