tool
extends EditorPlugin

var emoji_finder : WindowDialog
var menu_item := ["Emoji Finder", "popup_centered", Vector2(450, 400)]

func _enter_tree():
  var emojis = preload("emojis/emojis.gd").new()
  emoji_finder = preload("emojis_panel/EmojiPanel.tscn").instance()
  add_control_to_container(CONTAINER_TOOLBAR, emoji_finder)
  add_tool_menu_item(menu_item[0], emoji_finder, menu_item[1], menu_item[2])
  
func _exit_tree():
  remove_custom_type("EmojiButton")
  remove_custom_type("EmojiIcon")
  remove_control_from_container(CONTAINER_TOOLBAR, emoji_finder)