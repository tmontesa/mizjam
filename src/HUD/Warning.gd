extends VBoxContainer

onready var title = $Title
onready var subtitle = $Subtitle
onready var lifetime = $Lifetime

func display_message(t: String, s: String, c: Color = Color(1,1,1,1)):
	visible = true
	title.modulate = c
	title.text = t
	subtitle.text = s
	lifetime.start()

func _on_expiry() -> void:
	visible = false
	title.text = ""
	subtitle.text = ""
