extends Area2D
var packName = "energyVal"
var enerVal = 2


func _on_body_entered(body):
	#If area2d is entered by player, trigger energy function
	if body.is_in_group("Player"):
		var ener = enerVal
		if (Global.player_energy + ener >= Global.player_maxEnergy):
			Global.player_energy = Global.player_maxEnergy
		elif (Global.player_energy + ener <= Global.player_maxEnergy):
			Global.player_energy += ener
		print(Global.player_energy)
		self.queue_free()
		
