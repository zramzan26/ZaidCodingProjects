extends Node2D
class_name Checkpoint 
@export var spawnPoint = false
var activated = false

func activate():
	#Change the checkpoint to self, and play the activated animation
	#Also make activated true so it doesnt keep triggering.
	Global.current_checkpoint = self
	activated = true
	$AnimationPlayer.play("activate")






func _on_area_2d_body_entered(body):
	#When player enters, call function
	if body.is_in_group("Player") && activated == false:
		activate()
