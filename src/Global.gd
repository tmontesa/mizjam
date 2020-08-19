extends Node

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func offset_number(value, multiplier_min, multiplier_max):
	return value * (rng.randf_range(multiplier_min, multiplier_max))

func randv_range(min_v: Vector2, max_v: Vector2):
	var x = rng.randf_range(min_v.x, max_v.x)
	var y = rng.randf_range(min_v.y, max_v.y)
	return Vector2(x, y)

func radial_sample(v: Vector2, r: float):
	return ring_sample(v, 0, r)

func ring_sample(v: Vector2, r_min: float, r_max: float):
	var a = 2 * PI * rng.randf()
	var r = rng.randf_range(r_min, r_max)
	return Vector2(v.x + r * cos(a), v.y + r * sin(a))

func rect_sample(v: Vector2, w: float, h: float):
	var x = rng.randf_range(0, w)
	var y = rng.randf_range(0, h)
	return Vector2(v.x + x - w / 2, v.y + y - h / 2)
