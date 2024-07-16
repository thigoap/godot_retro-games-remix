# https://www.youtube.com/watch?v=X3J0fSodKgs
extends Resource
class_name Inv

signal update

@export var slots: Array[InvSlot]

func insert(item: InvItem):
	var itemslots = slots.filter(func(slot): return slot.item == item)
	if !itemslots.is_empty():
		#itemslots[0].amount += 1
		print('already  got this item')
	else:
		var emptyslots = slots.filter(func(slot): return slot.item == null)
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			#emptyslots[0].amount = 1
	update.emit()
	
func remove(item: InvItem):
	for itemSlot in slots:
		if itemSlot.item == item:
			itemSlot.item = null
	update.emit()
