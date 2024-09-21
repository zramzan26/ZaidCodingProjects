extends Node2D

var player_flipped = false
var player_health = 10
var player_maxHealth = 10
var player_energy = 20
var player_maxEnergy = 20
var player_coins = 0
var player_maxCoins = 999
var scene = load("res://nonLevelScenes/Functions/youdied.tscn")
var scene_instance = scene.instantiate()

var current_checkpoint : Checkpoint
var player : Player

func _death():
	#Player death, wait a bit w/ timer then change scene
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://nonLevelScenes/Functions/youdied.tscn")
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://nonLevelScenes/Functions/title_screen.tscn")
	
func respawn_player():

	if current_checkpoint != null:
		player.position = current_checkpoint.global_position
		Global.player_health = player_maxHealth
