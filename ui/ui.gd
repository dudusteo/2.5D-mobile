extends Control

@onready var _textbox: Control = $Textbox
@onready var _pauseMenu: Control = $PauseMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	_pauseMenu.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _input(event):
	if event is InputEvent:
		if event.is_action_pressed("ui_cancel"):
			_pauseMenu.show()
