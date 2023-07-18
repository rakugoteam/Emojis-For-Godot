@tool
extends Node

const path_here := "res://addons/emojis-for-godot/emojis/"
var json_path := path_here + "emojis.json"
var emojis_path := path_here + "%dx%d/%s.tres"
var emojis:= {}

func _ready():
	var content = get_file_content(json_path)
	var json := JSON.new()

	if json.parse(content) == OK:
		init_emoji_dictionaries(json.data)

func get_file_content(path:String) -> String:
	var file := FileAccess.open(path, FileAccess.READ)
	var content := ""

	if file.get_error() == OK:
		content = file.get_as_text()
		file.close()
		
	return content

func init_emoji_dictionaries(list:Array):
	emojis = {}

	for group in list:
		for emoji in group.emojis:
			var _name = emoji.shortname
			_name = _name.replace(":", "")
			_name = _name.replace("regional_indicator_", "")
			emojis[_name] = emoji.hex

func get_path_to_emoji(id:String, size:int = 16) -> String:
	if id in emojis:
		return emojis_path % [size, size, emojis[id]]

	push_warning("Emoji %s with size %s not found." % [id, size])
	return ""

func get_emoji_bbcode(id:String, size:int = 16) -> String:
	var path = get_path_to_emoji(id, size)
	
	if path:
		return "[img]%s[/img]" % path

	return ""

func parse_emojis(text:String):
	var re = RegEx.new()
	re.compile("\\:([\\w.-]+)\\:")
	var x = re.search(text)
	while x != null:
		var emoji = x.get_string(1)
		var r = get_emoji_bbcode(emoji)
		text = text.replace(x.get_string(), r)
		x = re.search(text, x.get_end())
	
	return text