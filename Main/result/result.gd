extends TextureRect

var Player
onready var title=$"MarginContainer/VBoxContainer/titre"
onready var para=$"MarginContainer/VBoxContainer/para"

export(String, MULTILINE) var paraMathApp
export(String, MULTILINE) var paraInfo
export(String, MULTILINE) var paraMathEco
export(String, MULTILINE) var paraBioTeck
export(String, MULTILINE) var paraGenieC
export(String, MULTILINE) var paraMeca

func _on_TextureButton_pressed():
	queue_free()

func _ready():
	match Player.final_filiere:
		0:
			title.text="Mathématique Appliquées"
			para.text=paraMathApp
		1:
			title.text="Informatique"
			para.text=paraInfo
		2:
			title.text="Mathématique, Economie et Finance"
			para.text=paraMathEco
		3:
			para.text=paraBioTeck
			title.text="Biotechnologie et Chimie"
		4:
			para.text=paraGenieC
			title.text="Génie Civil"
		5:
			para.text=paraMeca
			title.text="Mécanique"
