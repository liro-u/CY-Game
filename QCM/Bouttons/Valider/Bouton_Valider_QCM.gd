extends TextureButton

export(String) var texte="Valider la réponse"

func _ready():
	refresh()
	
func refresh():
	$"Label".text=texte

func _on_Boutton_Valid_pressed():
	disabled=true
