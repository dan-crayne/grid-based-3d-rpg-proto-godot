@tool
extends Node3D

@export_range(1, 3) var ceiling_height := 2
@export var include_north_wall := true
@export var include_south_wall := true
@export var include_east_wall := true
@export var include_west_wall := true
@export var wall_material: StandardMaterial3D
@export var floor_material: StandardMaterial3D
@export var ceiling_material: StandardMaterial3D

@onready var segment_floor: Node3D = $Floor
@onready var segment_ceiling: Node3D = $Ceiling
@onready var wall_south: Node3D = $WallSouth
@onready var wall_north: Node3D = $WallNorth
@onready var wall_east: Node3D = $WallEast
@onready var wall_west: Node3D = $WallWest

func _ready() -> void:
	_set_walls()
	_set_materials()
	_set_ceiling_height()

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		_set_walls()
		_set_materials()
		_set_ceiling_height()

func _set_walls() -> void:
	_set_wall_state(wall_north, include_north_wall)
	_set_wall_state(wall_south, include_south_wall)
	_set_wall_state(wall_east, include_east_wall)
	_set_wall_state(wall_west, include_west_wall)

func _set_wall_state(wall: Node3D, enabled: bool) -> void:
	wall.visible = enabled
	var collision_shape = wall.find_child("CollisionShape3D") as CollisionShape3D
	if collision_shape:
		collision_shape.disabled = not enabled
			
func _set_ceiling_height() -> void:
	segment_ceiling.position.y = ceiling_height

func _set_materials() -> void:
	if wall_material:
		for wall in [wall_north, wall_south, wall_east, wall_west]:
			var mesh_instance = wall.get_node_or_null("MeshInstance3D")
			if mesh_instance:
				mesh_instance.material_override = wall_material
	if floor_material:
		var floor_mesh = segment_floor.get_node_or_null("MeshInstance3D")
		if floor_mesh:
			floor_mesh.material_override = floor_material
	if ceiling_material:
		var ceiling_mesh = segment_ceiling.get_node_or_null("MeshInstance3D")
		if ceiling_mesh:
			ceiling_mesh.material_override = ceiling_material
