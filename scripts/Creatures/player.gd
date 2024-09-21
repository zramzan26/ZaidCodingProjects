extends CharacterBody2D
class_name Player
@export var speed = 1200
@export var jump_speed = -1500
@export var gravity = 3500
@onready var bulletPos = get_node("bullet_pos_right")
#DASH VARIABLES
var current_speed
var dashDirection = Vector2(1,0)
var last_action_pressed
var canDash = false
var dashing = false
var damageVal = 1
var direction = 1
var dashSpeed = 2500
@export var projectile: PackedScene
func _ready():
	Global.player = self
func _physics_process(delta):
	#Calls dash function
	# Add gravity every frame
	velocity.y += gravity * delta
	update_health()
	# Input affects x axis only
		#This part just resolves "what if both directions are held at once?"
		#Left is prioritized like in the mega man games
		#Also, now the dashing speed increased is handled here, this fixed the
		#bug where the dash just stop taking input after you jumped
	if Input.is_action_pressed("move_left") && Input.is_action_pressed("move_right"):
		velocity.x = -1 * speed
		if dashing:
			velocity.x = dashDirection.normalized().x * dashSpeed
	else: 
			#This determines the direction by checking the input
		velocity.x = Input.get_axis("move_left", "move_right") * speed
		if dashing:
			velocity.x = dashDirection.normalized().x * dashSpeed
		
	dash()
	FIRE()
	STRIKE()
	move_and_slide()

	# Only allow jumping when on the ground		
	if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = jump_speed

func dash():
	
	if is_on_floor():
		canDash = true
	else:
		canDash = false
	if Input.is_action_pressed("move_right"):
		#If dash is pushed it'll move to the right and the player is facing right
		#Also sets position where bullets spawn
		
		dashDirection = Vector2(1,0)
		Global.player_flipped = false
		bulletPos.position.x = 140
		$MeleeAttack/CollisionShape2D.position.x = 140
	if Input.is_action_pressed("move_left"):
		#If dash is pushed it'll move to the left and the player is facing left
		#Also sets position where bullets spawn
		dashDirection = Vector2(-1,0)
		Global.player_flipped = true
		bulletPos.position.x = -100
		$MeleeAttack/CollisionShape2D.position.x = -100 
	
		
	while Input.is_action_pressed("dash") && canDash:
		#When dash is inputted while canDash, speed up the player
		#in the direction they are facing, disable canDash and enable
		#Dashing for 0.2 seconds with a timer then set it to false
		dashing = true
		#if dashing:
			#velocity.x = dashDirection.normalized().x * 2000
		canDash = false
		
		
		#await get_tree().create_timer(0.01).timeout
		#dashing = false
	if !Input.is_action_pressed("dash"):
		dashing = false
		
func update_health():
	#Healthbar is a graphic on the side, its value = to global health
	var healthbar = $hpbar
	healthbar.value = Global.player_health
func heal_pack(area):
	var heal = area.get("healVal")
	if ( Global.player_health + heal >= Global.player_maxHealth):
		Global.player_health = Global.player_maxHealth
	elif (Global.player_health + heal <= Global.player_maxHealth):
		Global.player_health += heal
	
	area.queue_free()
func ener_pack(energyVal):
	var ener = energyVal
	if (Global.player_energy + ener >= Global.player_maxEnergy):
		Global.player_energy = Global.player_maxEnergy
	elif (Global.player_energy + ener <= Global.player_maxEnergy):
		Global.player_energy += ener
	print(Global.player_energy)
	energyVal.get_parent.queue_free()
	
func coin_collect(area):
	var val = area.get("coinVal")
	Global.player_coins += val
	area.queue_free()
	print(Global.player_coins)
	
func death():
	#kill player node, reset stats and call global death command
	if Global.current_checkpoint == null:
		for node in get_tree().get_nodes_in_group("Player"):
				node.queue_free()
		Global.player_health = Global.player_maxHealth
		Global.player_energy = Global.player_maxEnergy
		Global._death()
	else:
		Global.respawn_player()
	
	
func death_timer():
	#not 100% if still used, but print death then go to title screen
	print("death")
	get_tree().change_scene_to_file("res://title_screen.tscn")
func takeDamage():
	#Get the damage value, then subtract it from player health
	#If its <= 0 call death
	getDamageVal()
	#Currently damageVal is a placeholder set to one at the top.
	Global.player_health -= damageVal
	if Global.player_health <= 0:
		death()
		
		

func getDamageVal():
	pass

func create_projectile():
	#Spawn a projectile as a child of player i think, set its position to
	#bulletPos node, Projectile = bullet_fire class naem
	var projectile_instance: Projectile = projectile.instantiate()
	owner.add_child(projectile_instance)
	projectile_instance.transform = bulletPos.global_transform 
	
func FIRE():
	if Input.is_action_just_pressed("Fire"):
		create_projectile()
	
#On command, the sword will appear and then after a bit disappear		
func STRIKE():
	if Input.is_action_just_pressed("Melee"):
		$MeleeAttack/CollisionShape2D.disabled = false;
		$MeleeAttack/SwordSprite.visible=true;
	else:
		if $MeleeAttack/CollisionShape2D.disabled == false && $MeleeAttack/SwordSprite.visible==true:
			await get_tree().create_timer(0.3).timeout
			$MeleeAttack/CollisionShape2D.disabled = true;
			$MeleeAttack/SwordSprite.visible=false;
		

func _on_playercollision_body_entered(body):
	if body.is_in_group("Enemy"):
		takeDamage()
		
func _consumable_obj_manager(packName,val):
	#Packs are different type of interactable objects, val is their value
	#That you pass into their functions, call the correct function based
	#on their packName
	if packName == "enerVal":
		#ener_pack(val)
		print(val)
	


