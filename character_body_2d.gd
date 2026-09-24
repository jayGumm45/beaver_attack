extends CharacterBody2D

@onready var _animation_player = $AnimationPlayer

@export var tilemap: TileMapLayer
@export var move_speed: float = 6.0
@export var allow_diagonals: bool = false

var is_moving: bool = false
var target_position: Vector2
var tile_size: Vector2
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	tile_size = tilemap.tile_set.tile_size
	global_position = tilemap.map_to_local(tilemap.local_to_map(global_position))
	target_position = global_position

func _process(_delta):
	if is_moving:
		return
		
	
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		
	if velocity.length() > 0:
		_animation_player.play("walk")
	else:
		_animation_player.stop()
	
	
	if not allow_diagonals and velocity.x != 0 and velocity.y != 0:
		velocity.y = 0  # prioritize horizontal
	
	if velocity.x != 0:
		$Sprite2D.flip_h = velocity.x < 0
		
	if velocity != Vector2.ZERO:
		try_move(velocity.normalized())
		
		

func try_move(dir: Vector2) -> void:
	var destination := global_position + dir * tile_size
	if is_walkable(destination):
		target_position = destination
		is_moving = true
 
func is_walkable(world_pos: Vector2) -> bool:
	var cell := tilemap.local_to_map(tilemap.to_local(world_pos))
	var tile_data := tilemap.get_cell_tile_data(cell)
	if tile_data == null:
		return false  # no tile there = treat as blocked (or flip this for open void)
	return tile_data.get_custom_data("walkable")


func _physics_process(delta: float) -> void:
	if is_moving:
		global_position = global_position.move_toward(target_position, move_speed * tile_size.x * delta)
		if global_position.distance_to(target_position) < .5:
			global_position = target_position
			is_moving = false
	
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
