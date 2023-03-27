extends Control

@export var character_speed: int = 5

@onready var label: RichTextLabel = $MarginContainer/Panel/MarginContainer/RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func hide_textbox():
	label.text = ""
	hide()

func show_textbox():
	show()
	

func add_text(next_text):
	label.text = next_text
	show_textbox()
	label.visible_characters = 0
	var tween = create_tween()
	tween.tween_property(label, "visible_characters", label.text.length(), float(label.text.length()) / character_speed)
