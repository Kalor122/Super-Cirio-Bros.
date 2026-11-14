extends Node2D

@onready var pellet_manager: PelletManager = $PelletManager
@onready var marker_2d: Marker2D = $Marker2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(Globals.test_luck(PlayerStats.luck))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	pellet_manager.shoot(marker_2d, Globals.round_to_dec(randf_range(10, 20), 2), true)
