@tool
extends Window

@export var grid : GridContainer
@export var notify_label : Label
@export var grid_bound := 0.9
@export var button_x := 36

signal emoji_selected(emoji_name)

func _ready():
	close_requested.connect(hide)
	size_changed.connect(_on_resized)
	for ch in grid.get_children():
		var b := ch as Button
		b.pressed.connect(on_emoji_clicked.bind(b))

func on_emoji_clicked(button: Button):
	emoji_selected.emit(button.name)
	DisplayServer.clipboard_set(button.name)
	notify_label.text = "Copied " + button.name + " to clipboard"
	notify_label.show()
	var t := get_tree().create_tween()
	t.tween_property(
		notify_label, "modulate",
		Color.GREEN, 1
	)
	t.chain().tween_property(
		notify_label, "modulate",
		Color.TRANSPARENT, 1
		)
	await t.finished
	notify_label.hide()

func _on_resized():
	grid.columns = int((size.x / button_x)*grid_bound)


