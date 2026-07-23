extends CanvasLayer
@onready var chb_move: CheckBox = $GridContainer/Move/chbMove
@onready var chb_jump: CheckBox = $GridContainer/Jump/chbJump
@onready var chb_collect_coin: CheckBox = $GridContainer/CollectCoin/chbCollecrCoin
@onready var chb_open_door: CheckBox = $GridContainer/OpenDoor/chbOpenDoor
@onready var chbfinish_level: CheckBox = $GridContainer/FinishLevel/chbfinishLevel


func _ready():
	for checkbox in [chb_move, chb_jump, chb_collect_coin, chb_open_door, chbfinish_level]:
		checkbox.disabled = true

func mark_move():
	chb_move.button_pressed = true

func mark_jump():
	chb_jump.button_pressed = true

func mark_coin():
	chb_collect_coin.button_pressed = true

func mark_open_door():
	chb_open_door.button_pressed = true

func mark_finish():
	chbfinish_level.button_pressed = true

func reset_checklist():
	chb_move.button_pressed = false
	chb_jump.button_pressed = false
	chb_collect_coin.button_pressed = false
	chb_open_door.button_pressed = false
	chbfinish_level.button_pressed = false
