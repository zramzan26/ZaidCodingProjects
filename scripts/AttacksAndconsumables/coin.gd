extends Area2D
var packName = "coin"
var coinVal = 1




func _on_body_entered(body):
	#If area2d is entered by player, trigger heal function
	if body.is_in_group("Player"):
		if ( Global.player_coins + coinVal >= Global.player_maxCoins):
			Global.player_coins = Global.player_maxHealth
		elif (Global.player_coins + coinVal <=Global.player_maxCoins):
			Global.player_coins += coinVal
	print(Global.player_coins)
	self.queue_free()
