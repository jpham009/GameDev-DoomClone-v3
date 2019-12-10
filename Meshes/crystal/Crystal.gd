extends KinematicBody

onready var other_audio = get_node('../Other Audio')

var player = null
var rotationRate = 100

#-----------------------------------------------------------
func _ready():
  pass # Replace with function body.

#-----------------------------------------------------------
func _process( delta ) :
  var rot_speed = deg2rad( rotationRate )
  rotate_y( rot_speed*delta )

#-----------------------------------------------------------
func _physics_process(delta):
  var collision = move_and_collide(Vector3(0,0,0) * 1 * delta)
  if collision:
    if collision.collider.name == "Player":
      collision.collider.shotDamageUp()
      if other_audio:
        other_audio._playSound( 'powerup' )
      queue_free()
      
#-----------------------------------------------------------
func set_player( p ) :
  player = p