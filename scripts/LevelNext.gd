extends Area2D



const FILE_BEGIN =  "res://level_"

func _on_body_entered(body):
	#Checks if it is the player that entered
	if body.is_in_group("Player"):
		#Gets root node of scene in the file path
		var current_scene_file = get_tree().current_scene.scene_file_path
		#Finds an int in the scene then converts that number to an int
		#EX:res://levels/level_1.tscn would be = to 1 
		#also adds one to that number
		var next_level_number = current_scene_file.to_int()+1
		#Takes the file name (must be a template you can use for all of them
		#Then takes the "next_level_number" and brings you to the file
		#with that number. Must be consistent in your level naming.
		var next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn"
		get_tree().change_scene_to_file(next_level_path)
