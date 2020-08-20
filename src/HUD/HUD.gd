extends CanvasLayer

onready var slot_1 = $HUDElements/Inventory/Slot1
onready var slot_2 = $HUDElements/Inventory/Slot2
onready var slot_3 = $HUDElements/Inventory/Slot3
onready var item_text_1 = $HUDElements/Inventory/Slot1/ItemText
onready var item_text_2 = $HUDElements/Inventory/Slot2/ItemText
onready var item_text_3 = $HUDElements/Inventory/Slot3/ItemText
onready var item_sprite_1 = $HUDElements/Inventory/Slot1/Sprite
onready var item_sprite_2 = $HUDElements/Inventory/Slot2/Sprite
onready var item_sprite_3 = $HUDElements/Inventory/Slot3/Sprite

var player = null

func update_items():
	item_text_1.update_text(player.weapons[0])
	item_text_2.update_text(player.weapons[1])
	item_text_3.update_text(player.weapons[2])

	item_sprite_1.texture = player.weapons[0].sprite.texture
	item_sprite_2.texture = player.weapons[1].sprite.texture
	item_sprite_3.texture = player.weapons[2].sprite.texture

	item_sprite_1.modulate = Global.rarity_color[player.weapons[0].rarity]
	item_sprite_2.modulate = Global.rarity_color[player.weapons[1].rarity]
	item_sprite_3.modulate = Global.rarity_color[player.weapons[2].rarity]

func update_selected_item():
	slot_1.get_stylebox("panel").bg_color = Color(0, 0, 0, 0.25)
	slot_2.get_stylebox("panel").bg_color = Color(0, 0, 0, 0.25)
	slot_3.get_stylebox("panel").bg_color = Color(0, 0, 0, 0.25)

	match (player.weapon_index):
		0: slot_1.get_stylebox("panel").bg_color = Color(1, 1, 1, 0.333)
		1: slot_2.get_stylebox("panel").bg_color = Color(1, 1, 1, 0.333)
		2: slot_3.get_stylebox("panel").bg_color = Color(1, 1, 1, 0.333)
