extends Node2D

@onready var skeleton = preload("res://scenes/characters/enemy.tscn")
@onready var enemies_group = $%Enemies
@onready var timer = $Timer
@onready var players = get_tree().get_nodes_in_group("player")
var wave_size : int
var enemies_spawned : int = 0

func start_wave(given_size):
	wave_size = given_size
	set_timer_until_next_spawn()

func set_timer_until_next_spawn():
	if enemies_spawned <= wave_size:
		var time : float = randf_range(1, 3)
		timer.start(time)

func _on_timer_timeout():
	var new_enemy: CharacterBody2D = skeleton.instantiate()
	new_enemy.global_position = global_position
	enemies_group.add_child(new_enemy)
#	new_enemy.navigation.change_target_to(players[0])
	enemies_spawned += 1
	set_timer_until_next_spawn()
