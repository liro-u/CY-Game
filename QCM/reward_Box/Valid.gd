extends TextureRect

export(Texture) var faux
export(Texture) var juste

func _ready():
	visible=false
	
func set_true():
	texture=juste
	visible=true
	
func set_false():
	texture=faux
	visible=true
