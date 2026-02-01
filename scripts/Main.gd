# Junior Developer Simulator - Main Scene
# Godot 4 - IMPROVED VERSION

extends Node2D

# Camera zoom states
var is_zoomed_in := false
var zoom_target := Vector2(0.3, 0.3)  # Zoomed in
var zoom_default := Vector2(1.0, 1.0)   # Zoomed out
var zoom_speed := 4.0
var camera_target_pos := Vector2(640, 400)

# Game state
var money := 0
var reputation := 0
var day := 1

# Nodes
@onready var camera := $Camera2D
@onready var player := $Office/PlayerDesk/Player
@onready var zoom_hint := $UILayer/ZoomHint
@onready var monitor := $Office/PlayerDesk/Monitor

func _ready():
	camera.zoom = zoom_default
	zoom_hint.visible = false
	print("Junior Developer Simulator gestartet!")
	print("Klick auf deinen Monitor zum Hinsetzen.")

func _process(delta):
	# Smooth zoom
	var target_zoom = zoom_target if is_zoomed_in else zoom_default
	camera.zoom = camera.zoom.lerp(target_zoom, zoom_speed * delta)
	
	# Smooth camera movement
	var target_pos = monitor.global_position + Vector2(130, 60) if is_zoomed_in else Vector2(640, 400)
	camera.global_position = camera.global_position.lerp(target_pos, zoom_speed * delta)
	
	# Fade player when zoomed
	if player:
		player.modulate.a = lerpf(player.modulate.a, 0.0 if is_zoomed_in else 1.0, 6.0 * delta)

func _input(event):
	# ESC to zoom out
	if event.is_action_pressed("ui_cancel") and is_zoomed_in:
		zoom_out()
	
	# Click to zoom in
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if not is_zoomed_in:
			# Check if clicked on monitor area
			var monitor_rect = Rect2(monitor.global_position, Vector2(260, 170))
			if monitor_rect.has_point(event.position / camera.zoom + camera.global_position - get_viewport_rect().size / 2 / camera.zoom):
				zoom_in()

func zoom_in():
	is_zoomed_in = true
	zoom_hint.visible = true
	print("Zoomed in!")

func zoom_out():
	is_zoomed_in = false
	zoom_hint.visible = false
	print("Zoomed out!")

func add_money(amount: int):
	money += amount
	$UILayer/Taskbar/MoneyLabel.text = "💰 " + str(money) + " €"

func add_xp(amount: int):
	reputation += amount
	$UILayer/Taskbar/XPLabel.text = "⭐ " + str(reputation) + " XP"
