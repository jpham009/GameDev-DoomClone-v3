extends RigidBody

var player = null
var zombie = null
var dead = false
var health = 3
var radius = 8

const explosion = preload("res://Meshes/Particles.tscn")
onready var other_audio = get_node('../Other Audio')
onready var timer = get_node('Timer')

func _ready():
  pass # Replace with function body.

#func _process(delta):
#  pass

func _physics_process( _delta ) :
  if dead :
    return

  if player == null :
    return
  if zombie == null :
    return

func set_player( p ) :
  player = p

func set_zombie( z ) :
  zombie = z
  
func kill() :
  get_tree().call_group('zombies', 'areaDamage', translation, radius)
  get_tree().call_group('zombies2', 'areaDamage', translation, radius)
  get_tree().call_group('player', 'areaDamage', translation, radius)
  
func hurt( howMuch = 1 ) :
  health -= howMuch
  if health <= 0 :
    dead = true    
    $CollisionShape.disabled = true
    var explode = explosion.instance()
    self.add_child(explode)
    kill()
    if other_audio:
      other_audio._playSound( 'boom' )
    get_node('barrell').visible = false
    timer.start()
    yield(timer, "timeout")
    queue_free()
