extends Node

var keys = [
	{
		"key": "E",
		"active": func(): return $"../Notes/C".comboing
	},
	{
		"key": "R",
		"active": func(): return $"../Notes/D".comboing
	},
	{
		"key": "T",
		"active": func(): return $"../Notes/E".comboing
	},
	{
		"key": "Y",
		"active": func(): return $"../Notes/F".comboing
	},
	{
		"key": "U",
		"active": func(): return $"../Notes/G".comboing
	},
	{
		"key": "I",
		"active": func(): return $"../Notes/A".comboing
	},
	{
		"key": "O",
		"active": func(): return $"../Notes/H".comboing
	}
]

var patterns = [
	{
		"name": "CD",
		"active": false,
		"start": [1, 99],
		"end": [36, 132],
		"inputs": ["E", "R"],
		"time_damage": 2.0,
		"effect": func(): pass
	},
	{
		"name": "CE",
		"active": false,
		"start": [1, 37, 99],
		"end": [36, 98, 132],
		"inputs": ["E", "T"],
		"time_damage": 3.0,
		"effect": func(): pass
	},
	{
		"name": "CF",
		"active": false,
		"start": [1, 37, 133],
		"end": [36, 98, 162],
		"inputs": ["E", "Y"],
		"time_damage": 5.0,
		"effect": func(): pass
	},
	{
		"name": "CEG",
		"active": false,
		"start": [1],
		"end": [162],
		"inputs": ["E", "T", "U"],
		"time_damage": 5.0,
		"effect": func(): $"../Player".StartDashTimer()
	}
]
