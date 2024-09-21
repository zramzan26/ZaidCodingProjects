extends EnemyState
class_name WanderState


# Called when the node enters the scene tree for the first time.
var enemy
var wander_time_enemy
var wander_time
var speed = 100.0
var area2d
func _ready():
	#Get values from parent node, and assign the parent node
	enemy = get_parent().get_parent()
	#Assign variables
	wander_time_enemy = get_parent().WANDER_TIME_INIT
	area2d = enemy.get_node("BoxEnemyArea")
	wander_time = wander_time_enemy
	#Connect signal through code since this script is generated post-running
	area2d.body_entered.connect(_on_body_entered)
	
	
	
func _physics_process(delta):
	
	enemy.velocity.x = speed
	#Wander time basically handles when to switch directions
	#Its just moving back and forth
	wander_time -=delta
	
	
	if(wander_time <= 0):
		wander_time = wander_time_enemy
		speed  *= -1
		
	
func _on_body_entered(body):
	#If area2d is entered, start chasin
	if body.is_in_group("Player"):
		get_parent().change_state("chase")
