extends Node3D

@onready var front_ray: RayCast3D = $FrontRay
@onready var back_ray: RayCast3D = $BackRay
@onready var left_ray: RayCast3D = $LeftRay
@onready var right_ray: RayCast3D = $RightRay
@onready var camera: Camera3D = $Camera3D
@onready var animation: AnimationPlayer = $Animation

const TRAVEL_TIME: float = 0.3
var tween: Tween

func _physics_process(delta: float) -> void:
	if tween is Tween:
		if tween.is_running():
			return
	if Input.is_action_pressed("forward") and not front_ray.is_colliding():
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT) # trans/ease makes the transition more discrete
		var forward_vector = -camera.get_global_transform().basis.z
		tween.tween_property(self, "transform", transform.translated(forward_vector * 2), TRAVEL_TIME)
		animation.play("headbob")
	if Input.is_action_pressed("back") and not back_ray.is_colliding():
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		var back_vector = camera.get_global_transform().basis.z
		tween.tween_property(self, "transform", transform.translated(back_vector * 2), TRAVEL_TIME)
		animation.play("headbob")
	if Input.is_action_pressed("left") and not left_ray.is_colliding():
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		var left_vector = -camera.get_global_transform().basis.x
		tween.tween_property(self, "transform", transform.translated(left_vector * 2), TRAVEL_TIME)
	if Input.is_action_pressed("right") and not right_ray.is_colliding():
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		var left_vector = camera.get_global_transform().basis.x
		tween.tween_property(self, "transform", transform.translated(left_vector * 2), TRAVEL_TIME)
	if Input.is_action_pressed("rotate_left"):
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform:basis", transform.basis.rotated(Vector3.UP, PI / 2), TRAVEL_TIME)
	if Input.is_action_pressed("rotate_right"):
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform:basis", transform.basis.rotated(Vector3.UP, -PI / 2), TRAVEL_TIME)
