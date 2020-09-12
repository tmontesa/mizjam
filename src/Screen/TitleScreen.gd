extends CanvasLayer



func _on_enter(body: Node) -> void:
	if (body.is_in_group("player")):
		get_tree().change_scene("res://World/Testing.tscn")
