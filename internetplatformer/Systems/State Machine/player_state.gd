## Used for states specifically for the Player character
@abstract class_name PlayerState
extends State

var parent: CharacterBody2D
## Records player's left and right inputs, returns -1, 0, or 1
var input_axis: float
var x_speed: float
var gravity_mult: float = 0.7

func process_physics(delta: float) -> State:
	parent.move_and_slide()
	x_speed = get_xspeed()
	return null

func apply_gravity(delta):
	parent.velocity += parent.get_gravity() * 0.7 * delta

func get_xspeed() -> float:
	return parent.velocity.x

func enable_sprite_flip():
	parent.sprite.flip_h = input_axis < 0

# TODO detect whole instance of tiles
func get_tile_data() -> void:
	if parent.is_on_floor():
		var tilemap: TileMapLayer = get_tree().get_first_node_in_group("Tilemaps")
		var cell: Vector2 = tilemap.local_to_map(parent.position) + Vector2i(0,1) # gets tile below player
		var data: TileData = tilemap.get_cell_tile_data(cell)
		
		if not data:
			return
		
		if data.get_custom_data("vanishable"):
			print(tilemap.get_surrounding_cells(cell))
			for i in tilemap.get_surrounding_cells(cell):
				tilemap.erase_cell(i)
			tilemap.erase_cell(cell)

#func get_object_data() -> void:
	#if parent.is_on_floor():
		#var tilemap = get_tree().get_nodes_in_group("Tilemaps")
		#var object_tilemap = tilemap.get(1)
		#var cell: Vector2 = object_tilemap.local_to_map(parent.position) + Vector2i(0,1) # gets tile below player
		#var data: TileData = object_tilemap.get_cell_tile_data(cell)
		#
		#if data:
			#print("this is an object")
		#
		#if not data:
			#return
		#
		
