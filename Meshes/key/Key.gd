extends KinematicBody

onready var other_audio = get_node('../Other Audio')

#-----------------------------------------------------------
func _ready():
  var anim = get_node("AnimationPlayer").get_animation("Take 01")
  anim.set_loop(true)
  get_node("AnimationPlayer").play("Take 01")
  
#-----------------------------------------------------------
# warning-ignore:unused_argument
func _process( delta ) :
  pass
  
#-----------------------------------------------------------  
func _physics_process( delta ) :
    var collision = move_and_collide(Vector3(0,0,0) * 1 *  delta)
    if collision:
      if collision.collider.name == "Player":
        get_node('../Player').key = true
        get_node('../HUD Layer/Key_image').visible = true
        if other_audio:
          other_audio._playSound( 'key' )
        queue_free()
        
#-----------------------------------------------------------