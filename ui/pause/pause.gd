extends Control

@export var pressed_color: Color = Color.GRAY
@export var action_clicked = "ui_cancel"

@onready var _button: TextureRect = $Button
@onready var _default_color: Color = _button.modulate

var ev = InputEventAction.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	ev.action = action_clicked
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_texture_rect_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			_button.modulate = pressed_color
			ev.pressed = true
			Input.parse_input_event(ev)
		else:
			_button.modulate = _default_color
			ev.pressed = false
			Input.parse_input_event(ev)
