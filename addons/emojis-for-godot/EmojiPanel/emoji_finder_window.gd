@tool
extends Window

func _ready() -> void:
	close_requested.connect(hide)