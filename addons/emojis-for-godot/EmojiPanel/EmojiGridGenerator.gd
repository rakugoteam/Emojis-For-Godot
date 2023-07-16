@tool
extends EditorScript

var grid := GridContainer.new()

func _run():
	var i := 1.0
	var p: = 0.0
	var size := float(EmojisDB.emojis.size())
	grid.name = "EmojisGrid"

	for id in EmojisDB.emojis.keys():
		var b := EmojiButton.new()
		b.name = id
		b.set_emoji(id, "36")
		grid.add_child(b)
		b.owner = grid

		if p < int(i/size*100):
			p = int(i/size*100)
			print("loaded icons: ", p, "%")

		i += 1
	
	var scene = PackedScene.new()
	var result = scene.pack(grid)

	if result == OK:
		var path := "res://addons/emojis-for-godot/EmojiPanel/EmojiGrid.tscn"
		var error = ResourceSaver.save(scene, path)
		
		if error != OK:
			push_error("An error occurred while saving the scene to disk.")
			return

		print("EmojisGrid saved")


