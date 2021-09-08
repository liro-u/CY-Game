tool
extends TextureRect
export var pretext="Player "  

func _physics_process(_delta):
	$"MarginContainer/Player1Name".placeholder_text=pretext
