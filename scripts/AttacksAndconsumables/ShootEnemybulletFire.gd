extends Area2D

class_name enemyProjectile

var speed = 35
var bulletFDmg = 2 #Dmg value of bullet
var player: CharacterBody2D
var enemy
func _ready():
	#print(get_parent())
	pass
	
func _physics_process(delta):	
	#Move the bullet, change direction should the sprite be flipped
	if $Sprite2D.flip_h == true:
		speed = -35
		#print(speed)
	position += transform.x * speed 
	

func _on_body_entered(body):
	#If hits player, deal damage
	if body.is_in_group("Player"):
		body.takeDamage()
		queue_free()
	#If touching anything that isn't the player, destroy object
	if !body.is_in_group("Enemy"):
		queue_free()
