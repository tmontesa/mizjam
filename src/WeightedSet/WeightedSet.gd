extends Reference
class_name WeightedSet

# ======================================
# Vars
# ======================================

var entries = []
var sum = 0

# ======================================
# Overrides
# ======================================

func _init(entries_ = []) -> void:
	entries = entries_
	_calculate_sum()

# ======================================
# Methods
# ======================================

func pick():
	var n = Global.rng.randi() % sum
	for entry in entries:
		if (n < entry.weight):
			return entry.value
		else:
			n -= entry.weight

func add(entry: WeightedEntry):
	entries.append(entry)
	_calculate_sum()

# ======================================
# Private Methods
# ======================================

func _calculate_sum():
	sum = 0
	for entry in entries:
		sum += entry.weight
