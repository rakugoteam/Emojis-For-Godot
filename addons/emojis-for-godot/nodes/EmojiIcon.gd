@tool
@icon("res://addons/emojis-for-godot/icons/EmojiIcon.svg")
extends TextureRect
class_name EmojiIcon

var _emoji_id: String
var _emoji_size : String

@export var emoji_name := "sunglasses":
	set(value):
		set_emoji(value, _emoji_size)
	get:
		return _emoji_id

@export_enum("16", "36", "72")
var emoji_size := "16":
	set(value):
		set_emoji(_emoji_id, value)
	get:
		return _emoji_size

func set_emoji(id:String, size:String):
	if !Engine.is_editor_hint():
		await ready
	
	_emoji_id= id
	_emoji_size = size
	var _texture = EmojisDB.get_path_to_emoji(id, int(size))
	if !ResourceLoader.exists(_texture):
		return
		
	if _texture != "":
		texture = load(_texture) as Texture2D
