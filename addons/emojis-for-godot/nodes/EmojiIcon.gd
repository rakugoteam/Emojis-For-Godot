@tool
extends TextureRect
class_name EmojiIcon, "res://addons/emojis-for-godot/icons/EmojiIcon.svg"

@export var emoji_name := "sunglasses": set = _set_emoji
@export var emoji_size := "36": set = _set_emoji_size

var emojis = Emojis.new()

func _init():
	_set_emoji(emoji_name)
	_set_emoji_size(emoji_size)

func _set_emoji(value: String) -> void:
	emoji_name = value
	var emoji = emojis.get_path_to_emoji(value, int(emoji_size))
	if emoji != "":
		texture = load(emoji) as Texture2D

func _set_emoji_size(value: String) -> void:
	emoji_size = value
	_set_emoji(emoji_name)
