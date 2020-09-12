extends Reference
class_name WeightedEntry

# ======================================
# Vars
# ======================================

var value = null
var weight = 0

# ======================================
# Overrides
# ======================================

func _init(value_, weight_: int) -> void:
	value = value_
	weight = weight_
