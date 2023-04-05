extends Control

@export var character_speed: int = 5

@onready var label: RichTextLabel = $MarginContainer/Panel/MarginContainer/RichTextLabel

enum State { READY, READING, FINISHED }
var current_state = State.READY
var tween: Tween


func reset_textbox():
	label.visible_characters = 0
	label.text = ""
	change_state(State.READY)
	
func hide_textbox():
	hide()

func show_textbox():
	show()

func add_text(next_text):
	label.text = next_text
	change_state(State.READING)
	show_textbox()
	label.visible_characters = 0
	tween = get_tree().create_tween()
	tween.tween_property(label, "visible_characters", label.text.length(), float(label.text.length()) / character_speed)
	tween.finished.connect(self._on_tween_finished)

func change_state(next_state):
	current_state = next_state

func skip_text():
	if tween:
		tween.kill()
	label.visible_characters = label.text.length()
	change_state(State.FINISHED)
	
func _input(event):
	if event is InputEvent:
		if event.is_action_pressed("ui_select"):
			match current_state:
				State.READY:
					pass
				State.READING:
					skip_text()
				State.FINISHED:
					hide_textbox()
					reset_textbox()

func _on_panel_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			match current_state:
				State.READY:
					pass
				State.READING:
					skip_text()
				State.FINISHED:
					hide_textbox()
					reset_textbox()

func _on_tween_finished():
	change_state(State.FINISHED)

func _on_interactable_changed(_newInteractable):
	skip_text()
	hide_textbox()
	reset_textbox()

func _on_interaction_interacted(source):
	if current_state == State.READY:
		add_text("[color=aqua]" + source.name + "[/color] Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ")
