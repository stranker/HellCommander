extends Area2D

export var speed = 400.0
export var time_to_destroy = 3
var can_damage = true
var tank_damage
var tank_owner
var direction = Vector2()
var double_damage

signal hit(distance)

func _ready():
	$DistanceTimer.wait_time = time_to_destroy
	$DistanceTimer.start()

func _process(delta):
	translate(direction * speed * delta)
	pass

func initialize(dir, damage, _double_damage, player):
	direction = dir
	rotation = direction.angle()
	tank_damage = damage
	tank_owner = player
	double_damage = _double_damage
	$DoubleDamage.emitting = double_damage
	if double_damage:
		$Trail.amount *= 3
		$Explosion.amount *= 3
		$Explosion.process_material.initial_velocity = 60
	else:
		$Explosion.process_material.initial_velocity = 50
	pass

func _on_Proyectile_body_entered(body):
	if body.is_in_group('Tank') and body != tank_owner and body.is_alive() and can_damage:
		body.take_damage(tank_damage)
		hit_something()
	if body.name.find("Tile")>=0:
		hit_something()
	pass # replace with function body

func hit_something():
	can_damage = !can_damage
	var shake_additive = 1
	if double_damage:
		shake_additive *= 2
	emit_signal('hit',global_position.distance_to(tank_owner.global_position) / shake_additive)
	$Explosion.emitting = true
	$Trail.emitting = false
	$DoubleDamage.emitting = false
	set_process(false)
	$Anim.play('Explosion')
	$LifetimeTimer.start()
	pass

func _on_DistanceTimer_timeout():
	hit_something()
	pass # replace with function body


func _on_LifetimeTimer_timeout():
	queue_free()
	pass # replace with function body
