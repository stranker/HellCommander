extends Area2D

export var speed = 400.0
var tank_damage
var tank_owner
var direction = Vector2()

func _process(delta):
	translate(direction * speed * delta)
	pass

func initialize(dir, damage, player):
	direction = dir
	rotation = direction.angle()
	tank_damage = damage
	tank_owner = player

func _on_Proyectile_body_entered(body):
	if body.is_in_group('Tank') and body != tank_owner:
		body.take_damage(tank_damage)
		queue_free()
	pass # replace with function body
