extends KinematicBody

#export var rotationRate = 100
export var quantity     = 20
onready var other_audio = get_node('../Other Audio')

#-----------------------------------------------------------
# warning-ignore:unused_argument
func _process( delta ) :
#  var rot_speed = deg2rad( rotationRate )
#  rotate_y( rot_speed*delta )
  pass
#-----------------------------------------------------------
func _physics_process(delta):  
  var collision = move_and_collide(Vector3(0,0,0) * 10 * delta)
  if collision:
    if collision.collider.name == "Player":
      collision.collider.reload()
      if other_audio:
        other_audio._playSound( 'reload' )
      queue_free()
#-----------------------------------------------------------
func setQuantity( qty ) :
  quantity = qty

#-----------------------------------------------------------
