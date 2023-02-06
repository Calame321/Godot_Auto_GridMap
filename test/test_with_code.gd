extends Node3D

@onready var grid = $GridMap

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(20):
		for z in range(20):
			grid.set_cell_item(Vector3i(x-10,0,z-10),0)	
	grid.update_bitmask_region()
