extends HBoxContainer

export var angular_speed=360
var timer
var time_node
export(int,0,59) var seconde=0
export(int,0,9) var minute=1
var total_seconde
signal timer_end

func _ready():
	timer=$Timer
	time_node=$Time
	set_label_time()
	set_physics_process(false)

func start():
	total_seconde=minute*60+seconde
	set_physics_process(true)
	timer.start()
	
func _physics_process(delta):
	$"clock Texture/pointeuse".rect_rotation+=angular_speed*delta

func _on_Timer_timeout():
	if seconde>0:
		seconde-=1
		set_label_time()
	elif minute>0:
		seconde=59
		minute-=1
		set_label_time()
	else:
		emit_signal("timer_end")
		
func stop():
	timer.stop()
	set_physics_process(false)
	
func set_label_time():
	var vseconde=str(seconde)
	if seconde<10:
		vseconde="0"+vseconde
	time_node.text=str(minute)+":"+vseconde

