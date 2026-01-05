extends Node

enum EnumNote { C, D, E, F, G, A, B }

var keys = [
	{
		"id": 0,
		"key": "C",
		"active": func(): return $"../Notes/C".comboing
	},
	{
		"id": 1,
		"key": "D",
		"active": func(): return $"../Notes/D".comboing
	},
	{
		"id": 2,
		"key": "E",
		"active": func(): return $"../Notes/E".comboing
	},
	{
		"id": 3,
		"key": "F",
		"active": func(): return $"../Notes/F".comboing
	},
	{
		"id": 4,
		"key": "G",
		"active": func(): return $"../Notes/G".comboing
	},
	{
		"id": 5,
		"key": "A",
		"active": func(): return $"../Notes/A".comboing
	},
	{
		"id": 6,
		"key": "B",
		"active": func(): return $"../Notes/B".comboing
	}
]

var patterns = [
	{
		"name": "CD",
		"active": false,
		"start": [1, 99],
		"end": [36, 132],
		"inputs": ["C", "D"],
		"time_damage": 2.0,
		"effect": func(): pass
	},
	{
		"name": "CE",
		"active": false,
		"start": [1, 37, 99],
		"end": [36, 98, 132],
		"inputs": ["C", "E"],
		"time_damage": 3.0,
		"effect": func(): pass
	},
	{
		"name": "CF",
		"active": false,
		"start": [1, 37, 133],
		"end": [36, 98, 162],
		"inputs": ["C", "F"],
		"time_damage": 5.0,
		"effect": func(): pass
	},
	{
		"name": "CEG",
		"active": false,
		"start": [1],
		"end": [162],
		"inputs": ["C", "E", "G"],
		"time_damage": 5.0,
		"effect": func(): $"../Player".StartDashTimer()
	}
]

const CHORDS := [
	{
		"id": "C_DUR",
		"notes": [EnumNote.C, EnumNote.E, EnumNote.G],
		"HP": 5.0,
		"speed_mult": 1.3,
		},
	{
		"id": "D_MOLL",
		"notes": [EnumNote.D, EnumNote.F, EnumNote.A],
		"HP": 5.0,
		"speed_mult": 1.3,
		},
	{
		"id": "E_MOLL",
		"notes": [EnumNote.E, EnumNote.G, EnumNote.B],
		"HP": 5.0,
		"speed_mult": 1.3,
	}
]
