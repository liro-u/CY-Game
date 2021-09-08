extends KinematicBody

export(String) var namePlayer="Player 1"

var task=20

export(int) var trophey=0

export(int) var physique=0
export(int) var math=0
export(int) var anglais=0
export(int) var team=0
export(int) var orga=0
export(int) var adaptation=0
export(int) var informatique=0
export(int) var chimie=0
export(int) var francais=0
export(int) var bio=0

var physiquetot=0
var mathtot=0
var anglaistot=0
var teamtot=0
var orgatot=0
var adaptationtot=0
var informatiquetot=0
var chimietot=0
var francaistot=0
var biotot=0

var physiquemoy
var mathmoy
var anglaismoy
var teammoy
var orgamoy
var adaptationmoy
var informatiquemoy
var chimiemoy
var francaismoy
var biomoy

var MathApp
var Info
var MathEcoFinance
var BioTechChimie
var GenieCivil
var Meca

var final_filiere

export var time_to_move=0.2
export var decalage=Vector3(-0.1,1,-1.5)

signal move_finish

onready var grid_floor=$"../../world/floor"
onready var tween=$"Tween"

var state_QCM=0

var droite=Vector3(0,0,-1)
var gauche=Vector3(0,0,1)
var avant=Vector3(-1,0,0)
var arriere=Vector3(1,0,0)
var direction_g=avant

export(String) var variableName

func _ready():
	translation-=decalage
	var coord_grid_p=grid_floor.world_to_map(translation)
	translation=grid_floor.map_to_world(coord_grid_p.x,coord_grid_p.y,coord_grid_p.z)
	translation+=decalage
	$Windo/Texte.text=namePlayer
	$Windo/Texte.hide()
	$Windo/Texte.show()
	$Windo.size = $Windo/Texte.rect_size
	
func move():
	var translation_i=translation
	translation-=decalage
	var coord_grid_p=grid_floor.world_to_map(translation)
	if direction_g!=droite and check_cell(coord_grid_p,droite)!=0 and check_cell(coord_grid_p,droite)!=-1:
		direction_g=gauche
		coord_grid_p+=droite
	elif direction_g!=gauche and check_cell(coord_grid_p,gauche)!=0 and check_cell(coord_grid_p,gauche)!=-1:
		direction_g=droite
		coord_grid_p+=gauche
	elif direction_g!=arriere and check_cell(coord_grid_p,arriere)!=0 and check_cell(coord_grid_p,arriere)!=-1:
		direction_g=avant
		coord_grid_p+=arriere
	elif direction_g!=avant and check_cell(coord_grid_p,avant)!=0 and check_cell(coord_grid_p,avant)!=-1:
		direction_g=arriere
		coord_grid_p+=avant
			
	var translation_t=grid_floor.map_to_world(coord_grid_p.x,coord_grid_p.y,coord_grid_p.z)
	translation_t+=decalage
	tween.interpolate_property(self,"translation",translation_i,translation_t,time_to_move)
	tween.start()
		

func check_cell(coord_grid_p_temp,direction=Vector3(0,0,0)):
	coord_grid_p_temp+=Vector3(direction.x,1,direction.z)
	return(grid_floor.get_cell_item(coord_grid_p_temp.x,coord_grid_p_temp.y,coord_grid_p_temp.z))
	
func _on_Tween_tween_all_completed():
	emit_signal("move_finish")

func check_under_player():
	var translation_temp=translation-decalage
	var coord_grid_p=grid_floor.world_to_map(translation_temp)
	return(check_cell(coord_grid_p))
		
func refresh_name():
	$"Windo/Texte".text=$"../../".get(variableName)
	$Windo/Texte.hide()
	$Windo/Texte.show()
	$Windo.size = $Windo/Texte.rect_size
	
func refresh_task(n):
	task=n

func moyenne():
	physiquemoy=(physique/physiquetot)*20
	mathmoy=(math/mathtot)*20
	anglaismoy=(anglais/anglaistot)*20
	teammoy=(team/teamtot)*20
	orgamoy=(orga/orgatot)*20
	adaptationmoy=(adaptation/adaptationtot)*20
	informatiquemoy=(informatique/informatiquetot)*20
	chimiemoy=(chimie/chimietot)*20
	francaismoy=(francais/francaistot)*20
	biomoy=(bio/biotot)*20

func calcul_m_filiere():
	MathApp=(mathmoy*1+informatiquemoy*0.75)/1.75
	Info=(mathmoy*0.75+informatiquemoy*1+anglaismoy*0.75)/2.5
	MathEcoFinance=(mathmoy*1+informatiquemoy*0.75+anglaismoy*0.75)/2.5
	BioTechChimie=(chimiemoy*1+biomoy*1+physiquemoy*0.75)/2.75
	GenieCivil=(mathmoy*1+physiquemoy*1)/2
	Meca=(biomoy*1+francaismoy*1+chimiemoy*1+informatiquemoy*1+adaptationmoy*1+orgamoy*1+teammoy*1+anglaismoy*1+mathmoy*1+physiquemoy*1)/10
	
func classment():
	var f=MathApp
	final_filiere=0
	if f<Info:
		f=Info
		final_filiere+=1
	if f<MathEcoFinance:
		f=MathEcoFinance
		final_filiere+=1
	if f<BioTechChimie:
		f=BioTechChimie
		final_filiere+=1
	if f<GenieCivil:
		f=GenieCivil
		final_filiere+=1
	if f<Meca:
		final_filiere+=1
		
func brain_direction():
	moyenne()
	calcul_m_filiere()
	classment()
	
