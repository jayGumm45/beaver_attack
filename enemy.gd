extends CharacterBody2D

signal lose

@export var tilemap: TileGrid
@export var player: Player
@export var move_speed: float = 6.0

var is_moving: bool = false
var target_position: Vector2
var tile_size: Vector2
var can_move = false


func _ready():
	tile_size = tilemap.tile_set.tile_size
	global_position = tilemap.map_to_local(tilemap.local_to_map(global_position))
	target_position = global_position

func _physics_process(delta: float) -> void:
	if is_moving:
		global_position = global_position.move_toward(target_position, move_speed * tile_size.x * delta)
		if global_position.distance_to(target_position) < .5:
			global_position = target_position
			is_moving = false
	else:
		if can_move:
			choose_next_step()
	
	
func choose_next_step():
	var start_cell := tilemap.local_to_map(tilemap.to_local(global_position))
	var end_cell :=tilemap.local_to_map(tilemap.to_local(player.target_position))
	var path = tilemap.find_path_to(start_cell, end_cell)
	if path.size() < 2:
		return #nowhere to go
	else:
		target_position = tilemap.to_global(tilemap.map_to_local(path[1]))
		is_moving = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		can_move = false
		lose.emit()

func _on_game_start() -> void:
	can_move = true


func _on_lose() -> void:
	can_move = false


func _on_character_body_2d_win() -> void:
	can_move = false
