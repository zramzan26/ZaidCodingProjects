extends CharacterBody2D


var state
var damage = 2
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var enemyHealth = 5
var dealtDmg = 1
@onready var coins = preload("res://nonLevelScenes/AttacksAndConsumable/coin.tscn")
var timer = null
var bullet_delay = 2
var can_shoot = true

func _ready():
	#Create a node, state, to hold states. Name the state, add the child to player
	#Change the state to detect, set a timer for the shooting intervals
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(bullet_delay)
	timer.timeout.connect(_on_timeout_complete)
	add_child(timer)
	state = EnemyState.new()
	state.name = "State"
	add_child(state)
	state.change_state("detect")
	
	
	
func _physics_process(delta):
	#Gravity and ability to move around
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
	
	
func death():
	#Get parent object and position on death, generate random number of coins
	#on the death location of the guy and then kill self
	var parent = get_parent()
	var position = self.position
	var rng = RandomNumberGenerator.new()
	var my_random_number = rng.randi_range(0, 3) #Generate random number
	print(my_random_number)
	#if my_random_number == 2 || my_random_number == 1: spawn coins
	while my_random_number > 0:
		var coinSpawn = coins.instantiate()
		parent.call_deferred("add_child", coinSpawn)
		coinSpawn.position = position
		my_random_number -= 1 
	
	
	self.queue_free()
	
func takeDamage(playerAttack):
	#Lower health when taking damage, if health less or equal 0, call death
	enemyHealth -= playerAttack
	if enemyHealth <= 0:
		death()
func _on_timeout_complete():
	#when the timer completes, enable shooting again.
	can_shoot = true
	
