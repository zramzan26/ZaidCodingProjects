extends Area2D
var packName = "healthVal"
var healVal = 6




func _on_body_entered(body):
	#If area2d is entered by player, trigger heal function
	if body.is_in_group("Player"):
		var heal = healVal
		if ( Global.player_health + heal >= Global.player_maxHealth):
			Global.player_health = Global.player_maxHealth
		elif (Global.player_health + heal <= Global.player_maxHealth):
			Global.player_health += heal
	self.queue_free()
