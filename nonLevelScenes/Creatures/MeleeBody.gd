extends Area2D

class_name Melee

var attackDmg = 5
var swordSpriteLocationX
var swordSpriteLocationY
# Called when the node enters the scene tree for the first time.
func _ready():
	#At the start, set the variable locations to the swordsprite's default
	#location to store it
	swordSpriteLocationX = $SwordSprite.position.x
	swordSpriteLocationY = $SwordSprite.position.y
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if the player is not flipped, the sprite should be at the default position
	#No flip, and the positions we stored are applied
	if Global.player_flipped == false:
		$SwordSprite.flip_h=false;
		$SwordSprite.flip_v=false;
		$SwordSprite.position.x = swordSpriteLocationX;
		$SwordSprite.position.y = swordSpriteLocationY
	else:
		#If the player is flipped, the sprite is flipped (and because i made
		# the sprite angled you have to adjust the position too)
		$SwordSprite.flip_h=true;
		$SwordSprite.flip_v=true;
		$SwordSprite.position.x = -100;
		$SwordSprite.position.y = swordSpriteLocationY +10;

func _on_body_entered(body):
	#If hits enemy, deal damage
	if body.is_in_group("Enemy"):
		body.takeDamage(attackDmg)
	else:
		pass
	
