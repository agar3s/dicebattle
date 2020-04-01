extends Sprite


var spinning = false setget set_spinning
var faces = [0, 4, 83, 53, 58, 84]
var fps = 32
var acc_delta = 0

func _ready():
	pass


func _process(delta):
	if !spinning: return
	acc_delta += delta

	if acc_delta >= 1.0/fps:
		frame = faces[randi()%6]
		fps -= 1
		acc_delta = 0
		if fps == 4:
			spinning = false
			fps = 32
			$AnimationPlayer.play("dice")
			yield($AnimationPlayer, "animation_finished")
			$Sprite.show()
			$Sprite2.show()
			

func set_spinning(value):
	spinning = value
	if spinning:
		$Sprite.hide()
		$Sprite2.hide()
