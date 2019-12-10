extends CanvasLayer

var elapsedTime = 0
var lastTime    = 0
# warning-ignore:unused_class_variable
onready var timer = get_node('Timer')

#-----------------------------------------------------------
func _ready() :
  elapsedTime = 0
  
#-----------------------------------------------------------
func _process( delta ) :
  _updateHUDTime( delta )
  
#-----------------------------------------------------------
func _updateHUDTime( delta ) :
  elapsedTime += delta
  if elapsedTime - lastTime > 1 :
    lastTime = elapsedTime
    get_node( 'LevelTime' ).text = getTimeStr()
    
#-----------------------------------------------------------
func getTimeStr() :
  var minutes = int( elapsedTime / 60 )
  var seconds = int( elapsedTime - minutes*60 )
  return '%02d:%02d' % [ minutes, seconds ]
  
#-----------------------------------------------------------
var maxAmmo = 0
var numAmmo = 0

func _resetAmmo( qty ) :
  maxAmmo = qty
  numAmmo = qty
  _setAmmoMessage()

func _setAmmoMessage() :
  get_node( 'Ammo' ).text = '%d / %d' % [ numAmmo, maxAmmo ]

func _ammoUsed() :
  var success = numAmmo != 0

  if success :
    numAmmo -= 1

  _setAmmoMessage()
  return success

#-----------------------------------------------------------
var maxOpponents = 0
var numOpponents = 0

func _resetOpponents( qty ) :
  maxOpponents = qty
  numOpponents = qty
  _setOpponentMessage()

func _addOpponent():
  maxOpponents += 1
  numOpponents += 1
  _setOpponentMessage()

func _setOpponentMessage() :
  if numOpponents < 0: 
    numOpponents = 0
  get_node( 'Opponents' ).text = '%d / %d' % [ numOpponents, maxOpponents ]

func _opponentDied() :
  numOpponents -= 1
  _setOpponentMessage()

# Player wins when he gets the key and goes to the door. 

#  if numOpponents == 0 :
#    timer.start()
#    yield(timer, "timeout")
#    var timeStr = $'../HUD Layer'.getTimeStr()
#    print( 'Last opponent died at %s.' % timeStr )
#    $'../Message Layer/Message'.activate( 'Player Wins!\n%s' % timeStr )

#-----------------------------------------------------------
var maxHealth = 3
var numHealth = 3

func _resetHealth( qty ) :
  maxHealth = qty
  numHealth = qty
  _setHealthMessage()

func _setHealthMessage() :
  get_node( 'Health' ).text = 'Health: %d / %d' % [ numHealth, maxHealth ]

func _playerHurt(health):
  numHealth = health
  _setHealthMessage()
  
func _healthUp(health) :
  maxHealth = health
  numHealth = health
  _setHealthMessage()
  
#-----------------------------------------------------------
