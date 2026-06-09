extends CanvasLayer
@onready var round_update = $round_panel/round_txt
@onready var kills_update = $kills_panel/kills_txt
@onready var round_limit = $Round_limit_txt/round_limit_txt
var last_kill = -1
func _ready() -> void:
	round_limit.text += "OBJECTIVE - " + str(Global.round_limit)
	kills_update.text += "KILLS - " + str(Global.kills)
	round_update.text += "ROUND - " + str(Global.Round)
func _process(delta: float) -> void:
	if Global.kills != last_kill:
		kills_update.text = "KILLS - " + str(Global.kills)
		last_kill = Global.kills
	round_update.text = "ROUND - " + str(Global.Round)
	round_limit.text = "OBJECTIVE - " + str(Global.round_limit)
