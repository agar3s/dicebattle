#
# https://adanadej.itch.io/superbattlewar
# https://szadiart.itch.io/animated-character-pack
# https://shikashiassets.itch.io/shikashis-fantasy-icons-pack

extends Node


func _ready():
	$Scenario/Player.connect('hit_applied', $Scenario/Enemy, 'apply_damage')
	$Scenario/Enemy.connect('hit_applied', $Scenario/Player, 'apply_damage')
	$HUD/Attack_Player.connect('button_down', self, 'roll_dices')
	$HUD/Attack_Enemy.connect('button_down', $Scenario/Player, 'attack')


func roll_dices():
	for dice in $Scenario/Dices.get_children():
		dice.spinning = true
