extends Node2D

var asteroid_scene = load("res://Objects/Asteroid.tscn")

func _ready() -> void:
	_spawn_asteroid()

func _spawn_asteroid():
	var asteroid = asteroid_scene.instance()
