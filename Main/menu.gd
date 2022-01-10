extends TextureRect

export(PackedScene) var game
onready var Name1=$"MarginContainer/VBoxContainer/Control/nameplayer/PlayerNameEnter/MarginContainer/Player1Name"
onready var Name2=$"MarginContainer/VBoxContainer/Control/nameplayer/PlayerNameEnter2/MarginContainer/Player1Name"
onready var Name3=$"MarginContainer/VBoxContainer/Control/nameplayer/PlayerNameEnter3/MarginContainer/Player1Name"
onready var Name4=$"MarginContainer/VBoxContainer/Control/nameplayer/PlayerNameEnter4/MarginContainer/Player1Name"
onready var valeurnode=$"MarginContainer/VBoxContainer/Control/reglage/question par personne/valeur"
onready var commentairenode=$"MarginContainer/VBoxContainer/Control/reglage/question par personne/temps"
var state=0

func _on_TextureButton_pressed():
	var newgame=game.instance()
	set_new_name(Name1,"playerName1",newgame)
	set_new_name(Name2,"playerName2",newgame)
	set_new_name(Name3,"playerName3",newgame)
	set_new_name(Name4,"playerName4",newgame)
	newgame.task=int(valeurnode.text)
	get_tree().get_root().add_child(newgame)
	queue_free()
	
func set_new_name(NameNode,variableName,newGame):
	if NameNode.text!="":
		newGame.set(variableName,NameNode.text)
	else:
		newGame.set(variableName,NameNode.placeholder_text)

func refresh(val):
	state+=val
	if state<0:
		state=0
	elif state>3:
		state=3
	match state:
		0:
			refresh_param(20,"rapide")
		1:
			refresh_param(30,"moyen")
		2:
			refresh_param(40,"long")
		3:
			refresh_param(50,"tres long")
			
func refresh_param(val,txt):
	valeurnode.text=str(val)
	commentairenode.text=txt

func _on_m_pressed():
	refresh(-1)


func _on_p_pressed():
	refresh(1)

func _ready():
	refresh(0)
