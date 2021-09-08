extends HBoxContainer

export var text_num_c="1st"
export (Color) var t_color=Color(255,255,255)

var Player
var trophey=0
onready var l_classement=$"classement"
onready var l_name=$"Name"
onready var l_trophey=$"Trophey"
onready var l_tour=$"tour"

func _ready():
	l_classement.text=text_num_c
	l_classement.set("custom_colors/font_color",t_color)
	
func set_color(color):
	l_name.set("custom_colors/font_color",color)
	l_trophey.set("custom_colors/font_color",color)
	l_tour.set("custom_colors/font_color",color)
	
func refreshP(player=Player):
	Player=player
	
func refresh():
	trophey=Player.trophey
	$"Name".text=Player.namePlayer
	$"Trophey".text=str(trophey)+" trophey"
	$"tour".text=str(Player.task)+" mission minimum"
	
