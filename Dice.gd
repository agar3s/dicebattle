extends Node2D

signal stopped

var spinning = false setget set_spinning
# 0, 4, 83, 53, 58, 84, 9, 51, 55, 59, 72, 89
var faces = [0, 4, 83, 53, 58, 84]
var fps = 32
var acc_delta = 0

var keep = false setget set_keep
var locked = false
var roll_count = 0

var result = ''

func _ready():
	reset()
	$Area.connect('input_event', self, 'on_input_event')


func on_input_event(_node, _event, _id):
	if !locked && !spinning && _event is InputEventMouseButton && _event.pressed:
		self.keep = !keep


func _process(delta):
	if !spinning: return
	acc_delta += delta

	if acc_delta >= 1.0/fps:
		$Icon.frame = faces[randi()%faces.size()]
		fps -= 2
		acc_delta = 0
		if fps <= 2:
			fps = 32
			set_result()


func set_result():
	spinning = false
	$AnimationPlayer.play('dice')
	yield($AnimationPlayer, 'animation_finished')
	
	match $Icon.frame:
		0:
			result = 'skull'
			self.keep = true
			self.locked = true
		4:
			result = 'curse'
		83:
			result = 'attack'
		53:
			result = 'heal'
		58:
			result = 'destroy_curse'
		84:
			result = 'attack'
	
	if roll_count >= 3:
		self.keep = true
		self.locked = true
	
	emit_signal('stopped')

func set_spinning(value):
	if keep:
		self.locked = true
		return
	
	roll_count += 1
	spinning = value


func reset():
	self.locked = false
	self.keep = false
	roll_count = 0
	


func set_keep(value):
	keep = value
	$Keep_icon.visible = keep
	if keep:
		$Back2.color = Color('1f040f')
	else:
		$Back2.color = Color('4a565a')

