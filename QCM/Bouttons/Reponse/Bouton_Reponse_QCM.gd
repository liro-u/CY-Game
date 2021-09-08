extends TextureButton

export(bool) var actu_text_auto=false
export(bool) var auto_start=false
export(Texture) var True_Texture
export(Texture) var False_Texture

export var speed=1
export(String, MULTILINE) var texte="[b]Reponse X :\nINSERER UNE REPONSE POSSIBLE[b]"
export(String, MULTILINE) var disabled_text=""
var text

signal show_end

func _ready():
	refresh()
	text.modulate.a=0
	mouse_filter=2
	set_physics_process(false)
	if auto_start:
		start_show()

func start_show():
	set_physics_process(true)
	
func _physics_process(delta):
	text.modulate.a+=speed*delta
	if text.modulate.a>=1:
		text.modulate.a=1
		mouse_filter=0
		set_physics_process(false)
		emit_signal("show_end")
	
func refresh():
	text=$"Margin/Text"
	if disabled:
		text.bbcode_text=disabled_text
	else:
		text.bbcode_text=texte

func desactivate():
	mouse_filter=2
	
func set_on_true():
	texture_pressed=True_Texture
	texture_normal=True_Texture
	
func set_on_false():
	texture_pressed=False_Texture
	texture_normal=False_Texture
