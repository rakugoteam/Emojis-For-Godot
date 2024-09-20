@tool
extends EditorPlugin

const emoji_db := "res://addons/emojis-for-godot/emojis/emojis.gd"
const emoji_finder_scene := \
	"res://addons/emojis-for-godot/EmojiPanel/EmojiPanel.tscn"
const emoji_finder_window_scene := \
	"res://addons/emojis-for-godot/EmojiPanel/EmojiFinderWindow.tscn"
var command_palette := get_editor_interface().get_command_palette()
var editor_interface := get_editor_interface().get_base_control()
var emoji_finder_window: Window
var emoji_finder: Panel
var popup_size := Vector2(450, 400)

func _enter_tree():
	add_autoload_singleton("EmojisDB", emoji_db)
	await EmojisDB.ready

	if EmojisDB.is_docked: add_to_dock()

	add_tool_menu_item("Emoji Finder Window", show_emoji_finder)
	add_tool_menu_item("Emoji Finder Dock", add_to_dock)
	add_tool_menu_item("Emoji Help", help)

	command_palette.add_command(
		"Emoji Finder Window", "emoji_finder_window", show_emoji_finder)
	command_palette.add_command(
		"Emoji Finder Dock", "emoji_finder_dock", add_to_dock)
	command_palette.add_command("Emoji Help", "emoji_help", help)

func help():
	OS.shell_open("https://rakugoteam.github.io/emojis-docs/")

func add_to_dock():
	emoji_finder = load(emoji_finder_scene).instantiate()
	add_control_to_bottom_panel(emoji_finder, "Emojis")
	emoji_finder.update_table()

func show_emoji_finder():
	remove_control_from_bottom_panel(emoji_finder)
	emoji_finder.queue_free()
	EmojisDB.is_docked = false

	if emoji_finder_window == null:
		emoji_finder_window = load(emoji_finder_window_scene).instantiate()
		editor_interface.add_child.call_deferred(emoji_finder_window)

	emoji_finder_window.theme = editor_interface.theme
	emoji_finder_window.popup_centered(popup_size)

func _exit_tree():
	remove_tool_menu_item("Emoji Finder")
	remove_tool_menu_item("Emoji Finder Dock")
	remove_tool_menu_item("Emoji Help")

	command_palette.remove_command("find_emoji")
	command_palette.remove_command("emoji_finder_dock")
	command_palette.remove_command("emoji_help")
	
	remove_autoload_singleton("EmojisDB")
	
	if emoji_finder:
		emoji_finder.queue_free()

	if emoji_finder_window:
		emoji_finder_window.queue_free()
