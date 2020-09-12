extends Node

# ======================================
# Node References
# ======================================

onready var target = self

# ======================================
# Vars
# ======================================

const MIN_BOUNDS = Vector2(-500, -500)
const MAX_BOUNDS = Vector2(500, 500)

# ======================================
# Overrides
# ======================================

func _init(target_) -> void:
	target = target_

# ======================================
# Methods
# ======================================

func generate():
	var town_start = Global.randv_range(MIN_BOUNDS, MAX_BOUNDS)
	_generate_street(town_start, 16)

# ======================================
# Private Methods
# ======================================

func _generate_street(p: Vector2, num_houses: int):
	var length = num_houses * 128
	for i in range(num_houses):
		_generate_house(p + Vector2(128 * i - (length/2), -128))
		_generate_house(p + Vector2(128 * i - (length/2), 128))

	_generate_road(p + Vector2(-length/2, 0), length)
	_generate_enemies(p, 256, 32)

	var s = Database.Prop.Skull.get("Skull").instance()
	s.position = p
	target.add_child(s)

func _generate_house(p: Vector2):
	var h = Database.Prop.House.get_random().instance()
	h.position = p + Vector2(0, 16)
	target.add_child(h)

	_generate_dirt(p, 32, 48, 0)
	_generate_grass(p, 48, 64, 0)
	_generate_trees(p + Vector2(0, 32), 128, 16, 1)

func _generate_road(p: Vector2, length: float):
	var segments = length / 64

	for i in range(segments):
		var d = Database.Decoration.Road.get("Road").instance()
		d.position = p + Vector2(Global.offset_number((64 * i), 0.95, 1.05), Global.offset_number(5, -1.5, 1.5))
		target.add_child(d)

func _generate_trees(p: Vector2, w: float, h: float, n: int):
	for i in range(n):
		var d = Database.Prop.Tree.get_random().instance()
		d.position = Global.rect_sample(p, w, h)
		target.add_child(d)

func _generate_grass(p: Vector2, r_min: float, r_max: float, n: int):
	for i in range(n):
		var d = Database.Decoration.Grass.get_random().instance()
		d.position = Global.ring_sample(p, r_min, r_max)
		target.add_child(d)

func _generate_dirt(p: Vector2, r_min: float, r_max: float, n: int):
	for i in range(n):
		var d = Database.Decoration.Dirt.get_random().instance()
		d.position = Global.ring_sample(p, r_min, r_max)
		target.add_child(d)

func _generate_enemies(p: Vector2, r: float, n: int):
	for i in range(n):
		var e = Database.Enemies.get_random().instance()
		e.position = Global.radial_sample(p, r)
		target.add_child(e)
