@tool
@icon("res://addons/emojis-for-godot/icons/EmojiIcon.svg")
extends Label

## EmojiIcon is a simple node that displays an emoji in UI.
## @tutorial: https://rakugoteam.github.io/emojis-docs/2.2/EmojiLabel/
## @tutorial(How to use): https://rakugoteam.github.io/emojis-docs/2.2/HowToUse/
class_name EmojiIcon

## The name (alias) of the emoji to display.
@export var emoji_name := "sunglasses":
	set(value):
		emoji_name = value
		update_emoji()

	get: return emoji_name

## The size of the emoji to display.
@export_range(16, 512, 16) var emoji_size := 16:
	set(value):
		emoji_size = value
		update_emoji()

	get: return emoji_size

## function used is change the emoji or it size.
## It is called when the emoji_name or emoji_size is changed.
func update_emoji():
	set("theme_override_fonts/font", EmojisDB.font)
	set("theme_override_font_sizes/normal_font_size",emoji_size)
	if emoji_name:
		text = EmojisDB.get_emoji_unicode(emoji_name)

func _ready() -> void:
	update_emoji()