extends TextureButton

export (Texture) var T_Dice1
export (Texture) var T_Dice2
export (Texture) var T_Dice3
export (Texture) var T_Dice4
export (Texture) var T_Dice5
export (Texture) var T_Dice6

var time_left=0
export (int) var time_left_before_launch=3
export (int) var nbr_dice_animation_pass_max=10
var nbr_dice_animation_pass=0
var num_dice
onready var timer=$"Timer"

signal dice_finish

func _ready():
	$"Label".text=str(time_left_before_launch)+" secondes"
	texture_normal=T_Dice1
	randomize()

func _on_Dice_pressed():
	time_left=0
	$"Label".text=str(time_left_before_launch)+" secondes"
	disabled=true
	$"Label".visible=false
	$"Label/Timer2".stop()
	timer.start()
	
func _on_Timer_timeout():
	if nbr_dice_animation_pass==nbr_dice_animation_pass_max:
		nbr_dice_animation_pass=0
		rand_dice()
		emit_signal("dice_finish",num_dice)
	else:
		nbr_dice_animation_pass+=1
		rand_dice()
		timer.start()

func rand_dice():
	num_dice=randi()%$"../../..".max_case+$"../../..".min_case
	match num_dice:
		1:
			texture_normal=T_Dice1
		2:
			texture_normal=T_Dice2
		3:
			texture_normal=T_Dice3
		4:
			texture_normal=T_Dice4
		5:
			texture_normal=T_Dice5
		6:
			texture_normal=T_Dice6

func _on_Timer2_timeout():
	if time_left_before_launch==time_left:
		_on_Dice_pressed()
	else:
		time_left+=1
		$"Label".text=str(time_left_before_launch-time_left)+" secondes"
		$"Label/Timer2".start()
