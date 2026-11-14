extends VBoxContainer

@onready var dmg_label: Label = $DamageStatContainer/Label
@onready var dmg_x_label: Label = $DamageXStatContainer/Label
@onready var dmg_ex_label: Label = $DamageEXStatContainer/Label
@onready var fire_rate_label: Label = $FireRateStatContainer/Label
@onready var pellet_sx_label: Label = $PelletSXStatContainer/Label
@onready var lifespan_label: Label = $LifespanStatContainer/Label
@onready var luck_label: Label = $Luck/Label
@onready var common_chance: Label = $CommonContainer/Chance
@onready var uncommon_chance: Label = $UncommonContainer/Chance
@onready var rare_chance: Label = $RareContainer/Chance
@onready var epic_chance: Label = $EpicContainer/Chance
@onready var godlike_chance: Label = $GodlikeContainer/Chance

func _ready():
	_set_chances()

func _process(delta: float) -> void:
	dmg_label.text = Globals.format(PlayerStats.damage)
	dmg_x_label.text = "X" + Globals.format(PlayerStats.damage_mult)
	dmg_ex_label.text = "^" + Globals.format(PlayerStats.damage_exp)
	fire_rate_label.text = Globals.format(PlayerStats.fire_rate) + "/s"
	pellet_sx_label.text = "X" + Globals.format(PlayerStats.pellet_speed_mult)
	lifespan_label.text = Globals.format(PlayerStats.pellet_lifespan) + "s"
	luck_label.text = str(Globals.round_to_dec(PlayerStats.luck, 2))

func _set_chances():
	var c := Globals.test_luck()
	common_chance.text = c[0]
	uncommon_chance.text = c[1]
	rare_chance.text = c[2]
	epic_chance.text = c[3]
	godlike_chance.text = c[4]
