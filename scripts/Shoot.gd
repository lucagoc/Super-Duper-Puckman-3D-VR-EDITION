extends AudioStreamPlayer3D

@export var shoot_button : String = "trigger"
@export var ammoleft = 5

var hasbeenreset = false

# Called when the node enters the scene tree for the first time.
var bullet = preload("res://scenes/bullet.tscn")
func _ready():
	get_parent().get_node("AnimationPlayer").current_animation = "idle2"
	get_parent().gravity_scale = 0

var hasPlayed = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (get_parent().is_picked_up()):
		var _controller = get_parent().get_picked_up_by_controller()
		if !hasbeenreset:
			get_parent().get_node("AnimationPlayer").current_animation = "RESET"
			get_parent().gravity_scale = 1
			hasbeenreset = true
		if _controller.is_button_pressed(shoot_button) and !hasPlayed and ammoleft > 0:
			play()
			ammoleft -= 1
			var bullet_instance = bullet.instantiate()
			get_parent().add_sibling(bullet_instance)
			
			## Set the bullet's position to the gun's position
			bullet_instance.global_transform.origin = global_transform.origin
			bullet_instance.global_transform.basis = global_transform.basis
			
			hasPlayed = true

func _on_finished():
	hasPlayed = false


func _on_area_3d_area_entered(area):
	get_parent().queue_free()
