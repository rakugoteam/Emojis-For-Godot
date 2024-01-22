@tool
extends Node

var emojis:= {}

const path_here := "res://addons/emojis-for-godot/emojis/"
var json_path : String:
	get: return path_here + "emojis.json"

var font_path :  String:
	get: return path_here + "NotoColorEmoji.ttf"

var font : Font:
	get :
		if !_font:
			_font = load(font_path)
		return _font

var _font : Font

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

func init_emoji_dictionaries(dict:Dictionary):
	emojis = {}

	for emoji in dict:
		var keys = dict[emoji]
		for key in keys:
			emojis[key] = emoji
		
		# prints(dict[emoji], emoji)

func get_emoji_unicode(id:String) -> String:
	if id in emojis:
		# prints(id, emojis[id])
		return emojis[id]

	push_warning("Emoji %s not found." % id)
	return ""

func get_emoji_bbcode(id:String, size:=0) -> String:
	var emoji := get_emoji_unicode(id)
	if !emoji: return ""
	var bbcode := "[font=%s]%s[/font]" % [font_path, emoji]
	if size <= 0: return bbcode
	return "[font_size=%s]%s[/font_size]" % [size, bbcode]


func parse_emojis(text:String):
	var re = RegEx.new()
	re.compile(":[\\w\\d]+(,\\s*\\d+)?:")
	var result = re.search(text)
	while result != null:
		var temp := result.get_string()
		temp = temp.replace(":", "")
		var emoji := temp
		var size := 0

		if "," in temp:
			var splited := temp.split(",")
			emoji = splited[0]
			size = int(splited[1].replace(" ", ""))

		var replacement := get_emoji_bbcode(emoji, size)
		
		if !replacement:
			result = re.search(text, result.get_end())
			continue

		text = text.replace(result.get_string(), replacement)
		result = re.search(text, result.get_end())
	
	return text