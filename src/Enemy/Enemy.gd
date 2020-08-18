extends Character

# ======================================
# Node References
# ======================================

var target: Node2D = null

# ======================================
# Private Methods: Movement
# ======================================

func _update_direction() -> void:
	if (target == null): return
	direction = (target.position - position).normalized()

# ======================================
# Private Methods: Detection
# ======================================


func _on_detect(body: Node) -> void:
	if (body.is_in_group("player")):
		target = body


func _on_undetect(body: Node) -> void:
	if (body == target):
		target = null
		direction = Vector2.ZERO
