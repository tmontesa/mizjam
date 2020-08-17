extends Node

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func offset_number(value, multiplier_min, multiplier_max):
	return value * (rng.randf_range(multiplier_min, multiplier_max))
