extends KinematicBody


onready var player = get_node('../Player')
const MOVE_SPEED = 1
# Called when the node enters the scene tree for the first time.

func _ready():
  pass # Replace with function body.

func _physics_process( delta ) :
  var collision = move_and_collide(Vector3(0,0,0) * 10 * delta)
  if collision:
    if collision.collider.name == "Player":
      keycheck()
      
func keycheck():
  if player.has_key():
    var timeStr = $'../HUD Layer'.getTimeStr()
    print( 'Last opponent died at %s.' % timeStr )
    $'../Message Layer/Message'.activate( 'Player Wins!\n%s' % timeStr )