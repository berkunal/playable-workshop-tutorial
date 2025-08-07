extends Node

@onready var main_menu := $CanvasLayer/MainMenu
@onready var address_entry := $CanvasLayer/MainMenu/MarginContainer/VBoxContainer/AddressEntry

const Player = preload("res://scenes/player.tscn")
const PORT = 9000
var enet_peer := ENetMultiplayerPeer.new()

func _on_host_button_pressed() -> void:
	main_menu.hide()

	enet_peer.create_server(PORT)
	multiplayer.multiplayer_peer = enet_peer
	multiplayer.peer_connected.connect(add_player)
	
	add_player(multiplayer.get_unique_id())

func _on_join_button_pressed() -> void:
	main_menu.hide()
	
	enet_peer.create_client("localhost", PORT) # Temp localhost
	multiplayer.multiplayer_peer = enet_peer

func add_player(peer_id: int) -> void:
	var player := Player.instantiate()
	player.name = "Player_" + str(peer_id)
	add_child(player)
