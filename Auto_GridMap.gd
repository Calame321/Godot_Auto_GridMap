tool class_name AutoGridMap extends GridMap

export( bool ) var refresh setget set_refresh
export( Resource ) var mesh_library_3d = mesh_library_3d as MeshLibrary

const TUL : = 0x01
const TUR : = 0x02
const TDL : = 0x04
const TDR : = 0x08
const DUL : = 0x10
const DUR : = 0x20
const DDL : = 0x40
const DDR : = 0x80

var meshes: Dictionary
var sub_gridmap : GridMap

func set_refresh( value ):
	print( "Refreshed !" )
	_setup()


func _ready():
	_setup()


func _setup():
	if mesh_library_3d == null:
		return
	
	sub_gridmap = get_node_or_null( "subgridmap" )
	
	if ! sub_gridmap:
		sub_gridmap = GridMap.new()
		add_child( sub_gridmap )
		sub_gridmap.name = "subgridmap"
		sub_gridmap.cell_size = Vector3( 1, 1, 1 )
		sub_gridmap.mesh_library = mesh_library_3d
		sub_gridmap.set_owner( get_tree().edited_scene_root )
	
	var lf_le = mesh_library_3d.find_item_by_name( "LF_LE" ) #  0
	var lf_lf = mesh_library_3d.find_item_by_name( "LF_LF" ) #  1
	var lf_v  = mesh_library_3d.find_item_by_name( "LF_V"  ) #  2
	var lf_f  = mesh_library_3d.find_item_by_name( "LF_F"  ) #  3
	var f_i   = mesh_library_3d.find_item_by_name( "F_I"   ) #  4
	var f_v   = mesh_library_3d.find_item_by_name( "F_V"   ) #  5
	var f_le  = mesh_library_3d.find_item_by_name( "F_LE"  ) #  6
	var f_lf  = mesh_library_3d.find_item_by_name( "F_LF"  ) #  7
	var le_il = mesh_library_3d.find_item_by_name( "LE_IL" ) #  8
	var le_ir = mesh_library_3d.find_item_by_name( "LE_IR" ) #  9
	var le_le = mesh_library_3d.find_item_by_name( "LE_LE" ) # 10
	var le_lf = mesh_library_3d.find_item_by_name( "LE_LF" ) # 11
	var le_v  = mesh_library_3d.find_item_by_name( "LE_V"  ) # 12
	var le_f  = mesh_library_3d.find_item_by_name( "LE_F"  ) # 13
	var i_i   = mesh_library_3d.find_item_by_name( "I_I"   ) # 14
	var i_lel = mesh_library_3d.find_item_by_name( "I_LEL" ) # 15
	var i_ler = mesh_library_3d.find_item_by_name( "I_LER" ) # 16
	var i_v   = mesh_library_3d.find_item_by_name( "I_V"   ) # 17
	var i_f   = mesh_library_3d.find_item_by_name( "I_F"   ) # 18
	var v_f   = mesh_library_3d.find_item_by_name( "V_F"   ) # 19
	var v_i   = mesh_library_3d.find_item_by_name( "V_I"   ) # 20
	var v_le  = mesh_library_3d.find_item_by_name( "V_LE"  ) # 21
	var v_lf  = mesh_library_3d.find_item_by_name( "V_LF"  ) # 22
	var i_lfl = mesh_library_3d.find_item_by_name( "I_LFL" ) # 23
	var i_lfr = mesh_library_3d.find_item_by_name( "I_LFR" ) # 24
	var lf_ir = mesh_library_3d.find_item_by_name( "LF_IR" ) # 25
	var lf_il = mesh_library_3d.find_item_by_name( "LF_IL" ) # 26
	
	meshes = {
		TUL | TUR | TDL | DUL : { "mesh" : lf_le, "orientation" : 0  },
		TUL | TUR | TDR | DUR : { "mesh" : lf_le, "orientation" : 22 },
		TUR | TDR | TDL | DDR : { "mesh" : lf_le, "orientation" : 10 },
		TUL | TDR | TDL | DDL : { "mesh" : lf_le, "orientation" : 16 },
		
		TUL | TUR | TDL | DUL | DUR | DDL : { "mesh" : lf_lf, "orientation" : 0  },
		TUL | TUR | TDR | DUL | DUR | DDR : { "mesh" : lf_lf, "orientation" : 22 },
		TUR | TDR | TDL | DUR | DDR | DDL : { "mesh" : lf_lf, "orientation" : 10 },
		TUL | TDR | TDL | DUL | DDR | DDL : { "mesh" : lf_lf, "orientation" : 16 },
		
		TUL | TUR | TDL : { "mesh" : lf_v, "orientation" : 0  },
		TUL | TUR | TDR : { "mesh" : lf_v, "orientation" : 22 },
		TUR | TDR | TDL : { "mesh" : lf_v, "orientation" : 10 },
		TUL | TDR | TDL : { "mesh" : lf_v, "orientation" : 16 },
		
		TUL | TUR | TDL | DUL | DUR | DDR | DDL : { "mesh" : lf_f, "orientation" : 0  },
		TUL | TUR | TDR | DUL | DUR | DDR | DDL : { "mesh" : lf_f, "orientation" : 22 },
		TUR | TDR | TDL | DUL | DUR | DDR | DDL : { "mesh" : lf_f, "orientation" : 10 },
		TUL | TDR | TDL | DUL | DUR | DDR | DDL : { "mesh" : lf_f, "orientation" : 16 },
		
		TUL | TUR | TDR | TDL | DUL | DDL : { "mesh" : f_i, "orientation" : 0  },
		TUL | TUR | TDR | TDL | DUL | DUR : { "mesh" : f_i, "orientation" : 22 },
		TUL | TUR | TDR | TDL | DUR | DDR : { "mesh" : f_i, "orientation" : 10 },
		TUL | TUR | TDR | TDL | DDR | DDL : { "mesh" : f_i, "orientation" : 16 },
		
		TUL | TUR | TDR | TDL : { "mesh" : f_v, "orientation" : 0 },
		
		TUL | TUR | TDR | TDL | DUL : { "mesh" : f_le, "orientation" : 0 },
		TUL | TUR | TDR | TDL | DUR : { "mesh" : f_le, "orientation" : 22 },
		TUL | TUR | TDR | TDL | DDR : { "mesh" : f_le, "orientation" : 10 },
		TUL | TUR | TDR | TDL | DDL : { "mesh" : f_le, "orientation" : 16 },
		
		TUL | TUR | TDR | TDL | DUL | DUR | DDL : { "mesh" : f_lf, "orientation" : 0 },
		TUL | TUR | TDR | TDL | DUL | DUR | DDR : { "mesh" : f_lf, "orientation" : 22 },
		TUL | TUR | TDR | TDL | DUR | DDR | DDL : { "mesh" : f_lf, "orientation" : 10 },
		TUL | TUR | TDR | TDL | DUL | DDR | DDL : { "mesh" : f_lf, "orientation" : 16 },
		
		TUL | DUL | DUR : { "mesh" : le_il, "orientation" : 0 },
		TUR | DUR | DDR : { "mesh" : le_il, "orientation" : 22 },
		TDR | DDR | DDL : { "mesh" : le_il, "orientation" : 10 },
		TDL | DUL | DDL : { "mesh" : le_il, "orientation" : 16 },
		
		TDL | DDR | DDL : { "mesh" : le_ir, "orientation" : 0 },
		TUL | DUL | DDL : { "mesh" : le_ir, "orientation" : 22 },
		TUR | DUL | DUR : { "mesh" : le_ir, "orientation" : 10 },
		TDR | DUR | DDR : { "mesh" : le_ir, "orientation" : 16 },
		
		TUL | DUL : { "mesh" : le_le, "orientation" : 0 },
		TUR | DUR : { "mesh" : le_le, "orientation" : 22 },
		TDR | DDR : { "mesh" : le_le, "orientation" : 10 },
		TDL | DDL : { "mesh" : le_le, "orientation" : 16 },
		
		TUL | DUL | DUR | DDL : { "mesh" : le_lf, "orientation" : 0 },
		TUR | DUL | DUR | DDR : { "mesh" : le_lf, "orientation" : 22 },
		TDR | DUR | DDR | DDL : { "mesh" : le_lf, "orientation" : 10 },
		TDL | DUL | DDR | DDL : { "mesh" : le_lf, "orientation" : 16 },
	
		TUL : { "mesh" : le_v, "orientation" : 0  },
		TUR : { "mesh" : le_v, "orientation" : 22 },
		TDR : { "mesh" : le_v, "orientation" : 10 },
		TDL : { "mesh" : le_v, "orientation" : 16 },
		
		TUL | DUL | DUR | DDR | DDL : { "mesh" : le_f, "orientation" : 0  },
		TUR | DUL | DUR | DDR | DDL : { "mesh" : le_f, "orientation" : 22 },
		TDR | DUL | DUR | DDR | DDL : { "mesh" : le_f, "orientation" : 10 },
		TDL | DUL | DUR | DDR | DDL : { "mesh" : le_f, "orientation" : 16 },
		
		TUL | TDL | DUL | DDL : { "mesh" : i_i, "orientation" : 0  },
		TUL | TUR | DUL | DUR : { "mesh" : i_i, "orientation" : 22 },
		TUR | TDR | DUR | DDR : { "mesh" : i_i, "orientation" : 10 },
		TDR | TDL | DDR | DDL : { "mesh" : i_i, "orientation" : 16 },
		
		TUL | TUR | DUL : { "mesh" : i_lel, "orientation" : 0  },
		TUR | TDR | DUR : { "mesh" : i_lel, "orientation" : 22 },
		TDR | TDL | DDR : { "mesh" : i_lel, "orientation" : 10 },
		TUL | TDL | DDL : { "mesh" : i_lel, "orientation" : 16 },
		
		TDR | TDL | DDL : { "mesh" : i_ler, "orientation" : 0  },
		TUL | TDL | DUL : { "mesh" : i_ler, "orientation" : 22 },
		TUL | TUR | DUR : { "mesh" : i_ler, "orientation" : 10 },
		TUR | TDR | DDR : { "mesh" : i_ler, "orientation" : 16 },
		
		TUL | TDL : { "mesh" : i_v, "orientation" : 0  },
		TUL | TUR : { "mesh" : i_v, "orientation" : 22 },
		TUR | TDR : { "mesh" : i_v, "orientation" : 10 },
		TDR | TDL : { "mesh" : i_v, "orientation" : 16 },
		
		TUL | TDL | DUL | DUR | DDR | DDL : { "mesh" : i_f, "orientation" : 0  },
		TUL | TUR | DUL | DUR | DDR | DDL : { "mesh" : i_f, "orientation" : 22 },
		TUR | TDR | DUL | DUR | DDR | DDL : { "mesh" : i_f, "orientation" : 10 },
		TDR | TDL | DUL | DUR | DDR | DDL : { "mesh" : i_f, "orientation" : 16 },
		
		DUL | DUR | DDR | DDL : { "mesh" : v_f, "orientation" : 0  },
		
		DUL | DDL : { "mesh" : v_i, "orientation" : 0  },
		DUL | DUR : { "mesh" : v_i, "orientation" : 22 },
		DUR | DDR : { "mesh" : v_i, "orientation" : 10 },
		DDL | DDR : { "mesh" : v_i, "orientation" : 16 },
		
		DUL : { "mesh" : v_le, "orientation" : 0  },
		DUR : { "mesh" : v_le, "orientation" : 22 },
		DDR : { "mesh" : v_le, "orientation" : 10 },
		DDL : { "mesh" : v_le, "orientation" : 16 },
		
		DUL | DUR | DDL : { "mesh" : v_lf, "orientation" : 0  },
		DUL | DUR | DDR : { "mesh" : v_lf, "orientation" : 22 },
		DUR | DDR | DDL : { "mesh" : v_lf, "orientation" : 10 },
		DUL | DDR | DDL : { "mesh" : v_lf, "orientation" : 16 },
		
		TUL | TDL | DUL | DUR | DDL : { "mesh" : i_lfl, "orientation" : 0  },
		TUL | TUR | DUL | DUR | DDR : { "mesh" : i_lfl, "orientation" : 22 },
		TUR | TDR | DUR | DDR | DDL : { "mesh" : i_lfl, "orientation" : 10 },
		TDR | TDL | DUL | DDR | DDL : { "mesh" : i_lfl, "orientation" : 16 },
		
		TUL | TDL | DUL | DDR | DDL : { "mesh" : i_lfr, "orientation" : 0  },
		TUL | TUR | DUL | DUR | DDL : { "mesh" : i_lfr, "orientation" : 22 },
		TUR | TDR | DUL | DUR | DDR : { "mesh" : i_lfr, "orientation" : 10 },
		TDR | TDL | DUR | DDR | DDL : { "mesh" : i_lfr, "orientation" : 16 },
		
		TUL | TDR | TDL | DUL | DDL : { "mesh" : lf_ir, "orientation" : 0  },
		TUL | TUR | TDL | DUL | DUR : { "mesh" : lf_ir, "orientation" : 22 },
		TUR | TDR | TUL | DUR | DDR : { "mesh" : lf_ir, "orientation" : 10 },
		TUR | TDR | TDL | DDL | DDR : { "mesh" : lf_ir, "orientation" : 16 },
		
		TUL | TUR | TDL | DUL | DDL : { "mesh" : lf_il, "orientation" : 0  },
		TUL | TUR | TDR | DUL | DUR : { "mesh" : lf_il, "orientation" : 22 },
		TUR | TDR | TDL | DUR | DDR : { "mesh" : lf_il, "orientation" : 10 },
		TUL | TDR | TDL | DDL | DDR : { "mesh" : lf_il, "orientation" : 16 },
	}


func get_cell_mask( x, y, z ) -> int:
	var mask = 0x0
	
	# corners
	var tul = get_main_cell_item( x - 1, y + 1, z - 1 ) != -1
	var tur = get_main_cell_item( x + 1, y + 1, z - 1 ) != -1
	var tdl = get_main_cell_item( x - 1, y + 1, z + 1 ) != -1
	var tdr = get_main_cell_item( x + 1, y + 1, z + 1 ) != -1
	var dul = get_main_cell_item( x - 1, y - 1, z - 1 ) != -1
	var dur = get_main_cell_item( x + 1, y - 1, z - 1 ) != -1
	var ddl = get_main_cell_item( x - 1, y - 1, z + 1 ) != -1
	var ddr = get_main_cell_item( x + 1, y - 1, z + 1 ) != -1
	
	# The edge on z = 0
	var up_left    = get_main_cell_item( x - 1, y + 1, z ) != -1
	var up_right   = get_main_cell_item( x + 1, y + 1, z ) != -1
	var down_left  = get_main_cell_item( x - 1, y - 1, z ) != -1
	var down_right = get_main_cell_item( x + 1, y - 1, z ) != -1
	
	# The edge on x = 0
	var up_up     = get_main_cell_item( x, y + 1, z - 1 ) != -1
	var up_down   = get_main_cell_item( x, y + 1, z + 1 ) != -1
	var down_up   = get_main_cell_item( x, y - 1, z - 1 ) != -1
	var down_down = get_main_cell_item( x, y - 1, z + 1 ) != -1
	
	# The edge on y = 0
	var ul = get_main_cell_item( x - 1, y, z - 1 ) != -1
	var ur = get_main_cell_item( x + 1, y, z - 1 ) != -1
	var dl = get_main_cell_item( x - 1, y, z + 1 ) != -1
	var dr = get_main_cell_item( x + 1, y, z + 1 ) != -1
	
	# top, down, left, right, front, back
	var t = get_main_cell_item( x    , y + 1, z     ) != -1
	var d = get_main_cell_item( x    , y - 1, z     ) != -1
	var l = get_main_cell_item( x - 1, y    , z     ) != -1
	var r = get_main_cell_item( x + 1, y    , z     ) != -1
	var f = get_main_cell_item( x    , y    , z - 1 ) != -1
	var b = get_main_cell_item( x    , y    , z + 1 ) != -1
	
	if tul and up_left    and up_up     and ul and t and l and f:
		mask = mask | TUL
	if tur and up_right   and up_up     and ur and t and r and f:
		mask = mask | TUR
	if tdl and up_left    and up_down   and dl and t and l and b:
		mask = mask | TDL
	if tdr and up_right   and up_down   and dr and t and r and b:
		mask = mask | TDR
	if dul and down_left  and down_up   and ul and d and l and f:
		mask = mask | DUL
	if dur and down_right and down_up   and ur and d and r and f:
		mask = mask | DUR
	if ddl and down_left  and down_down and dl and d and l and b:
		mask = mask | DDL
	if ddr and down_right and down_down and dr and d and r and b:
		mask = mask | DDR
	
	return mask


func get_main_cell_item( x, y, z ) -> int:
	var new_x : = int( floor( x / 2.0 ) )
	var new_y : = int( floor( y / 2.0 ) )
	var new_z : = int( floor( z / 2.0 ) )
	
	return get_cell_item( new_x, new_y, new_z )


func set_cell_item( x: int, y: int, z: int, item: int, orientation: int = 0 ):
	.set_cell_item( x, y, z, item )
	
	if Engine.editor_hint:
		update_bitmask_area( x, y, z )


func update_bitmask_area( x, y, z ):
	for tx in 4:
		for ty in 4:
			for tz in 4:
				var new_x = ( ( x * 2 ) - 1 ) + tx
				var new_y = ( ( y * 2 ) - 1 ) + ty
				var new_z = ( ( z * 2 ) - 1 ) + tz
				update_sub_cell( new_x, new_y, new_z )


func update_sub_cell( x, y, z ):
	if get_main_cell_item( x, y, z ) == -1:
		sub_gridmap.set_cell_item( x, y, z, -1 )
		return
	
	var mask = get_cell_mask( x, y, z )
	
	if meshes.has( mask ):
		var mesh = meshes[ mask ][ "mesh" ]
		var orientation = meshes[ mask ][ "orientation" ]
		sub_gridmap.set_cell_item( x, y, z, mesh, orientation )
	else:
		sub_gridmap.set_cell_item( x, y, z, -1 )


func update_bitmask_region( start : = Vector3.ZERO, end : = Vector3.ZERO ):
	if start == Vector3.ZERO and end == Vector3.ZERO:
		var used_cells = get_used_cells()
		
		var max_x = 0
		var min_x = 0
		var max_y = 0
		var min_y = 0
		var max_z = 0
		var min_z = 0
		
		for cell in used_cells:
			if max_x < cell.x:
				max_x = cell.x
			if max_y < cell.y:
				max_y = cell.y
			if max_z < cell.z:
				max_z = cell.z
			
			if min_x > cell.x:
				min_x = cell.x
			if min_y > cell.y:
				min_y = cell.y
			if min_z > cell.z:
				min_z = cell.z
		
		start = Vector3( max_x, max_y, max_z )
		end = Vector3( min_x, min_y, min_z )
	
	var distance = ( start - end ).abs()
	
	var start_x = max( start.x, end.x )
	var start_y = max( start.y, end.y )
	var start_z = max( start.z, end.z )
	
	for x in distance.x + 1:
		for y in distance.y + 1:
			for z in distance.z + 1:
				update_cell( start_x - x, start_y - y, start_z - z )


func update_cell( x, y, z ):
	for tx in 2:
		for ty in 2:
			for tz in 2:
				var new_x = ( x * 2 ) + tx
				var new_y = ( y * 2 ) + ty
				var new_z = ( z * 2 ) + tz
				update_sub_cell( new_x, new_y, new_z )




