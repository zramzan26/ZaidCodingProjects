extends State
class_name IdleState

var player

func _ready():
	player = get_parent().get_parent()

func _physics_process(delta):
	if Input.is_action_pressed("move_right"):
		get_parent().change_state("walk")
		
	elif Input.is_action_pressed("move_left"):
		get_parent().change_state("walk")
	
	if Input.is_action_pressed("jump"):
		get_parent().change_state("jump")
		
	player.velocity.x = 0
