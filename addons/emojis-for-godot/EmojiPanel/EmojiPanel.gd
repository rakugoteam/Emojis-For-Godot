@tool
extends Window

@export_multiline
var loading_text := "[center][pulse]Loading... [/pulse][/center]"

@export
@onready var emojis_text: RichTextLabel

@export_range(0.1, 1, 0.01)
var fill_scale_x: float = 0.8

@export
@onready var notify_label: Label

@export
@onready var search_line_edit: LineEdit

@export
@onready var size_slider: HSlider

@export
@onready var size_label: Label

@export
@onready var scroll_container: ScrollContainer

@export
@onready var help_button: Button

var scroll_bar_v: ScrollBar:
	get: return scroll_container.get_v_scroll_bar()

var scroll_bar_h: ScrollBar:
	get: return scroll_container.get_h_scroll_bar()

func _ready():
	notify_label.hide()
	search_line_edit.text_changed.connect(update_table)
	emojis_text.meta_clicked.connect(_on_meta)
	emojis_text.finished.connect(_on_finished)
	emojis_text.set_meta_underline(false)
	emojis_text.tooltip_text = "click on emoji to copy its name to clipboard"
	close_requested.connect(hide)
	size_slider.value_changed.connect(update_emojis_size)
	about_to_popup.connect(update_table)
	help_button.pressed.connect(_on_help)
	update_emojis_size(size_slider.value)

func _on_help():
	OS.shell_open("https://rakugoteam.github.io/emojis-docs/2.2/HowToUse/")

func _on_finished():
	scroll_bar_h.max_value = emojis_text.size.y
	scroll_bar_v.max_value = emojis_text.size.x

func _on_visibility_changed():
	if is_visible():
		update_emojis_size(size_slider.value)

func update_emojis_size(value: int):
	size_label.text = str(value)
	emojis_text.set("theme_override_font_sizes/normal_font_size", value)
	update_table(search_line_edit.text)

func update_table(filter:=""):
	var table = "[table={columns}, {inline_align}]"
	table = table.format({
		"columns": int(size.x / size_slider.value),
		"inline_align": INLINE_ALIGNMENT_CENTER
	})

	emojis_text.parse_bbcode(loading_text)

	for key in EmojisDB.emojis:
		if filter:
			if not (filter.to_lower() in key):
				continue
		
		var link := "[url={link}]{text}[/url]"
		var text := str(EmojisDB.emojis[key])
		link = link.format({"link": key, "text": text})

		var cell := "[cell]{link}[/cell]"
		table += cell.format({"link": link})

	table += "[/table]"
	emojis_text.parse_bbcode(table)

func _on_meta(link: String):
	DisplayServer.clipboard_set(link)
	notify_label.text = "Copied to Clipboard: " + link
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
