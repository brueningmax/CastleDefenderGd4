extends CharacterBody2D

var speed = 100

@onready var map : TileMap = $%Map
@onready var agent : NavigationAgent2D = $NavAgent

var target = Vector2()

func _ready():
	agent.set_navigation_map(map)
	
func _physics_process(delta):
	if Input.is_action_just_pressed("left_mouse"):
		target = get_global_mouse_position()
		agent.target_position = target
		
	if agent.distance_to_target() > 2:
		var dir = agent.get_next_path_position() - position
		velocity = dir.normalized() * speed
		move_and_slide()
		

func _on_nav_agent_target_reached():
	velocity = Vector2()
