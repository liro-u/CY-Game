extends TextureRect

#variable de test ou d'appel par fonction
export(NodePath) var Player=null
export(int,"bonus","malus") var mode_point=0

#variable global de design et de jouabilité
export(int,0,59) var seconde=0
export(int,0,9) var minute=1

export(int,0,59) var end_time_second=3

export(String) var Bouton_valid_texte="Valider la réponse"

export(String) var positive_warning_trophey=" [color=#ffd700][b]trophés[/b][/color] à [color=green]gagner[/color] en répondant juste"
export(String) var negative_warning_trophey=" [color=#ffd700][b]trophés[/b][/color] en [color=red]moins[/color] en répondant faux"

#variable de parametrage de la Scene
export(String, MULTILINE) var Question="[b]Question pour[/b] %s :\n[color=red]Poser votre question ici svp[/color]"

export(String, MULTILINE) var textReponseA="[b]Reponse A :[/b]\n proposition 1..."
export(String, MULTILINE) var textReponseB="[b]Reponse B :[/b]\n proposition 2..."
export(String, MULTILINE) var textReponseC="[b]Reponse C :[/b]\n proposition 3..."
export(String, MULTILINE) var textReponseD="[b]Reponse D :[/b]\n proposition 4..."

export(int,2,4) var nombre_reponse=4
export(bool) var choix_unique=true

export (bool) var ReponseA=true
export (bool) var ReponseB=false
export (bool) var ReponseC=false
export (bool) var ReponseD=false

export(int) var trophey_reward=5

export(int,2,3) var point=2

export(bool) var physique=false
export(bool) var math=false
export(bool) var anglais=false
export(bool) var team=false
export(bool) var orga=false
export(bool) var adaptation=false
export(bool) var informatique=false
export(bool) var chimie=false
export(bool) var francais=false
export(bool) var bio=false

#variable non exporté
var dialogue
var Time_box
var text_reward
var Timer_valid

var Bouton_valid

var BoutonA
var BoutonB
var BoutonC
var BoutonD



var PlayerA=false
var PlayerB=false
var PlayerC=false
var PlayerD=false

var verif=true

var valid_reward=true


func _ready():
	Timer_valid=$"Margin all/QCM/Onglet recompense/Margin cadre/recompense et valid/Center Valid/MarginContainer/End_Timer"
	Bouton_valid=$"Margin all/QCM/Onglet recompense/Margin cadre/recompense et valid/Center Valid/MarginContainer/Boutton Valid"
	
	text_reward=$"Margin all/QCM/Onglet recompense/Margin cadre/recompense et valid/Margin reward/CenterMyText/Reward Text"
	dialogue=$"Margin all/QCM/Question Box/dialogue box/Margin Dialogue/Texte"
	Time_box=$"Margin all/QCM/Question Box/Box arbitre time/Margin Time/Time Box"
	
	BoutonA=$"Margin all/QCM/Center Boutons/boutons/boutons haut/Reponse A"
	BoutonB=$"Margin all/QCM/Center Boutons/boutons/boutons haut/Reponse B"
	BoutonC=$"Margin all/QCM/Center Boutons/boutons/boutons bas/Reponse C"
	BoutonD=$"Margin all/QCM/Center Boutons/boutons/boutons bas/Reponse D"
	
	BoutonA.texte=textReponseA
	BoutonB.texte=textReponseB
	BoutonC.texte=textReponseC
	BoutonD.texte=textReponseD
	
	BoutonA.refresh()
	BoutonB.refresh()
	BoutonC.refresh()
	BoutonD.refresh()
	
	Bouton_valid.texte=Bouton_valid_texte
	Bouton_valid.refresh()
	
	Time_box.seconde=seconde
	Time_box.minute=minute
	Time_box.set_label_time()
	
	match nombre_reponse:
		2:
			BoutonC.disabled=true
			BoutonC.refresh()
			BoutonD.disabled=true
			BoutonD.refresh()
		3:
			BoutonD.disabled=true
			BoutonD.refresh()
	var get_Name
	if Player==null:
		get_Name="[color=red][b]Saisir un nom[/b][/color]"
	else:
		get_Name="[b][color=aqua]%s[/color][/b]"
		get_Name=get_Name % Player.namePlayer
	dialogue.bbcode_text=Question % get_Name
	var text_reward_warning
	if mode_point==1:
		text_reward_warning=negative_warning_trophey
	else:
		text_reward_warning=positive_warning_trophey
	text_reward.bbcode_text=str(trophey_reward)+text_reward_warning
	start()
	
func start():
	dialogue.start_show()
	
func set_Player_Reponse(variable,booleen):
	if verif:
		if choix_unique:
			match variable:
				0:
					PlayerA=booleen
					if PlayerB or PlayerC or PlayerD:
						PlayerB=not booleen
						PlayerC=not booleen
						PlayerD=not booleen
						verif=false
				1:
					PlayerB=booleen
					if PlayerA or PlayerC or PlayerD:
						PlayerA=not booleen
						PlayerC=not booleen
						PlayerD=not booleen
						verif=false
				2:
					PlayerC=booleen
					if PlayerA or PlayerB or PlayerD:
						PlayerA=not booleen
						PlayerB=not booleen
						PlayerD=not booleen
						verif=false
				3:
					PlayerD=booleen
					if PlayerA or PlayerB or PlayerC:
						PlayerA=not booleen
						PlayerB=not booleen
						PlayerC=not booleen
						verif=false
					
			BoutonA.pressed=PlayerA
			BoutonB.pressed=PlayerB
			BoutonC.pressed=PlayerC
			BoutonD.pressed=PlayerD
		else:
			match variable:
				0:
					PlayerA=booleen
				1:
					PlayerB=booleen
				2:
					PlayerC=booleen
				3:
					PlayerD=booleen
	else:
		verif=true

func _on_Reponse_A_toggled(button_pressed):
	set_Player_Reponse(0,button_pressed)

func _on_Reponse_B_toggled(button_pressed):
	set_Player_Reponse(1,button_pressed)

func _on_Reponse_C_toggled(button_pressed):
	set_Player_Reponse(2,button_pressed)

func _on_Reponse_D_toggled(button_pressed):
	set_Player_Reponse(3,button_pressed)


func _on_Texte_show_end():
	get_tree().call_group("boutton_reponse","start_show")

func _on_Reponse_A_show_end():
	Time_box.start()

func show_reponse():
	Time_box.stop()
	get_tree().call_group("boutton_reponse","desactivate")
	if not ReponseA==PlayerA:
		valid_reward=false
		BoutonA.set_on_false()
	if ReponseA:
		BoutonA.set_on_true()
		
	if not ReponseB==PlayerB:
		valid_reward=false
		BoutonB.set_on_false()
	if ReponseB:
			BoutonB.set_on_true()
		
	if not ReponseC==PlayerC:
		valid_reward=false
		BoutonC.set_on_false()
	if ReponseC:
		BoutonC.set_on_true()
		
	if not ReponseD==PlayerD:
		valid_reward=false
		BoutonD.set_on_false()
	if ReponseD:
		BoutonD.set_on_true()
	
	var valid_sign=$"Margin all/QCM/Onglet recompense/Margin cadre/recompense et valid/Trophey/Valid"
	
	if physique:
		Player.physiquetot+=point
	if math:
		Player.mathtot+=point
	if anglais:
		Player.anglaistot+=point
	if team:
		Player.teamtot+=point
	if orga:
		Player.orgatot+=point
	if adaptation:
		Player.adaptationtot+=point
	if informatique:
		Player.informatiquetot+=point
	if chimie:
		Player.chimietot+=point
	if francais:
		Player.francaistot+=point
	if bio:
		Player.biotot+=point
				
	if valid_reward:
		valid_sign.set_true()

		if Player!=null:
			if physique:
				Player.physique+=point
			if math:
				Player.math+=point
			if anglais:
				Player.anglais+=point
			if team:
				Player.team+=point
			if orga:
				Player.orga+=point
			if adaptation:
				Player.adaptation+=point
			if informatique:
				Player.informatique+=point
			if chimie:
				Player.chimie+=point
			if francais:
				Player.francais+=point
			if bio:
				Player.bio+=point
			if mode_point==0:
				Player.trophey+=trophey_reward
	else:
		valid_sign.set_false()
		
		if Player!=null and mode_point==1:
			Player.trophey-=trophey_reward
		
	Timer_valid.start_t(end_time_second)


func _on_End_Timer_timer_end():
	get_tree().call_group("main","next_tour")
	queue_free()
	
