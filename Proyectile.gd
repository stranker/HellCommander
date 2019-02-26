extends Area2D

export var speed = 400.0
var direction = Vector2()

func _process(delta):
	translate(direction * speed * delta)
	pass

func initialize(dir):
	direction = dir
	rotation = direction.angle()