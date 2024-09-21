extends EnemyState
class_name ChaseState

var enemy
var area2d
var player: CharacterBody2D
func _ready():
	#Get values from parent node
	enemy = get_parent().get_parent()
	#Get Area2D for collisions
	area2d = enemy.get_node("BoxEnemyArea")
	#Assign player 
	player = get_tree().get_first_node_in_group("Player")
	#connect the exited signal (since this script is generated bc of state machine)
	area2d.body_exited.connect(_on_body_exited)

func _physics_process(delta):
	#Chase the player
	var direction = player.global_position - enemy.global_position
	enemy.velocity.x = direction.normalized().x * SPEED
	

func _on_body_exited(body):
	#If area2d is exited, start wandering
	if body.is_in_group("Player"):
		get_parent().change_state("wander")
