extends TileMapLayer

class_name TileGrid

var astar := AStarGrid2D.new()

func _ready() -> void:
	astar.region = get_used_rect()
	astar.cell_size = tile_set.tile_size
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar.update()

	var rect = get_used_rect()

	for x in range(rect.position.x, rect.position.x + rect.size.x):
		for y in range(rect.position.y, rect.position.y + rect.size.y):
			var cell = Vector2i(x,y)
			var data = get_cell_tile_data(cell)
			if data == null or not data.get_custom_data("walkable"):
				astar.set_point_solid(cell, true)
				
	#print(find_path_to(Vector2i(0,7),Vector2i(8,7)))

func find_path_to(from_cell: Vector2i, to_cell: Vector2i) -> Array[Vector2i]:
	# Returns cell positions to walk through
	return astar.get_id_path(from_cell, to_cell)
