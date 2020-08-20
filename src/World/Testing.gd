extends Node2D

onready var Player = preload("res://Player/Player.tscn")

onready var WorldGenerator = preload("res://WorldGenerator/WorldGenerator.gd")

onready var entities = null

func _ready() -> void:
	entities = $Map/Entities
	var player = Player.instance()
	entities.add_child(player)

	$HUD.player = player
	$HUD.update_items()
	$HUD.update_selected_item()
	player.connect("weapon_index_changed", $HUD, "update_selected_item")
	player.connect("weapons_changed", $HUD, "update_items")
