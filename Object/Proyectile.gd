extends Area2D

export var speed = 400.0
export var time_to_destroy = 3
var tank_damage
var tank_owner
var direction = Vector2()

signal hit

func _ready():
	$DistanceTimer.wait_time = time_to_destroy
	$DistanceTimer.start()

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
		emit_signal('hit')
		queue_free()
	if body.name.find("Tile")>=0:
		queue_free()
		emit_signal('hit')
	pass # replace with function body

func _on_DistanceTimer_timeout():
	queue_free()
	pass # replace with function body
