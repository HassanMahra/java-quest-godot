# Kenney Character - Sprite-based modular character
extends Node2D

@export var is_typing := true

var type_timer := 0.0

@onready var arm_l := $ArmL
@onready var arm_r := $ArmR
@onready var hand_l := $ArmL/Hand
@onready var hand_r := $ArmR/Hand
@onready var head := $Head
@onready var body := $Body

func _process(delta):
	# Breathing animation
	var breath = sin(Time.get_ticks_msec() / 1000.0) * 2.0
	body.position.y = breath
	head.position.y = -55 + breath * 0.7
	
	# Typing animation
	if is_typing:
		type_timer += delta * 5.0
		
		# Arms move alternately
		arm_l.rotation = sin(type_timer) * 0.15
		arm_r.rotation = sin(type_timer + PI) * 0.15
		
		# Hands move up/down
		hand_l.position.y = 35 + sin(type_timer) * 5
		hand_r.position.y = 35 + sin(type_timer + PI) * 5

func start_typing():
	is_typing = true

func stop_typing():
	is_typing = false
	arm_l.rotation = 0
	arm_r.rotation = 0
