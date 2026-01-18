## 操作：矢印キーとスペースキー

extends CharacterBody2D

# スピード変える
const SPEED = 300.0
# ジャンプの速さ
const JUMP_VELOCITY = -400.0
# 重力の大きさ
const GRAVITY = 500
var screen_size
# ゲーム開始で実行される
func _ready() -> void:
	screen_size = get_viewport_rect()

func _physics_process(delta: float) -> void:
	# 地面についていない時は重力をかける
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		
	# ジャンプ操作
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# 左へ移動
	if Input.is_action_pressed("move_left"):
		# アニメーションを切り替える
		$AnimatedSprite2D.flip_h = true
		velocity.x = -1 * SPEED
	# 右へ移動
	elif Input.is_action_pressed("move_right"):
		# アニメーションを切り替える
		$AnimatedSprite2D.flip_h = false
		velocity.x = 1 * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if velocity.length() > 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	move_and_slide()
