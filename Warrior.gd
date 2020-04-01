extends AnimatedSprite

signal hit_applied

export (String) var type = 'soldier'

var current_damage = 1

func _ready():
	play(type + '_idle')

func attack():
	z_index = 10
	$AnimationPlayer.play(type + '_attack')
	yield($AnimationPlayer, 'animation_finished')
	z_index = 0


func hit():
	print('Apply attack!')
	emit_signal('hit_applied', current_damage)

func apply_damage(value):
	print(str(value) + ' damage applied to me.')
