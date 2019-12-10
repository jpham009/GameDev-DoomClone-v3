extends KinematicBody

var player = null
onready var other_audio = get_node('../Other Audio')

#-----------------------------------------------------------
func _ready():
  add_to_group( 'health' )
#-----------------------------------------------------------
#func _process(delta):
#  pass
#-----------------------------------------------------------
func _physics_process(delta):
    var collision = move_and_collide(Vector3(0,0,0) * 1 * delta)
    if collision:
      if collision.collider.name == "Player":
        collision.collider.heal()
        if other_audio:
          other_audio._playSound( 'ohyeah' )
      queue_free()
#----------------------------------------------------------- 
func set_player( p ) :
  player = p
  