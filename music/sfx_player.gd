extends Node2D

@onready var eat_sfx = $Pop
@onready var frenzy_sfx = $FrenzySfx
@onready var dash_sfx = $DashSfx
@onready var unlock_sfx = $UnlockFish
@onready var start_sfx = $StartSfx
@onready var fail_sfx = $Fail
@onready var success_sfx = $Success

func play_eat():
	eat_sfx.play()

func play_frenzy():
	frenzy_sfx.play()

func play_dash():
	dash_sfx.play()

func play_unlock():
	unlock_sfx.play()

func play_start():
	start_sfx.play()

func play_fail():
	fail_sfx.play()

func play_success():
	success_sfx.play()
