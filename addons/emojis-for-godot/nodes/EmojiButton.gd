@tool
@icon("res://addons/emojis-for-godot/icons/EmojiButton.svg")
extends Button
class_name EmojiButton

@export var emoji_name := "sunglasses":
	set(value):
		emoji_name = value
		update_emoji()

	get: return emoji_name

@export_range(16, 512, 16) var emoji_size := 16:
	set(value):
		emoji_size = value
		update_emoji()

	get: return emoji_size

func update_emoji():
	set("theme_override_fonts/font", EmojisDB.font)
	set("theme_override_font_sizes/normal_font_size", emoji_size)
	if emoji_name:
		text = EmojisDB.get_emoji_unicode(emoji_name)

func _ready() -> void:
	update_emoji()