extends Node

## on ground
var current_speed: float
var max_speed: float = 175
var acceleration: float = 750
var friction: float = 900

## return to idle
var return_friction: float = 500

## air values
var standard_jump_vel = -235
var air_speed = 125
var air_accel = 500
var air_res = 250
