extends PanelContainer

onready var sprite = $Sprite
onready var item_text = $ItemText

func _ready():
#	sprite.connect("mouse_entered", self, "_on_mouse_entry")
#	sprite.connect("mouse_exited", self, "_on_mouse_exit")
	pass

func _on_mouse_entry() -> void:
	item_text.visible = true

func _on_mouse_exit() -> void:
	item_text.visible = false
