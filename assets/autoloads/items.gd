extends Node

signal item_description_show(data: ItemData)
signal item_description_hide

var item_list: Array[ItemData] = [
	load("uid://r6h4tj3e130q"),
	load("uid://bowwraqrt75ex"),
	load("uid://syl7lkm0cn5i"),
	load("uid://dma314e686t7b"),
	load("uid://dkclpvrtvmfwu"),
	load("uid://cqflbg7xxooiw"),
	load("uid://hfiji4vb87hb"),
	load("uid://mtg6erdilc7g"),
	load("uid://cx2cs4unf8kxa"),
	load("uid://dfckusvf8egtv"),
	load("uid://c4mv54cntvxnt"),
]

func get_items_in_rarity(rarity: String):
	var itms: Array[ItemData] = []
	for i in item_list:
		if Globals.rarities.keys()[i.rarity] == rarity:
			itms.append(i)
		else:
			continue
	return itms

func roll_item(luck: float = PlayerStats.luck):
	var r = Globals.pick_rarity(luck)
	return get_items_in_rarity(r).pick_random()
