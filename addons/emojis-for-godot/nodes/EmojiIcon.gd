@tool
@icon("res://addons/emojis-for-godot/icons/EmojiIcon.svg")
extends TextureRect
class_name EmojiIcon

var _emoji_name : String
var _emoji_size : String

@export var emoji_name := "sunglasses":
	set(value):
		_set_emoji_name(value)
	get:
		return _emoji_name

@export_enum("16", "36", "72")
var emoji_size := "16":
	set(value):
		_set_emoji_size(value)
	get:
		return _emoji_size

func _set_emoji_name(value:String):
	if !Engine.is_editor_hint():
		await ready
	_emoji_name = value
	var _texture = EmojisDB.get_path_to_emoji(value, int(_emoji_size))
	if _texture != "":
		texture = load(_texture) as Texture2D

func _set_emoji_size(value:String):
	if !Engine.is_editor_hint():
		await ready
	_emoji_size = value
	var _texture = EmojisDB.get_path_to_emoji(_emoji_name, int(value))
	if _texture != "":
		texture = load(_texture) as Texture2D

func set_emoji(name:String, size:String):
	if !Engine.is_editor_hint():
		await ready
	_emoji_name = name
	_emoji_size = size
	var _texture = EmojisDB.get_path_to_emoji(name, int(size))
	if _texture != "":
		texture = load(_texture) as Texture2D
