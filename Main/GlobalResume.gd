extends VBoxContainer

export var WHT=Color(1,1,1)
export var RED=Color(1,0,0)

onready var Player1=$"../../Player/Player1"
onready var Player2=$"../../Player/Player2"
onready var Player3=$"../../Player/Player3"
onready var Player4=$"../../Player/Player4"

onready var ResumeP1=$"PlayerResume1"
onready var ResumeP2=$"PlayerResume2"
onready var ResumeP3=$"PlayerResume3"
onready var ResumeP4=$"PlayerResume4"

var Player

func _ready():
	ResumeP1.refreshP(Player1)
	ResumeP2.refreshP(Player2)
	ResumeP3.refreshP(Player3)
	ResumeP4.refreshP(Player4)
	get_tree().call_group("PlayerResume", "refresh")
	ResumeP1.set_color(RED)

func refresh_score(player):
	var cond=true
	var P=player
	var temp=ResumeP1.Player
	
	if temp==player and cond:
		cond=false
		
	if P.trophey>ResumeP1.trophey and cond:
		ResumeP1.refreshP(P)
		P=temp
	temp=ResumeP2.Player
	if temp==player and cond:
		ResumeP2.refreshP(P)
		cond=false
	
	if P.trophey>ResumeP2.trophey and cond:
		ResumeP2.refreshP(P)
		P=temp
	temp=ResumeP3.Player
	if temp==player and cond:
		ResumeP3.refreshP(P)
		cond=false

	if P.trophey>ResumeP3.trophey and cond:
		ResumeP3.refreshP(P)
		P=temp
	temp=ResumeP4.Player
	if temp==player and cond:
		ResumeP4.refreshP(P)
		cond=false

	if P.trophey>ResumeP4.trophey and cond:
		ResumeP4.refreshP(P)

func refresh_color(player):
	get_tree().call_group_flags(2,"PlayerResume","set_color",WHT)
	if ResumeP1.Player==player:
		ResumeP1.set_color(RED)
	elif ResumeP2.Player==player:
		ResumeP2.set_color(RED)
	elif ResumeP3.Player==player:
		ResumeP3.set_color(RED)
	elif ResumeP4.Player==player:
		ResumeP4.set_color(RED)
	
