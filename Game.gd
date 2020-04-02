#
# https://adanadej.itch.io/superbattlewar
# https://szadiart.itch.io/animated-character-pack
# https://shikashiassets.itch.io/shikashis-fantasy-icons-pack

extends Node

var roll_count = 0

func _ready():
	randomize()
	$Scenario/Player.connect('hit_applied', $Scenario/Enemy, 'apply_damage')
	$Scenario/Enemy.connect('hit_applied', $Scenario/Player, 'apply_damage')
	$HUD/Roll.connect('button_down', self, 'roll_dices')
	$HUD/Play.connect('button_down', self, 'play_dices')
	
	$Scenario/Dices/Dice3.connect('stopped', self, 'dices_stopped')
	# it doesn't work because when dice 3 is locked it doesnt trigger the event...


func roll_dices():
	if roll_count>=3: return
	roll_count += 1
	$HUD/Roll.disabled = true
	$HUD/Play.disabled = true
	
	for dice in $Scenario/Dices.get_children():
		dice.spinning = true
		dice.locked = roll_count >= 3


func play_dices():
	# do something
	# ...
	# then
	for dice in $Scenario/Dices.get_children():
		dice.reset()
	
	roll_count = 0
	$HUD/Roll.disabled = false
	$HUD/Play.disabled = true


func dices_stopped():
	$HUD/Play.disabled = false
	if roll_count >= 3: return
	$HUD/Roll.disabled = false

