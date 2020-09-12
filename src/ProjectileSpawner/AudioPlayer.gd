extends AudioStreamPlayer2D

onready var sword_audio = preload("res://ProjectileSpawner/assets/sword.wav")
onready var spear_audio = preload("res://ProjectileSpawner/assets/spear.wav")
onready var hammer_audio = preload("res://ProjectileSpawner/assets/hammer.wav")

func set_weapon_audio(s):
	if (s== "sword"):
		stream = sword_audio
	if (s== "spear"):
		stream = spear_audio
	if (s== "hammer"):
		stream = hammer_audio
