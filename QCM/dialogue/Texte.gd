extends RichTextLabel

export(float,0,1) var speed=0.7

signal show_end

func _ready():
	percent_visible=0
	set_physics_process(false)
	
func start_show():
	set_physics_process(true)
	
func _physics_process(delta):
	percent_visible+=speed*delta
	if percent_visible>=1:
		percent_visible=1
		set_physics_process(false)
		emit_signal("show_end")
