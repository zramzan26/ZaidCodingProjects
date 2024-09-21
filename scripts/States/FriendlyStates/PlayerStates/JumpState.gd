extends State
class_name JumpState
var has_jumped : bool = false
var JUMP_VELOCITY = -300
var player
var gravity = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_parent()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if !player.is_on_floor():
		player.velocity.y +=gravity
		if player.is_on_floor():
			get_parent().change_state("idle")
	if Input.is_action_just_pressed("jump") && player.is_on_floor():
		player.velocity.y += JUMP_VELOCITY
		if player.is_on_floor():
			get_parent().change_state("idle")
	var horizontal_direction = Input.get_axis("move_left","move_right")
	player.velocity.x = SPEED * horizontal_direction
	
		
