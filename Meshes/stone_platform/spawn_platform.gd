extends Spatial
#
## Called when the node enters the scene tree for the first time.
#func _ready():
#  pass
#
#onready var timer = get_node('Timer')
#var delay = false
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _physics_process( delta ) :
#  if delay == false: 
#    timer.start() # Start the Timer counting down
#    delay = true
#    var zombieSpawn = load("res://Zombie/Zombie.tscn")
#    var zombie = zombieSpawn.instance()
#    zombie.setHealth( 3 )
#    zombie.translation = Vector3(3.164,3,-2.70)
#    self.add_child(zombie)
#    yield(timer, "timeout") # Wait for the timer to wind down
#    delay = false
#
