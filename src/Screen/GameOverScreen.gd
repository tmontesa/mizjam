extends CanvasLayer

onready var score = $Score

func _ready() -> void:
	score.text = str(Global.score)

func _on_enter(body: Node) -> void:
	if (body.is_in_group("player")):
		get_tree().change_scene("res://Screen/TitleScreen.tscn")
