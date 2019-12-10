extends AudioStreamPlayer

var sounds = {
    'shoot' : preload( 'res://Audio/Pew_Pew-DKnight556-1379997159.wav' ),
    'shoot2': preload( 'res://Audio/pistol.wav'),
    'empty' : preload( 'res://Audio/Gun+Empty.wav' ),
    'melee' : preload( 'res://Audio/flasher21__splat.wav' ),
    'swing' : preload( 'res://Audio/sypherzent__basic-melee-swing-miss-whoosh.wav'),
    'death' : preload( 'res://Audio/jorickhoofd__scream-noooh.wav')
  }

func _playSound( which, fromTime = 0.0 ) :
  var sound = sounds.get( which, null )

  if sound == null :
    print( 'Player: Unknown sound "%s" requested.' % which )
    return

  stream = sound

  play( fromTime )
