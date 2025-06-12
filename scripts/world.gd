extends Node

@onready var player_scene = preload("res://csenes/character.tscn")
@onready var players = $Players


func _ready() -> void:
	if Global.isServer:
		start_server()
	else:
		join_server()


func start_server():
	var peer = ENetMultiplayerPeer.new()
	peer.set_bind_ip("127.0.0.1")
	peer.create_server(1488)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(connect_player)
	connect_player(multiplayer.get_unique_id())

func join_server():
	var peer = ENetMultiplayerPeer.new()
	peer.create_client("127.0.0.1", 1488)
	multiplayer.multiplayer_peer = peer

func connect_player(id):
	add_player(str(id))

func add_player(nickname = ""):
	var player = player_scene.instantiate()
	player.name = str(nickname)
	players.add_child(player)
