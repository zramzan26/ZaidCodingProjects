extends EnemyState
class_name demoBossDetectState


# Called when the node enters the scene tree for the first time.
var enemy
var area2d
func _ready():
	#Get values from parent node, and assign the parent node
	enemy = get_parent().get_parent()
	#Assign variables
	
	area2d = enemy.get_node("BoxEnemyArea")
	#Connect signal through code since this script is generated post-running
	area2d.body_entered.connect(_on_body_entered)
	
	
	
func _physics_process(delta):
	
	pass
		
	
func _on_body_entered(body):
	#If area2d is entered, start chasin
	if body.is_in_group("Player"):
		get_parent().change_state("bossShoot")
