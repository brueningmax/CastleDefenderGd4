extends Node2D

@onready var map : TileMap = $%Map
@onready var agent : NavigationAgent2D = $NavigationAgent2D
@onready var soft_collision : Area2D = $SoftCollision
@onready var timer : Timer = $Timer
@onready var stats : Node = get_parent().get_node("stats")

@onready var players : Array = get_tree().get_nodes_in_group("player")
@onready var rooms : Array = get_tree().get_nodes_in_group("rooms")

var velocity = Vector2.ZERO
var target

func _ready():
	agent.set_navigation_map(map)
	if randi_range(0,10) > 1:
		change_target_to(players[randi_range(0,players.size() - 1)])
	else:
		change_target_to(players[randi_range(0,players.size() - 1)]) 

func change_target_to(next_target):
	target = next_target
	agent.target_position = target.global_position
	timer.start(0.3)

func navigate():
	if agent.distance_to_target() > 2:
		var dir : Vector2 = agent.get_next_path_position() - global_position
		velocity = dir.normalized() * stats.speed
		velocity += soft_collision.get_push_vector()
	return velocity

func _on_nav_agent_target_reached():
	velocity = Vector2()

func _on_timer_timeout():
	agent.target_position = target.global_position
	timer.start(0.3)
