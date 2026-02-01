# Flat Vector Character - Smooth shapes
extends Node2D

@export var shirt_color: Color = Color(0.3, 0.5, 0.8)
@export var skin_color: Color = Color(0.96, 0.87, 0.78)
@export var hair_color: Color = Color(0.25, 0.18, 0.12)
@export var is_typing: bool = true

var type_timer := 0.0
var hand_offset := 0.0

func _process(delta):
	if is_typing:
		type_timer += delta * 8.0
		hand_offset = sin(type_timer) * 3.0
		$LeftHand.position.y = 45 + hand_offset
		$RightHand.position.y = 45 - hand_offset
	
	# Subtle breathing
	var breath = sin(Time.get_ticks_msec() / 1500.0) * 1.5
	$Body.position.y = breath
	$Head.position.y = -55 + breath
