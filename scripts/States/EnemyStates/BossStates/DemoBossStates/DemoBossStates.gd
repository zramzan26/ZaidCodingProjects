extends Node
class_name DemoBossState

#I don't know what this is for ngl
@export var WANDER_TIME_INIT: float = 5.0


var MAX_SPEED = 2000
var ACCELERATION = 1000
var SPEED = 600.0

var states
var current_state



func _init():
	#states will hold all the states for the player
	states = {
		
		"detect": demoBossDetectState,
		"bossShoot": demoBossShootState,
	}
func change_state(new_state_name):
	#Check to see if we have a child, if we have one get the child and
	#destroy it (old state)
	if get_child_count() != 0:
		get_child(0).queue_free()
	#Then get the new name from states and create a new node
	current_state = states.get(new_state_name).new()
	current_state.name = new_state_name
	add_child(current_state)
	
