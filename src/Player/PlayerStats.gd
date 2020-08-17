extends Node

export(float) var acceleration = 1200
export(float) var max_speed = 120
export(float) var friction = 1000

export(float) var dodge_acceleration = acceleration * 8
export(float) var dodge_max_speed = max_speed * 3
export(float) var dodge_friction = friction * 0.5
