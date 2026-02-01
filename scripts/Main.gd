# Junior Developer Simulator - Main Scene
# Godot 4 - Flat Vector Art Design

extends Node2D

# Camera zoom states
var is_zoomed_in := false
var zoom_target := Vector2(0.4, 0.4)
var zoom_default := Vector2(1.0, 1.0)
var zoom_speed := 4.0

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

func _process(delta):
	# Smooth zoom
	var target_zoom = zoom_target if is_zoomed_in else zoom_default
	camera.zoom = camera.zoom.lerp(target_zoom, zoom_speed * delta)
	
	# Smooth camera movement
	var target_pos = Vector2(960, 600) if is_zoomed_in else Vector2(960, 540)
	camera.global_position = camera.global_position.lerp(target_pos, zoom_speed * delta)
	
	# Fade player when zoomed
	if player:
		player.modulate.a = lerpf(player.modulate.a, 0.0 if is_zoomed_in else 1.0, 6.0 * delta)

func _input(event):
	if event.is_action_pressed("ui_cancel") and is_zoomed_in:
		zoom_out()
	
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if not is_zoomed_in:
			var click_pos = get_global_mouse_position()
			var monitor_pos = monitor.global_position
			var monitor_rect = Rect2(monitor_pos.x - 150, monitor_pos.y, 300, 170)
			if monitor_rect.has_point(click_pos):
				zoom_in()

func zoom_in():
	is_zoomed_in = true
	zoom_hint.visible = true

func zoom_out():
	is_zoomed_in = false
	zoom_hint.visible = false

func add_money(amount: int):
	money += amount
	$UILayer/MoneyLabel.text = "💰 " + str(money) + " €"

func add_xp(amount: int):
	reputation += amount
	$UILayer/XPLabel.text = "⭐ " + str(reputation) + " XP"
