# NPC Coworker - Types at their desk
extends Node2D

var type_timer := 0.0
var is_typing := false
var blink_timer := 0.0

@onready var body := $Body
@onready var left_hand := $LeftHand
@onready var right_hand := $RightHand

# Different shirt colors for variety
var shirt_colors = [
	Color(0.035, 0.518, 0.89),   # Blue
	Color(0.4, 0.2, 0.6),         # Purple
	Color(0.2, 0.6, 0.4),         # Green
	Color(0.8, 0.4, 0.2),         # Orange
	Color(0.6, 0.2, 0.4),         # Maroon
]

func _ready():
	# Random shirt color
	if body:
		body.color = shirt_colors[randi() % shirt_colors.size()]
	randomize()

func _process(delta):
	# Typing animation
	type_timer += delta
	if type_timer > 0.15:
		type_timer = 0.0
		is_typing = !is_typing
		if left_hand and right_hand:
			left_hand.position.y = -2 if is_typing else 0
			right_hand.position.y = 0 if is_typing else -2
	
	# Random head movement (looking at screen)
	var head_bob = sin(Time.get_ticks_msec() / 800.0 + position.x) * 1.5
	$Head.position.y = -45 + head_bob
