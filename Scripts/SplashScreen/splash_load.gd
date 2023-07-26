extends Node2D

@onready var WarningScreen : Node2D = $WarningGroup
@onready var CreditScreen : Node2D = $SmallCreditGroup
@export var warningScreenTime :float = 5.0
@export var creditScreenTime :float = 20.0
@export var crossTime :float = 5.0
@export var pathToResorce :String = "res://Scenes/node_2d.tscn"

var timer: float = 0
var state = 0


# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  timer += 1 * delta
  
  var statetime:float = 0
  
  if(Input.is_action_just_pressed("ui_skip")):
      get_tree().change_scene_to_file(pathToResorce)
  
  match state:
    0:
      statetime = warningScreenTime
    1:
      statetime = crossTime
    2:
      statetime = creditScreenTime
    3:
      statetime = crossTime/2
    4:
      get_tree().change_scene_to_file(pathToResorce)
      
  if (state == 1 and statetime > timer):
    var section:float = timer - (statetime/2)
    var clPerc: float = (abs(section/(statetime/2)) if section < 0 else 0.0) 
    var opPerc: float = (section/(statetime/2) if section > 0 else 0.0) 
    WarningScreen.modulate.a = clPerc
    CreditScreen.modulate.a = opPerc
  if (state == 3 and statetime > timer):
    var clPerc: float = (statetime/2-timer)/(statetime/2)
    CreditScreen.modulate.a = clPerc
      
  if (statetime<timer) :
      timer = 0
      state += 1
