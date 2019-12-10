extends KinematicBody

#onready var raycast = $RayCast
#onready var anim_player = $AnimationPlayer

var player = null
onready var pack = self.CollisionShape

#onready var object = get_node('health_pack')
# Called when the node enters the scene tree for the first time.
func _ready():
  add_to_group( 'health' )
   # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  pass

func _physics_process(delta):
#  var vec_to_player = player.translation - translation
#  #vec_to_player = vec_to_player.normalized()
#  raycast.cast_to = vec_to_player
#  move_and_collide( vec_to_player * 1 * delta )
  
  if pack.is_colliding() :
    var coll = pack.get_collider()
    if coll != null and coll.name == 'Player' :
      coll.hurt()

func set_player( p ) :
  player = p
  