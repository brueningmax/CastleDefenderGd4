extends Node2D

@onready var skeleton = preload("res://scenes/characters/enemy.tscn")
@onready var enemies_group = $%Enemies
@onready var timer = $Timer

var wave_size : int
var enemies_spawned : int = 0

func start_wave(given_size):
	wave_size = given_size
	set_timer_until_next_spawn()

func set_timer_until_next_spawn():
	print("timer")
	if enemies_spawned <= wave_size:
		var time : float = randf_range(1, 3)
		print(time)
		timer.start(time)

func _on_timer_timeout():
	var new_enemy: CharacterBody2D = skeleton.instantiate()
	new_enemy.global_position = global_position
	enemies_group.add_child(new_enemy)
	enemies_spawned += 1
	set_timer_until_next_spawn()
	


