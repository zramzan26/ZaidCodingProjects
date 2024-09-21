extends State
class_name WalkState

var player


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_parent()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed("move_right"):
		player.velocity.x = Input.get_axis("move_left","move_right") * MAX_SPEED
		
	elif Input.is_action_pressed("move_left"):
		player.velocity.x = Input.get_axis("move_left","move_right") * MAX_SPEED
		
		
	else:
		#If not moving, change player to idle state
		get_parent().change_state("idle")
		
