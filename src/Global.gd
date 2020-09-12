extends Node

var score = 0

var health_bar_colors = [
	Color(0,0,0,0.1),		# 0 (bg)
	Color.crimson, 			# >0
	Color.chocolate, 		# >100
	Color.gold, 			# >200
	Color.lime, 			# >300
	Color.royalblue, 		# >400
	Color.darkorchid, 		# >500
	Color.deeppink, 		# >600
	Color.webmaroon, 		# >700
	Color.sienna, 			# >800
	Color.darkgoldenrod, 	# >900
	Color.darkolivegreen, 	# >1000
	Color.darkslateblue, 	# >1100
	Color.indigo, 			# >1200
	Color.maroon, 			# >1300
	Color.lightpink, 		# >1400
	Color.sandybrown, 		# >1500
	Color.palegoldenrod, 	# >1600
	Color.palegreen, 		# >1700
	Color.powderblue, 		# >1800
	Color.thistle, 			# >1900
]


enum rarity {
	COMMON = 0,
	UNCOMMON = 1,
	RARE = 2,
	EPIC = 3,
	LEGENDARY = 4
}

var rarity_color = [
	Color(0.5, 0.5, 0.5, 1),
	Color(0.2, 0.8, 0.2, 1),
	Color(0.2, 0.2, 0.8, 1),
	Color(0.8, 0.0, 0.8, 1),
	Color(0.8, 0.2, 0.2, 1),
]

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
