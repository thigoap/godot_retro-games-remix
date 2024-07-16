extends Node

@export var inv:Inv

func collect(item):
	inv.insert(item)

func remove(item):
	inv.remove(item)
