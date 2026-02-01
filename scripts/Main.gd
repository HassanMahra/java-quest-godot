# Junior Developer Simulator - Main Scene
# GDScript - Godot 4

extends Node2D

# Camera zoom states
var is_zoomed_in := false
var zoom_target := Vector2(0.25, 0.25)  # Zoomed in
var zoom_default := Vector2(1.0, 1.0)   # Zoomed out
var zoom_speed := 3.0

# Game state
var money := 0
var reputation := 0
var day := 1
var current_task = null
var completed_tasks := []

# Nodes - Godot 4 uses @onready
@onready var camera := $Camera2D
@onready var office_scene := $OfficeScene
@onready var monitor_screen := $OfficeScene/Desk/Monitor/Screen
@onready var character := $OfficeScene/Character
@onready var ui_layer := $UILayer
@onready var zoom_hint := $UILayer/ZoomHint

func _ready():
	# Initial setup
	camera.zoom = zoom_default
	zoom_hint.visible = false
	
	# Connect monitor click
	var monitor_area = $OfficeScene/Desk/Monitor/ClickArea
	monitor_area.input_event.connect(_on_monitor_clicked)
	
	print("Junior Developer Simulator started!")
	print("Click on the monitor to zoom in.")

func _process(delta):
	# Smooth zoom transition
	var target_zoom = zoom_target if is_zoomed_in else zoom_default
	camera.zoom = camera.zoom.lerp(target_zoom, zoom_speed * delta)
	
	# Smooth camera position (focus on monitor when zoomed)
	var target_pos = $OfficeScene/Desk/Monitor.global_position if is_zoomed_in else Vector2(640, 360)
	camera.global_position = camera.global_position.lerp(target_pos, zoom_speed * delta)
	
	# Hide character when zoomed (you ARE the character)
	character.modulate.a = lerpf(character.modulate.a, 0.0 if is_zoomed_in else 1.0, 5.0 * delta)

func _input(event):
	# ESC to zoom out
	if event.is_action_pressed("ui_cancel") and is_zoomed_in:
		zoom_out()

func zoom_in():
	if not is_zoomed_in:
		is_zoomed_in = true
		zoom_hint.visible = true
		print("Zoomed in to monitor")

func zoom_out():
	if is_zoomed_in:
		is_zoomed_in = false
		zoom_hint.visible = false
		print("Zoomed out to office view")

func _on_monitor_clicked(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if not is_zoomed_in:
			zoom_in()

# Game logic functions
func add_money(amount: int):
	money += amount
	print("Money: ", money, " €")

func add_reputation(amount: int):
	reputation += amount
	print("Reputation: ", reputation, " XP")

func complete_task(task_id: int):
	completed_tasks.append(task_id)
	current_task = null
	print("Task ", task_id, " completed!")
