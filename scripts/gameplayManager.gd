extends Node

const POINT_COUNTER = preload("res://escenas/canvas_layer.tscn")
const PUNTOS = preload("res://escenas/puntos.tscn")
const PUNTOS_PEQUEÑOS = preload("res://escenas/puntos_pequeños.tscn")
const PERSONAJE = preload("res://escenas/personaje.tscn")


@onready var initialposition: Marker2D = $Marker2D

var current_pointer: int = 0
var counter_ref:Node

@onready var colecionables_grandes: Node2D = $ColecionablesGrandes
@onready var coleccionables_pequeños: Node2D = $ColeccionablesPequeños

var pos_array_grandes: Array[Vector2] = []
var pos_array_pequenos: Array[Vector2] = []

func _ready() -> void:
	counter_ref =  POINT_COUNTER.instantiate()
	add_child(counter_ref)
	colecionables_grandes = get_tree().get_root().get_node("Main/ColecionablesGrandes")
	coleccionables_pequeños = get_tree().get_root().get_node("Main/ColeccionablesPequeños")
	for marker in colecionables_grandes.get_children():
		if marker is Marker2D:
			pos_array_grandes.append(marker.global_position)
	for marker in coleccionables_pequeños.get_children():
		if marker is Marker2D:
			pos_array_pequenos.append(marker.global_position)

	spawn_coleccionables()
	

func add_points(newPoints:int) -> void:
	current_pointer += newPoints
	var label:Label = counter_ref.get_child(0)
	label.text = "Points: "+ str(current_pointer)

func reset()-> void:
	get_tree().reload_current_scene()
	#var personaje = PERSONAJE.instantiate()
	#personaje.global_position = initialposition.global_position
	#clear_coleccionables()
	#spawn_coleccionables()
	
func spawn_coleccionables()->void:
	for pos in pos_array_grandes:
		var nuevo = PUNTOS.instantiate()
		nuevo.global_position = pos
		nuevo.add_to_group("Coleccionable")
		add_child(nuevo)
	for pos in pos_array_pequenos:
		var nuevo = PUNTOS_PEQUEÑOS.instantiate()
		nuevo.global_position = pos
		nuevo.add_to_group("Coleccionable")
		add_child(nuevo)

func clear_coleccionables() -> void:
	for nodo in get_tree().get_nodes_in_group("Coleccionable"):
		nodo.queue_free()
