# Pixel Character - The Junior Developer
# Godot 4

extends Node2D

var blink_timer := 0.0
var blink_interval := 3.0
var is_blinking := false

@onready var left_eye := $Head/LeftEye
@onready var right_eye := $Head/RightEye

func _ready():
	randomize()
	blink_interval = randf_range(2.0, 5.0)

func _process(delta):
	# Blinking animation
	blink_timer += delta
	if blink_timer >= blink_interval:
		blink()
		blink_timer = 0.0
		blink_interval = randf_range(2.0, 5.0)
	
	# Subtle breathing animation
	var breath = sin(Time.get_ticks_msec() / 1000.0) * 0.5
	position.y += breath * delta

func blink():
	is_blinking = true
	left_eye.scale.y = 0.1
	right_eye.scale.y = 0.1
	
	# Open eyes after short delay
	await get_tree().create_timer(0.1).timeout
	left_eye.scale.y = 1.0
	right_eye.scale.y = 1.0
	is_blinking = false
