extends Node2D

onready var pickup_text = $PickupText
var weapon = null
var target = null

func _ready() -> void:
	weapon = WeaponGenerator.generate()
	add_child(weapon)
	pickup_text.update_text(weapon)

func _process(_delta):
	if (target == null): return
	if (Input.is_action_just_pressed("interact")):
		var new_weapon = weapon
		remove_child(new_weapon)
		var old_weapon = target.swap_weapon(weapon)
		self.add_child(old_weapon)
		self.weapon = old_weapon

		old_weapon.rotation = 0
		old_weapon.position = Vector2(0, 0)
		pickup_text.update_text(weapon)



func _on_area_entry(body: Node) -> void:
	if (body.is_in_group("player")):
		pickup_text.visible = true
		target = body

func _on_area_exit(body: Node) -> void:
	if (body == target):
		pickup_text.visible = false
		target = null

func _on_mouse_entry() -> void:
	pickup_text.visible = true

func _on_mouse_exit() -> void:
	pickup_text.visible = false
