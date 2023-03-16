extends Node

@onready var Tile_Map = get_tree().get_root().get_node("Game/Map")
@onready var Parent_stats = get_parent().get_node("stats")
var current_tile = Vector2.ZERO
signal change_corruption(pos, amount)

func _ready():
	Tile_Map.connect_signal(self)

func _process(delta):
	corrupt_tile(get_parent().position)

func corrupt_tile(position):
	var occupied_tile = Tile_Map.local_to_map(position)
	if occupied_tile.x != current_tile.x or occupied_tile.y != current_tile.y:
		emit_signal("change_corruption", position, Parent_stats.corruption_rate)
		current_tile = occupied_tile
