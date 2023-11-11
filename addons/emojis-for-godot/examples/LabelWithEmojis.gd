@tool
extends RichTextLabel

@export_multiline
var text_with_emojis: String:
	set(value):
		text_with_emojis = value
		bbcode_enabled = true
		text = EmojisDB.parse_emojis(value)
	
	get: return text_with_emojis

func _ready() -> void:
	if !Engine.is_editor_hint():
		bbcode_enabled = true
		text = EmojisDB.parse_emojis(text_with_emojis)