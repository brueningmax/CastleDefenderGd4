extends CharacterBody2D

@onready var navigation : Node2D = $enemy_navigation

func _ready():
	pass

func _physics_process(delta):
	velocity = navigation.navigate()
	move_and_slide()
