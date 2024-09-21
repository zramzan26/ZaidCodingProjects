extends EnemyState
class_name ShootState

var enemy
var area2d
var player: CharacterBody2D
var direction
var haveShot = false

@export var SHOT_SPEED = 35
@onready var projectile = preload("res://nonLevelScenes/AttacksAndConsumable/shoot_enemybullet_fire.tscn")
@onready var bulletPos = get_parent().get_parent().get_node("bullet_pos_right")
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
	#Check the side of the player
	direction = player.global_position - enemy.global_position
	#change the spawn location of the bullet depending on the side of the player
	if direction.x > 0:
		bulletPos.position.x = 26
	else:
		bulletPos.position.x = -86
	#if the interval of shooting cooldown has passed, shoot than start the 
	#interval timer again
	if (get_parent().get_parent().can_shoot == true):
		shoot()
		
		get_parent().get_parent().can_shoot = false
		get_parent().get_parent().timer.start()

	
		
	
func shoot():
	#create the projectile instance
	var projectile_instance: enemyProjectile
	
	
	#If the player is on the right, shoot right, not sure if i need 
	
	if direction.x > 0:
		projectile_instance = projectile.instantiate()
		get_parent().get_parent().get_parent().add_child(projectile_instance)
		#print(projectile_instance.speed)
		projectile_instance.transform = bulletPos.global_transform 
	#otherwise shoot left and flip the sprite
	else:
		projectile_instance = projectile.instantiate()
		get_parent().get_parent().get_parent().add_child(projectile_instance)
		projectile_instance.get_node("Sprite2D").flip_h = true
		
	#Otherwise, flip the bullet sprite and shoot left
		#projectile_instance.Sprite2D.flip_h = true
		#print(projectile_instance.speed)
	projectile_instance.transform = bulletPos.global_transform 

func _on_body_exited(body):
	#If area2d is exited, start wandering
	if body.is_in_group("Player"):
		get_parent().change_state("detect")

