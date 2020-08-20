extends Node2D

onready var weapon_name = $Panel/PanelContents/Header/Name
onready var damage = $Panel/PanelContents/Header/Damage
onready var type = $Panel/PanelContents/Stats/Type/Value
onready var accuracy = $Panel/PanelContents/Stats/Accuracy/Value
onready var buildup = $Panel/PanelContents/Stats/Buildup/Value
onready var delay = $Panel/PanelContents/Stats/Delay/Value

func update_text(weapon: Node) -> void:
	weapon_name.text = weapon.title
	damage.text = str(weapon.damage) + "x" + str(weapon.projectile_amount)
	accuracy.text = str(weapon.accuracy)
	type.text = str(weapon.type)
	accuracy.text = str(weapon.accuracy)
	buildup.text = str(weapon.buildup)
	delay.text = str(weapon.delay)
	weapon_name.get_stylebox("normal").bg_color = Global.rarity_color[weapon.rarity]
