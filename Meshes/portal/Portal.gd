extends KinematicBody

var player = null
var zombie = null
var dead = false
var health = 10
var radius = 10

onready var anim_player = $AnimationPlayer
onready var timer = get_node('Timer')
const explosion = preload("res://Meshes/Particles2.tscn")
onready var other_audio = get_node('../Other Audio')

#-----------------------------------------------------------
func _ready():
  anim_player.play("Take 001")
  
#-----------------------------------------------------------
func _play():
  anim_player.play("Take 001")

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
  
#-----------------------------------------------------------
func kill() :
  get_tree().call_group('zombies', 'areaDamage', translation, radius)
  get_tree().call_group('player', 'areaDamage', translation, radius)

#-----------------------------------------------------------
func hurt( damage ) :
  health -= damage

  if health <= 0 :
    dead = true    
    $CollisionShape.disabled = true
    var explode = explosion.instance()
    self.add_child(explode)
    kill()
    if other_audio:
      other_audio._playSound( 'biggerboom' )
    get_node('RootNode').visible = false
    get_node('../Key').visible = true
    timer.start()
    yield(timer, "timeout")
    queue_free()