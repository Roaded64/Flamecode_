extends Camera2D


const SCREEN_SIZE := Vector2( 680, 700 )
var cur_screen := Vector2( 680, 700 )

# tela tremer
var randomS:float  = 5.0
var shakeFade:float = 6.5
var rng = RandomNumberGenerator.new()
var shakeS:float = 0.0

func _ready():
	global_position = get_parent().global_position
	_update_screen( cur_screen )

func _process(delta: float) -> void:
	if shakeS > 0:
		shakeS = lerpf(shakeS, 0, shakeFade * delta)
		
		offset = randomOffset()

func _physics_process(delta):
	var parent_screen : Vector2 = ( get_parent().global_position / SCREEN_SIZE ).floor()
	if not parent_screen.is_equal_approx( cur_screen ):
		_update_screen( parent_screen )

func _update_screen( new_screen : Vector2 ):
	cur_screen = new_screen
	global_position = cur_screen * SCREEN_SIZE + SCREEN_SIZE * 0.7

func apply_shake():
	shakeS = randomS

func randomOffset():
	return Vector2(rng.randf_range(-shakeS, shakeS), rng.randf_range(-shakeS, shakeS))
