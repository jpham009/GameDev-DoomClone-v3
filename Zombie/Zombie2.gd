extends KinematicBody

const MOVE_SPEED = 4

onready var raycast = $RayCast
onready var anim_player = $AnimationPlayer

var player = null
var zombie = null
var dead = false
var health = 3
var radius = 5

onready var zombieAudio = get_node('../Zombie Audio')
onready var other_audio = get_node('../Other Audio')
const explosion = preload("res://Meshes/Particles3.tscn")
onready var timer = get_node('Timer')

#-----------------------------------------------------------
func _ready() :
  anim_player.play( 'walk' )
  add_to_group( 'zombies2' )
  
#-----------------------------------------------------------
func _physics_process( delta ) :
  if dead :
    return

  if player == null :
    return
    
  if zombie == null :
    return

  var vec_to_player = player.translation - translation
  vec_to_player.y -= .05
  vec_to_player = vec_to_player.normalized()
  raycast.cast_to = vec_to_player * 1.5

  # warning-ignore:return_value_discarded
  move_and_collide( vec_to_player * MOVE_SPEED * delta )

  if raycast.is_colliding() :
    var coll = raycast.get_collider()
    if coll != null and coll.name == 'Player' :
      coll.hurt()

#-----------------------------------------------------------
func hurt( damage ) :
  health -= damage

  if health <= 0 :
    dead = true
    $CollisionShape.disabled = true
    anim_player.play( 'die' )
    var explode = explosion.instance()
    self.add_child(explode)
    print( '%s died.' % name )
    if other_audio:
      other_audio._playSound( 'explode' )
    if zombieAudio:
      zombieAudio._playSound( 'die' )
    get_node('../HUD Layer')._opponentDied()
    timer.start()
    kill()
    yield(timer, "timeout")

  else :
    anim_player.play( 'wounded' )
    print( '%s wounded by %d, now has %d.' % [ name, damage, health ] )
    if zombieAudio:
      zombieAudio._playSound( 'grunt' )

#-----------------------------------------------------------
func setHealth( hp ) :
  health =  hp

#-----------------------------------------------------------
func set_player( p ) :
  player = p
  
func set_zombie( z ) :
  zombie = z
#-----------------------------------------------------------
func areaDamage(origin, radius):
  var distance = (translation - origin).length()
  if distance <= radius:
    health = 0
    hurt(1)
#-----------------------------------------------------------
func kill() :
  get_tree().call_group('zombies', 'areaDamage', translation, radius)
  get_tree().call_group('player', 'areaDamage', translation, radius)
