@tool
extends RichTextLabel

@export_multiline
var text_with_emojis: String:
	set(value):
		if !Engine.is_editor_hint():
			await ready
		_text_with_emojis = value
		bbcode_enabled = true
		text = EmojisDB.parse_emojis(value)
	
	get:
		return _text_with_emojis

var _text_with_emojis : String

