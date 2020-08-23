extends Node2D

var spawn_points = []
var spawn_point_amount = 0
var spawn_point_choices = []
var spawn_point_choice_index = 0

func _ready() -> void:
	var children = get_children()
	for child in children:
		spawn_points.append(child)
		spawn_point_choices.append(spawn_point_amount)
		spawn_point_amount += 1
	spawn_point_choices.shuffle()

func get_random():
	var s = spawn_point_choices[spawn_point_choice_index]
	spawn_point_choice_index += 1
	if (spawn_point_choice_index >= spawn_point_amount):
		spawn_point_choices.shuffle()
		spawn_point_choice_index = 0

	return spawn_points[s]
