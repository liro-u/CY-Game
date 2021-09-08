extends TextureRect

var P1
var P2
var P3
var P4

export(PackedScene) var result

onready var Pl1=$"resultbutton/VBoxContainer/HBoxContainer/VBoxContainer2/Player1"
onready var Pl2=$"resultbutton/VBoxContainer/HBoxContainer/VBoxContainer2/Player2"
onready var Pl3=$"resultbutton/VBoxContainer/HBoxContainer/VBoxContainer/Player3"
onready var Pl4=$"resultbutton/VBoxContainer/HBoxContainer/VBoxContainer/Player4"

func _ready():
	Pl1.refresh(P1.namePlayer)
	Pl2.refresh(P2.namePlayer)
	Pl3.refresh(P3.namePlayer)
	Pl4.refresh(P4.namePlayer)
	
func _on_Player1_pressed():
	show_stat(P1)


func _on_Player2_pressed():
	show_stat(P2)


func _on_Player3_pressed():
	show_stat(P3)


func _on_Player4_pressed():
	show_stat(P4)

func show_stat(Player):
	var instance=result.instance()
	instance.Player=Player
	add_child(instance)
