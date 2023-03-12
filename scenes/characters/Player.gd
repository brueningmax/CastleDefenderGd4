extends CharacterBody2D
#onready var weapon = $weapon.get_child(0)
#onready var animation_player = $AnimationPlayer

@export var speed: int = 200 
var alive = true


func get_input():
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
#		flip_character(+1)
	if Input.is_action_pressed("ui_left"):
		velocity.x -= speed
#		flip_character(-1)
	if Input.is_action_pressed("ui_down"):
		velocity.y += speed
	if Input.is_action_pressed("ui_up"):
		velocity.y -= speed
	
#	if Input.is_action_just_pressed("ui_select"):
#		weapon.attack()
#

#func flip_character(num):
#	$weapon.scale.x = num
#	$Sprite.scale.x = num

func _physics_process(delta):
	if alive:
		get_input()
#		if velocity.x == 0 and velocity.y == 0:
#			animation_player.play("idle")
#		else:
#			animation_player.play("run")
		move_and_slide()
		velocity = Vector2.ZERO
	
