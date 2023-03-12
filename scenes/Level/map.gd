extends TileMap

@onready var corruption_particles = preload("res://scenes/components/corruption.tscn")

var map: Array = []

func _ready():
	setup_map_data()
	set_corruption_particles()

func print_map():
	for row in map:
		print(row)

func setup_map_data():
	var map_size = get_used_rect().size
	print(map_size)
	for y in range(map_size.y + 1):
		var row = []
		for x in range(map_size.x + 1):
			var tile_info = {}
			tile_info.map_coordinates = Vector2(x,y)
			tile_info.coordinates = map_to_local(tile_info.map_coordinates)
			row.append(tile_info)
		map.append(row)

func set_corruption_particles():
	var used_cells = get_used_cells(0)
	for cell in used_cells:
		var cell_data = map[cell.y][cell.x]
		var particles = corruption_particles.instantiate()
		particles.emitting = false
		particles.amount = 1
		particles.global_position = cell_data.coordinates
		cell_data.corruption = 1
		cell_data.particles = [particles]
		self.add_child(particles)

func change_corruption(pos, amount):
	var map_position = local_to_map(pos)
	var cell = map[map_position.y][map_position.x]
	if cell.has("corruption"):
		cell.corruption = clamp(cell.corruption + amount, 0, 100)
		smooth_change_amount(cell)
	
func smooth_change_amount(cell):
	var old_particle = cell.particles[0]
	var particles = corruption_particles.instantiate()
	particles.amount = cell.corruption
	particles.emitting = true if cell.corruption > 0 else false
	particles.global_position = old_particle.global_position
	cell.particles.append(particles)
	self.add_child(particles)
	await get_tree().create_timer(0.2).timeout
	cell.particles.pop_front().queue_free()

func connect_signal(node):
	node.change_corruption.connect(change_corruption)
	#signal change_corruption(pos, amount)
