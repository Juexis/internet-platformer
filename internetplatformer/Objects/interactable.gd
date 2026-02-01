class_name Interactable
extends StaticBody2D

## dependency injection for the area_2d in the inspector
@export var interaction_path : NodePath
@onready var interaction_area = get_node(interaction_path)


#func check_player_inside() -> bool:
	#var objects_inside = interaction_area.get_overlapping_bodies()
	#for body in objects_inside:
		#if body.name == "Player":
			#print("player is inside")
			#return true
	#return false
