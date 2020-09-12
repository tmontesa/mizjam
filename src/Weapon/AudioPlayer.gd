extends AudioStreamPlayer2D

onready var sword_audio = preload("res://Weapon/assets/sword.wav")
onready var spear_audio = preload("res://Weapon/assets/spear.wav")
onready var hammer_audio = preload("res://Weapon/assets/hammer.wav")

func set_audio(s):
	match(s):
		"sword": stream = sword_audio
		"spear": stream = spear_audio
		"hammer": stream = hammer_audio
