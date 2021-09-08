extends Timer

var end_time
signal timer_end
	
func start_t(i_end_time):
	end_time=i_end_time
	set_label_time()
	start()
	
func _on_End_Timer_timeout():
	if end_time>0:
		end_time-=1
		set_label_time()
	else:
		stop()
		emit_signal("timer_end")

func set_label_time():
	$"../Boutton Valid".texte=str(end_time)
	$"../Boutton Valid".refresh()
