###__Chose a faire__###
#
#	-transition en fondu
#
###__Chose a faire__###

extends Spatial

export(String, DIR) var Path_QCM_anglais
var QCM_anglais

export(String, DIR) var Path_QCM_math
var QCM_math

export(String, DIR) var Path_QCM_physique
var QCM_physique

export(String, DIR) var Path_QCM_chimie
var QCM_chimie

export(String, DIR) var Path_QCM_team
var QCM_team

export(String, DIR) var Path_QCM_adaptation
var QCM_adaptation

export(String, DIR) var Path_QCM_orga
var QCM_orga

export(String, DIR) var Path_QCM_informatique
var QCM_informatique

export(String, DIR) var Path_QCM_ODD
var QCM_ODD

export(String, DIR) var Path_QCM_francais
var QCM_francais

export(String, DIR) var Path_QCM_bio
var QCM_bio

export(PackedScene) var result_b
export var max_case=6
export var min_case=1

var coup_restant=0
var tour_joueur=0
var Player1
var Player2
var Player3
var Player4

var Player

var playerName1="Valentin"
var playerName2="Axel"
var playerName3="Dongwon"
var playerName4="Lucas"

var task=20
onready var camera=$"camera/InterpolatedCamera"

func list_files(path):
	var files =[]
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(load(path+"/"+file))
	dir.list_dir_end()
	return files
	
func _ready():
	QCM_anglais=list_files(Path_QCM_anglais)
	QCM_math=list_files(Path_QCM_math)
	QCM_physique=list_files(Path_QCM_physique)
	QCM_chimie=list_files(Path_QCM_chimie)
	QCM_team=list_files(Path_QCM_team)
	QCM_adaptation=list_files(Path_QCM_adaptation)
	QCM_orga=list_files(Path_QCM_orga)
	QCM_informatique=list_files(Path_QCM_informatique)
	QCM_ODD=list_files(Path_QCM_ODD)
	QCM_francais=list_files(Path_QCM_francais)
	QCM_bio=list_files(Path_QCM_bio)
	
	randomize()
	Player1=$"Player/Player1"
	Player2=$"Player/Player2"
	Player3=$"Player/Player3"
	Player4=$"Player/Player4"
	
	Player1.namePlayer=playerName1
	Player2.namePlayer=playerName2
	Player3.namePlayer=playerName3
	Player4.namePlayer=playerName4
	
	get_tree().call_group_flags(2,"player","refresh_name")
	get_tree().call_group_flags(2,"player","refresh_task",task)
	get_tree().call_group_flags(2,"PlayerResume", "refresh")
	$"Control/containerDice/Dice/Label/Timer2".start()

func New_QCM(player,mode_point="bonus"):
	if mode_point=="bonus":
		mode_point=0
	else:
		mode_point=1
	var new_QCM
	match Player.state_QCM:
		0:
			new_QCM=QCM_anglais[randi()%(len(QCM_anglais))].instance()
		1:
			new_QCM=QCM_math[randi()%(len(QCM_math))].instance()
		2:
			new_QCM=QCM_physique[randi()%(len(QCM_physique))].instance()
		3:
			new_QCM=QCM_chimie[randi()%(len(QCM_chimie))].instance()
		4:
			new_QCM=QCM_team[randi()%(len(QCM_team))].instance()
		5:
			new_QCM=QCM_adaptation[randi()%(len(QCM_adaptation))].instance()
		6:
			new_QCM=QCM_orga[randi()%(len(QCM_orga))].instance()
		7:
			new_QCM=QCM_informatique[randi()%(len(QCM_informatique))].instance()
		8:
			new_QCM=QCM_ODD[randi()%(len(QCM_ODD))].instance()
		9:
			new_QCM=QCM_francais[randi()%(len(QCM_francais))].instance()
		10:
			new_QCM=QCM_bio[randi()%(len(QCM_bio))].instance()
	if Player.state_QCM==10:
		Player.state_QCM=0
	else:
		Player.state_QCM+=1

	new_QCM.Player=player
	new_QCM.mode_point=mode_point
	add_child(new_QCM)

func move():
	if coup_restant>0:
		coup_restant-=1
		match tour_joueur:
			0:
				Player=Player1
			1:
				Player=Player2
			2:
				Player=Player3
			3:
				Player=Player4
		Player.move()
		camera.target=NodePath(str(Player.get_path())+"/camera_point")
	else:
		var caseType=Player.check_under_player()
		match caseType:
			1:
				next_tour()
			2:
				New_QCM(Player)
		if caseType!=1:
			Player.task-=1
				
func next_tour():
	$"Control/GlobalResume".refresh_score(Player)
	get_tree().call_group("PlayerResume", "refresh")
	tour_joueur=(tour_joueur+1)%4
	match tour_joueur:
			0:
				$"Control/GlobalResume".refresh_color(Player1)
			1:
				$"Control/GlobalResume".refresh_color(Player2)
			2:
				$"Control/GlobalResume".refresh_color(Player3)
			3:
				$"Control/GlobalResume".refresh_color(Player4)
	if Player1.task>0 or Player2.task>0 or Player3.task>0 or Player4.task>0:
		dice_on()
	else:
		get_tree().call_group_flags(2,"player","brain_direction")
		var instance=result_b.instance()
		instance.P1=Player1
		instance.P2=Player2
		instance.P3=Player3
		instance.P4=Player4
		add_child(instance)
		
func dice_on():
	$"Control/containerDice/Dice".disabled=false
	$"Control/containerDice/Dice/Label".visible=true
	$"Control/containerDice/Dice/Label/Timer2".start()
	
func move_finish():
	move()

func _on_Dice_dice_finish(num):
	if coup_restant==0:
		coup_restant=num
		move()
