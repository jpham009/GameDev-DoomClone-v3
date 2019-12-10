extends KinematicBody

const MOVE_SPEED = 8

const SENSE_DISTANCE = 20

onready var raycast = $RayCast
onready var anim_player = $AnimationPlayer

var player = null
var dead = false
var health = 10
onready var zombieAudio = get_node('../Zombie Audio')


#-----------------------------------------------------------
func _ready() :
  anim_player.play( 'walk' )
  add_to_group( 'zombies' )


#-----------------------------------------------------------
func _physics_process( delta ) :
  if dead :
    return

  if player == null :
    return

  var vec_to_player = player.translation - translation
#  if vec_to_player.length() > SENSE_DISTANCE :
#    # Too far away to sense the player.  Move in 'random' direction,
#    # which is in RADIANS.  The axis must normalized.
#    vec_to_player = vec_to_player.rotated( Vector3( 0, 1, 0 ), randf()*2*PI )

  vec_to_player = vec_to_player.normalized()
  raycast.cast_to = vec_to_player * 1.5

  # warning-ignore:return_value_discarded
  move_and_collide( vec_to_player * MOVE_SPEED * delta )

  if raycast.is_colliding() :
    var coll = raycast.get_collider()
    if coll != null and coll.name == 'Player' :
      coll.hurt()

#-----------------------------------------------------------
func hurt( howMuch = 1 ) :
  health -= howMuch

  if health <= 0 :
    dead = true
    $CollisionShape.disabled = true
    anim_player.play( 'die' )
    print( '%s died.' % name )
    if zombieAudio:
      zombieAudio._playSound( 'die' )
    if get_node('../HUD Layer'):
      get_node('../HUD Layer')._opponentDied()


  else :
    anim_player.play( 'wounded' )
    print( '%s wounded by %d, now has %d.' % [ name, howMuch, health ] )
    if zombieAudio:
      zombieAudio._playSound( 'grunt' )

#-----------------------------------------------------------
func setHealth( hp ) :
  health =  hp

#-----------------------------------------------------------
func set_player( p ) :
  player = p

#-----------------------------------------------------------
func areaDamage(origin, radius):
  var distance = (translation - origin).length()
  if distance <= radius:
    health = 0
    hurt()
#-----------------------------------------------------------
