extends CharacterBody3D

@export var speed = 4
@export var accel = 10
@export var isDead = false

var target = Vector3(0, 0, 0)

@onready var nav_agent := $NavigationAgent3D as NavigationAgent3D

# Called when the node enters the scene tree for the first time.
func _ready():
	BusEvent.cameraPosition.connect(_refresh_target)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var dir = nav_agent.get_next_path_position() - global_position
	dir = dir.normalized()
	velocity = velocity.lerp(dir*speed, accel*delta)
	move_and_slide()

func _refresh_target(targetPos: Vector3):
	if(not isDead):
		#print("pasmort")
		target = targetPos
	else:
		#print("mort")
		target = Vector3(0, 1, -19)

func makepath():
	nav_agent.target_position = target

func _on_path_refresh_timeout(): 
	makepath()

func _on_bullet_area_area_entered(area):
	isDead = true
