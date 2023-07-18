@tool
extends Window

@export var grid : GridContainer
@export var notify_label : Label
@export var search : LineEdit
@export var grid_bound := 0.8
@export var button_x := 42

signal emoji_selected(emoji_name)

func _ready():
	close_requested.connect(hide)
	size_changed.connect(_on_resized)
	
	var bx := grid.get_child(0) as Button 
	button_x = bx.size.x # * grid_bound
	
	for ch in grid.get_children():
		var b := ch as Button
		b.tooltip_text = "click on emoji to copy its name to clipboard"
		b.pressed.connect(on_emoji_clicked.bind(b))

	about_to_popup.connect(_on_resized)
	search.text_changed.connect(on_text_changed)
	columns_update()

func on_text_changed(filter: String):
	for ch in grid.get_children():
		var b := ch as Button
		if filter:
			b.visible = filter in b.name

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
	if visible:
		columns_update()

func columns_update():
	grid.columns = floor((size.x * grid_bound) / button_x)

