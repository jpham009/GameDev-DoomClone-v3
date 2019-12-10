extends AudioStreamPlayer

# warning-ignore:unused_class_variable
onready var boom = preload('res://Audio/m-red_darkdetonation02.wav' )
# warning-ignore:unused_class_variable
onready var reload = preload('res://Audio/roll1n__mag-in-01.wav')
# warning-ignore:unused_class_variable
onready var key = preload('res://Audio/nandoo-messany-acid-scream-hardstyle.wav')
# warning-ignore:unused_class_variable
onready var explode = preload('res://Audio/bmaczero__explode.wav')
# warning-ignore:unused_class_variable
onready var biggerboom = preload('res://Audio/qubodup__explosion-short-sidohzen-165808.wav')
# warning-ignore:unused_class_variable
onready var ohyeah = preload('res://Audio/pbrechler-oh-yeah.wav' )
# warning-ignore:unused_class_variable
onready var powerup = preload('res://Audio/409261__wertstahl__001-bright-ice.wav')

onready var sounds = {
    'boom' : boom,
    'reload' : reload,
    'key' : key,
    'explode' : explode,
    'biggerboom' : biggerboom,
    'ohyeah' : ohyeah,
    'powerup' : powerup 
  }
  
func _ready():
  pass
  
func _playSound( which, fromTime = 0.0 ) :
  var sound = sounds.get( which, null )

  if sound == null :
    print( 'Unknown sound "%s" requested.' % which )
    return

  stream = sound

  play( fromTime )