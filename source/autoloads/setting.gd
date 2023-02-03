extends Node


# Private constants

const __PATH = "settings"


# Lifecycle methods

func _ready() -> void:
	__load()


# Public variables

var volume_master: int = 3 : set = __set_volume_master
var volume_music: int = 3 : set = __set_volume_music
var volume_sound_effects: int = 3 : set = __set_volume_sound_effects


# Private methods

func __load() -> void:
	var config = ConfigFile.new()

	if config.load("user://%s" % __PATH) != OK:
		__save()
		config.load("user://%s" % __PATH)

	self.volume_master = config.get_value("setting", "volume_master", self.volume_master)
	self.volume_music = config.get_value("setting", "volume_music", self.volume_music)
	self.volume_sound_effects = config.get_value("setting", "volume_sound_effects", self.volume_sound_effects)


func __save() -> void:
	var config: ConfigFile = ConfigFile.new()

	config.set_value("setting", "volume_master", self.volume_master)
	config.set_value("setting", "volume_music", self.volume_music)
	config.set_value("setting", "volume_sound_effects", self.volume_sound_effects)

	config.save("user://%s" % __PATH)


func __set_volume_master(value: int) -> void:
	volume_master = value
#	Event.set_volume_master.emit(value)

	__save()


func __set_volume_music(value: int) -> void:
	volume_music = value
#	Event.set_volume_music.emit(value)

	__save()


func __set_volume_sound_effects(value: int) -> void:
	volume_sound_effects = value
#	Event.set_volume_sound_effects.emit(value)

	__save()
