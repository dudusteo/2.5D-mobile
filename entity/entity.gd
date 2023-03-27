extends CharacterBody3D

@onready var _animated_sprite = $AnimatedSprite3D

const SPEED = 4.0
const JUMP_VELOCITY = 4.5

func _ready():
	pass

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_select") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var local_speed =  input_dir.length_squared() / (Vector2(direction.x, direction.z).length_squared() + 1) * 2
	if direction:
		if(direction.x < 0.0):
			_animated_sprite.flip_h = true
		else:
			_animated_sprite.flip_h = false
		if(local_speed > 0.75):
			_animated_sprite.play("run", 1.0)
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			_animated_sprite.play("run", 0.5)
			velocity.x = direction.x * SPEED * 0.5
			velocity.z = direction.z * SPEED * 0.5
	else:
		_animated_sprite.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
