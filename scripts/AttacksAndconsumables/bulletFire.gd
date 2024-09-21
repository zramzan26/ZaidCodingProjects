extends Area2D

class_name Projectile

var speed = 35
var bulletFDmg = 2 #Dmg value of bullet
func _ready():
	#If the player is facing right, shoot right
	if Global.player_flipped == false:
		speed = speed
	else: 
	#Otherwise, flip the bullet sprite and shoot left
		speed = speed * -1
		$Sprite2D.flip_h = true
func _physics_process(delta):	
	#Move the bullet
	position += transform.x * speed 
		

func _on_body_entered(body):
	#If hits enemy, deal damage
	if body.is_in_group("Enemy"):
		body.takeDamage(bulletFDmg)
	#If touching anything that isn't the player, destroy object
	if !body.is_in_group("Player"):
		queue_free()
