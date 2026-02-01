# PlayerCharacter - Modular Flat Design Character
# Smooth polygon-based character with animated limbs
extends Node2D

# Animation state
var is_typing := true
var type_timer := 0.0
var breath_offset := 0.0

# Node references
@onready var arm_l := $Arm_L
@onready var arm_r := $Arm_R
@onready var forearm_l := $Arm_L/Forearm
@onready var forearm_r := $Arm_R/Forearm
@onready var head := $Head
@onready var body := $Body

func _process(delta):
	# Breathing animation (subtle body movement)
	breath_offset = sin(Time.get_ticks_msec() / 1200.0) * 2.0
	body.position.y = breath_offset
	head.position.y = -95 + breath_offset * 0.8
	
	# Typing animation
	if is_typing:
		type_timer += delta * 6.0
		
		# Alternate arm movement for typing
		var left_offset = sin(type_timer) * 0.08
		var right_offset = sin(type_timer + PI) * 0.08
		
		forearm_l.rotation = 0.3 + left_offset
		forearm_r.rotation = -0.3 + right_offset
		
		# Subtle shoulder movement
		arm_l.position.y = -15 + sin(type_timer) * 2
		arm_r.position.y = -15 + sin(type_timer + PI) * 2

func start_typing():
	is_typing = true

func stop_typing():
	is_typing = false
	forearm_l.rotation = 0.3
	forearm_r.rotation = -0.3

# Blink animation
func blink():
	var eye_l = $Head/EyeL
	var eye_r = $Head/EyeR
	
	# Close eyes
	eye_l.scale.y = 0.1
	eye_r.scale.y = 0.1
	
	await get_tree().create_timer(0.1).timeout
	
	# Open eyes
	eye_l.scale.y = 1.0
	eye_r.scale.y = 1.0

func _ready():
	# Random blinking
	_start_blink_timer()

func _start_blink_timer():
	await get_tree().create_timer(randf_range(2.0, 5.0)).timeout
	blink()
	_start_blink_timer()
