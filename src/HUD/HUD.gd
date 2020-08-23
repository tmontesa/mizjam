extends CanvasLayer

onready var Skull = preload("res://HUD/Difficulty.tscn")

onready var slot_1 = $HUDElements/Inventory/Slot1
onready var slot_2 = $HUDElements/Inventory/Slot2
onready var slot_3 = $HUDElements/Inventory/Slot3
onready var item_text_1 = $HUDElements/Inventory/Slot1/ItemText
onready var item_text_2 = $HUDElements/Inventory/Slot2/ItemText
onready var item_text_3 = $HUDElements/Inventory/Slot3/ItemText
onready var item_sprite_1 = $HUDElements/Inventory/Slot1/Sprite
onready var item_sprite_2 = $HUDElements/Inventory/Slot2/Sprite
onready var item_sprite_3 = $HUDElements/Inventory/Slot3/Sprite
onready var health_bar = $HealthBar
onready var health_points = $HealthPoints

onready var loop_progress = $LoopProgress
onready var loop_points = $LoopPoints
onready var loop_number = $LoopNumber
onready var next_wave_time = $NextWaveTime

onready var score = $Score

onready var difficulty = $DifficultyContainer/Difficulty

onready var warning = $Warning

var player = null

func _process(delta: float) -> void:
	if (player != null):
		health_bar.value = player.health
		health_points.text = str(player.health) + "/" + str(player.stats.max_health)

func update_items():
	item_text_1.update_text(player.weapons[0])
	item_text_2.update_text(player.weapons[1])
	item_text_3.update_text(player.weapons[2])

	item_sprite_1.frame = player.weapons[0].sprite.frame
	item_sprite_2.frame = player.weapons[1].sprite.frame
	item_sprite_3.frame = player.weapons[2].sprite.frame

	item_sprite_1.modulate = Global.rarity_color[player.weapons[0].rarity]
	item_sprite_2.modulate = Global.rarity_color[player.weapons[1].rarity]
	item_sprite_3.modulate = Global.rarity_color[player.weapons[2].rarity]

func update_selected_item():
	slot_1.get_stylebox("panel").bg_color = Color(0, 0, 0, 0.25)
	slot_2.get_stylebox("panel").bg_color = Color(0, 0, 0, 0.25)
	slot_3.get_stylebox("panel").bg_color = Color(0, 0, 0, 0.25)

	match (player.weapon_index):
		0: slot_1.get_stylebox("panel").bg_color = Color(1, 1, 1, 0.4)
		1: slot_2.get_stylebox("panel").bg_color = Color(1, 1, 1, 0.4)
		2: slot_3.get_stylebox("panel").bg_color = Color(1, 1, 1, 0.4)

func increase_wave():
	difficulty.add_child(Skull.instance())

func update_next_wave_timer(time):
	next_wave_time.text = time

func update_loop(n, p_max: int):
	loop_number.text = "LV" + str(n)
	loop_progress.max_value = p_max

func update_loop_points(p):
	loop_points.text = str(p) + "/" + str(loop_progress.max_value)
	loop_progress.value = p


