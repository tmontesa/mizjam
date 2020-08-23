extends AudioStreamPlayer2D

onready var audio_dodge = preload("res://Player/assets/dodge.wav")
onready var audio_hurt = preload("res://Player/assets/hurt.wav")

func play_sound(s):
	pitch_scale = Global.rng.randf_range(0.9, 1.5)
	if (s == "dodge"):
		stream = audio_dodge
	if (s == "hurt"):
		stream = audio_hurt
	play()

