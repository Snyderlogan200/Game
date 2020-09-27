extends Node

func _ready():
	var rand = RandomNumberGenerator.new()
	var enemyscene = load("res://Asteroid.tscn")
	var screen_size = get_viewport().get_visible_rect().size
	for i in range(0,10):
		var Asteroid = enemyscene.instance()
		rand.randomize()
		var x = rand.randf_range(0,screen_size.x)
		rand.randomize()
		var y = rand.randf_range(0,screen_size.y)
		Asteroid.position.y = y
		Asteroid.position.x = x
		add_child(Asteroid)
