extends CanvasLayer

onready var fps = $FPS
onready var enemy_points = $EnemyPoints

func _process(delta: float) -> void:
	fps.text = str(Engine.get_frames_per_second()) + " FPS"

func update_enemy_points(p, p_max):
	enemy_points.text = str(p) + "/" + str(p_max) + " EP"

