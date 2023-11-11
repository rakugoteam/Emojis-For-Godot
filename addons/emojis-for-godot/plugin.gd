@tool
extends EditorPlugin

const emoji_db := "res://addons/emojis-for-godot/emojis/emojis.gd"
const emoji_finder_path :=\
"res://addons/emojis-for-godot/EmojiPanel/EmojiPanel.tscn"
var command_palette := get_editor_interface().get_command_palette()
var editor_interface := get_editor_interface().get_base_control()
var emoji_finder : Window
var popup_size := Vector2(450, 400)

func _enter_tree():
	add_autoload_singleton("EmojisDB", emoji_db)
	add_tool_menu_item("Emoji Finder", show_emoji_finder)
	command_palette.add_command(
		"Emoji Finder", "find_emoji", show_emoji_finder)

func show_emoji_finder():
	if emoji_finder == null:
		emoji_finder = load(emoji_finder_path).instantiate() as Window
		editor_interface.add_child.call_deferred(emoji_finder)

	emoji_finder.theme = editor_interface.theme
	emoji_finder.popup_centered(popup_size)

func _exit_tree():
	remove_tool_menu_item("Emoji Finder")
	command_palette.remove_command("find_emoji")
	remove_autoload_singleton("EmojisDB")
	
	if emoji_finder:
		emoji_finder.queue_free()