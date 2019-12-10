extends AudioStreamPlayer

# warning-ignore:unused_class_variable
onready var grunt = preload('res://Audio/Male Grunt-SoundBible.com-68178715.wav' )
# warning-ignore:unused_class_variable
onready var die = preload( 'res://Audio/Wilhelm Scream - 0477.wav' )

onready var sounds = {
    'grunt' : grunt,
    'die'   : die
  }
  
func _ready():
  pass
  
func _playSound( which, fromTime = 0.0 ) :
  var sound = sounds.get( which, null )

  if sound == null :
    print( 'Zombie: Unknown sound "%s" requested.' % which )
    return

  stream = sound

  play( fromTime )
