extends Node2D

signal change_corruption(pos, amount)

func _ready():
	$Map.connect_signal(self)
	$Map/Enemies/EnemySpawn.start_wave(8)
	
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("change_corruption", event.position, 10)
