extends Control

@export var character_speed: int = 5

@onready var label: RichTextLabel = $MarginContainer/Panel/MarginContainer/RichTextLabel

enum State {
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	match current_state:
		State.READY:
			pass
		State.READING:
			if Input.is_action_just_pressed("ui_select"):
				tween.kill()
				label.visible_ratio = 1
				change_state(State.FINISHED)
		State.FINISHED:
			if Input.is_action_just_pressed("ui_select"):
				change_state(State.READY)
				hide_textbox()
	pass

func hide_textbox():
	label.text = ""
	hide()

func show_textbox():
	show()

func add_text(next_text):
	label.text = next_text
	change_state(State.READING)
	show_textbox()
	label.visible_characters = 0
	tween = create_tween()
	tween.tween_property(label, "visible_characters", label.text.length(), float(label.text.length()) / character_speed)
	tween.finished.connect(self._on_tween_finished)
		
		
func _on_tween_finished():
	change_state(State.FINISHED)
	print("tween finished")
		
func _on_interaction_interacted(source):
	add_text(source.name + " Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ")
	
func _on_interactable_changed(_newInteractable):
	hide_textbox()

func change_state(next_state):
	current_state = next_state
	print(current_state)
