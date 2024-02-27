# How to run

## With Docker
```./init.sh docker run <path_to_log_file>```

### Run the application with log example
```./init.sh docker run qgames.log```

### Running the tests
```./init.sh docker tests```

## Without Docker
```./bin/quake_log_parser <path_to_log_file>```

# Design decisions
- If a players is killed by world OR kills himself, that player loses 1 kill.
- If a player disconnects, their kills will be counted on total kills and kill
  by means but they won't appear on final score.
- When a game ends, the application will print the game's results to the console.
- The counter total_kills includes player and world deaths.

### Output of the test file
```json
{
  "game_1": {
    "total_kills": 0,
    "players": [
      "Isgalamido"
    ],
    "kills": {
      "Isgalamido": 0
    },
    "kill_by_means": {
    }
  },
  "game_2": {
    "total_kills": 11,
    "players": [
      "Isgalamido"
    ],
    "kills": {
      "Isgalamido": -7
    },
    "kill_by_means": {
      "MOD_TRIGGER_HURT": 7,
      "MOD_ROCKET_SPLASH": 3,
      "MOD_FALLING": 1
    }
  },
  "game_3": {
    "total_kills": 4,
    "players": [
      "Dono da Bola",
      "Isgalamido",
      "Zeh"
    ],
    "kills": {
      "Isgalamido": 1,
      "Dono da Bola": -1,
      "Zeh": -2
    },
    "kill_by_means": {
      "MOD_ROCKET": 1,
      "MOD_TRIGGER_HURT": 2,
      "MOD_FALLING": 1
    }
  },
  "game_4": {
    "total_kills": 105,
    "players": [
      "Dono da Bola",
      "Isgalamido",
      "Zeh",
      "Assasinu Credi"
    ],
    "kills": {
      "Zeh": 20,
      "Isgalamido": 19,
      "Assasinu Credi": 11,
      "Dono da Bola": 5
    },
    "kill_by_means": {
      "MOD_TRIGGER_HURT": 9,
      "MOD_FALLING": 11,
      "MOD_ROCKET": 20,
      "MOD_RAILGUN": 8,
      "MOD_ROCKET_SPLASH": 51,
      "MOD_MACHINEGUN": 4,
      "MOD_SHOTGUN": 2
    }
  },
  "game_5": {
    "total_kills": 14,
    "players": [

    ],
    "kills": {
    },
    "kill_by_means": {
      "MOD_ROCKET": 4,
      "MOD_ROCKET_SPLASH": 4,
      "MOD_TRIGGER_HURT": 5,
      "MOD_RAILGUN": 1
    }
  },
  "game_6": {
    "total_kills": 29,
    "players": [
      "Oootsimo",
      "Isgalamido",
      "Zeh",
      "Dono da Bola",
      "Mal",
      "Assasinu Credi"
    ],
    "kills": {
      "Oootsimo": 8,
      "Zeh": 7,
      "Isgalamido": 3,
      "Dono da Bola": 2,
      "Assasinu Credi": 1,
      "Mal": 0
    },
    "kill_by_means": {
      "MOD_ROCKET": 5,
      "MOD_RAILGUN": 2,
      "MOD_SHOTGUN": 4,
      "MOD_ROCKET_SPLASH": 13,
      "MOD_TRIGGER_HURT": 3,
      "MOD_FALLING": 1,
      "MOD_MACHINEGUN": 1
    }
  },
  "game_7": {
    "total_kills": 130,
    "players": [
      "Oootsimo",
      "Isgalamido",
      "Zeh",
      "Dono da Bola",
      "Mal",
      "Assasinu Credi"
    ],
    "kills": {
      "Oootsimo": 20,
      "Assasinu Credi": 16,
      "Isgalamido": 12,
      "Dono da Bola": 8,
      "Zeh": 7,
      "Mal": -3
    },
    "kill_by_means": {
      "MOD_FALLING": 7,
      "MOD_TRIGGER_HURT": 20,
      "MOD_ROCKET_SPLASH": 49,
      "MOD_ROCKET": 29,
      "MOD_SHOTGUN": 7,
      "MOD_RAILGUN": 9,
      "MOD_MACHINEGUN": 9
    }
  },
  "game_8": {
    "total_kills": 89,
    "players": [
      "Oootsimo",
      "Isgalamido",
      "Zeh",
      "Dono da Bola",
      "Mal",
      "Assasinu Credi"
    ],
    "kills": {
      "Isgalamido": 20,
      "Oootsimo": 14,
      "Zeh": 12,
      "Assasinu Credi": 8,
      "Dono da Bola": -1,
      "Mal": -4
    },
    "kill_by_means": {
      "MOD_TRIGGER_HURT": 9,
      "MOD_ROCKET": 18,
      "MOD_ROCKET_SPLASH": 39,
      "MOD_FALLING": 6,
      "MOD_RAILGUN": 12,
      "MOD_MACHINEGUN": 4,
      "MOD_SHOTGUN": 1
    }
  },
  "game_9": {
    "total_kills": 67,
    "players": [
      "Oootsimo",
      "Dono da Bola",
      "Zeh",
      "Chessus",
      "Mal",
      "Assasinu Credi"
    ],
    "kills": {
      "Zeh": 12,
      "Chessus": 8,
      "Oootsimo": 7,
      "Assasinu Credi": 4,
      "Mal": 1,
      "Dono da Bola": -1
    },
    "kill_by_means": {
      "MOD_TRIGGER_HURT": 8,
      "MOD_ROCKET_SPLASH": 25,
      "MOD_SHOTGUN": 1,
      "MOD_ROCKET": 17,
      "MOD_MACHINEGUN": 3,
      "MOD_FALLING": 3,
      "MOD_RAILGUN": 10
    }
  },
  "game_10": {
    "total_kills": 60,
    "players": [
      "Dono da Bola"
    ],
    "kills": {
      "Dono da Bola": 3
    },
    "kill_by_means": {
      "MOD_TELEFRAG": 25,
      "MOD_TRIGGER_HURT": 17,
      "MOD_ROCKET": 4,
      "MOD_ROCKET_SPLASH": 1,
      "MOD_RAILGUN": 7,
      "MOD_BFG_SPLASH": 2,
      "MOD_BFG": 2,
      "MOD_MACHINEGUN": 1,
      "MOD_CRUSH": 1
    }
  },
  "game_11": {
    "total_kills": 20,
    "players": [
      "Dono da Bola",
      "Isgalamido",
      "Zeh",
      "Oootsimo",
      "Chessus",
      "Assasinu Credi",
      "Mal"
    ],
    "kills": {
      "Oootsimo": 4,
      "Isgalamido": 3,
      "Zeh": 0,
      "Chessus": 0,
      "Mal": 0,
      "Dono da Bola": -2,
      "Assasinu Credi": -3
    },
    "kill_by_means": {
      "MOD_TRIGGER_HURT": 7,
      "MOD_CRUSH": 1,
      "MOD_ROCKET_SPLASH": 4,
      "MOD_BFG_SPLASH": 3,
      "MOD_MACHINEGUN": 1,
      "MOD_RAILGUN": 4
    }
  },
  "game_12": {
    "total_kills": 160,
    "players": [
      "Isgalamido",
      "Dono da Bola",
      "Zeh",
      "Oootsimo",
      "Chessus",
      "Assasinu Credi",
      "Mal"
    ],
    "kills": {
      "Isgalamido": 22,
      "Assasinu Credi": 16,
      "Oootsimo": 11,
      "Chessus": 11,
      "Zeh": 9,
      "Dono da Bola": 3,
      "Mal": -8
    },
    "kill_by_means": {
      "MOD_TRIGGER_HURT": 37,
      "MOD_RAILGUN": 38,
      "MOD_ROCKET_SPLASH": 35,
      "MOD_BFG_SPLASH": 8,
      "MOD_ROCKET": 25,
      "MOD_MACHINEGUN": 7,
      "MOD_BFG": 8,
      "MOD_FALLING": 2
    }
  },
  "game_13": {
    "total_kills": 6,
    "players": [
      "Isgalamido",
      "Dono da Bola",
      "Zeh",
      "Oootsimo",
      "Chessus",
      "Assasinu Credi",
      "Mal"
    ],
    "kills": {
      "Zeh": 2,
      "Oootsimo": 0,
      "Chessus": 0,
      "Assasinu Credi": 0,
      "Mal": 0,
      "Isgalamido": -1,
      "Dono da Bola": -1
    },
    "kill_by_means": {
      "MOD_TRIGGER_HURT": 2,
      "MOD_ROCKET": 1,
      "MOD_ROCKET_SPLASH": 1,
      "MOD_BFG_SPLASH": 1,
      "MOD_BFG": 1
    }
  },
  "game_14": {
    "total_kills": 122,
    "players": [
      "Zeh",
      "Assasinu Credi"
    ],
    "kills": {
      "Zeh": 3,
      "Assasinu Credi": -1
    },
    "kill_by_means": {
      "MOD_RAILGUN": 20,
      "MOD_TRIGGER_HURT": 31,
      "MOD_ROCKET": 23,
      "MOD_ROCKET_SPLASH": 24,
      "MOD_MACHINEGUN": 4,
      "MOD_BFG_SPLASH": 10,
      "MOD_FALLING": 5,
      "MOD_BFG": 5
    }
  },
  "game_15": {
    "total_kills": 3,
    "players": [
      "Isgalamido",
      "Dono da Bola",
      "Oootsimo",
      "Assasinu Credi"
    ],
    "kills": {
      "Isgalamido": 0,
      "Dono da Bola": 0,
      "Oootsimo": 0,
      "Assasinu Credi": 0
    },
    "kill_by_means": {
      "MOD_TRIGGER_HURT": 3
    }
  },
  "game_16": {
    "total_kills": 0,
    "players": [
      "Dono da Bola",
      "Oootsimo",
      "Isgalamido",
      "Assasinu Credi",
      "Zeh"
    ],
    "kills": {
      "Dono da Bola": 0,
      "Oootsimo": 0,
      "Isgalamido": 0,
      "Assasinu Credi": 0,
      "Zeh": 0
    },
    "kill_by_means": {
    }
  },
  "game_17": {
    "total_kills": 13,
    "players": [
      "Dono da Bola",
      "Oootsimo",
      "Isgalamido",
      "Assasinu Credi",
      "Zeh",
      "Mal"
    ],
    "kills": {
      "Isgalamido": 0,
      "Zeh": 0,
      "Oootsimo": -1,
      "Mal": -1,
      "Dono da Bola": -2,
      "Assasinu Credi": -3
    },
    "kill_by_means": {
      "MOD_FALLING": 3,
      "MOD_TRIGGER_HURT": 6,
      "MOD_RAILGUN": 2,
      "MOD_ROCKET_SPLASH": 2
    }
  },
  "game_18": {
    "total_kills": 7,
    "players": [
      "Isgalamido",
      "Oootsimo",
      "Dono da Bola",
      "Assasinu Credi",
      "Zeh",
      "Mal"
    ],
    "kills": {
      "Assasinu Credi": 2,
      "Zeh": 2,
      "Isgalamido": 1,
      "Oootsimo": 0,
      "Dono da Bola": -1,
      "Mal": -1
    },
    "kill_by_means": {
      "MOD_ROCKET_SPLASH": 4,
      "MOD_ROCKET": 1,
      "MOD_FALLING": 1,
      "MOD_TRIGGER_HURT": 1
    }
  },
  "game_19": {
    "total_kills": 95,
    "players": [
      "Isgalamido",
      "Oootsimo",
      "Dono da Bola",
      "Assasinu Credi",
      "Zeh",
      "Mal"
    ],
    "kills": {
      "Zeh": 20,
      "Isgalamido": 12,
      "Oootsimo": 10,
      "Dono da Bola": 10,
      "Assasinu Credi": 7,
      "Mal": 2
    },
    "kill_by_means": {
      "MOD_TRIGGER_HURT": 12,
      "MOD_ROCKET": 27,
      "MOD_ROCKET_SPLASH": 32,
      "MOD_SHOTGUN": 6,
      "MOD_RAILGUN": 10,
      "MOD_MACHINEGUN": 7,
      "MOD_FALLING": 1
    }
  },
  "game_20": {
    "total_kills": 3,
    "players": [
      "Isgalamido",
      "Oootsimo",
      "Dono da Bola",
      "Assasinu Credi",
      "Zeh",
      "Mal"
    ],
    "kills": {
      "Oootsimo": 1,
      "Isgalamido": 0,
      "Dono da Bola": 0,
      "Assasinu Credi": 0,
      "Zeh": 0,
      "Mal": 0
    },
    "kill_by_means": {
      "MOD_ROCKET_SPLASH": 2,
      "MOD_ROCKET": 1
    }
  },
  "game_21": {
    "total_kills": 131,
    "players": [
      "Isgalamido",
      "Oootsimo",
      "Dono da Bola",
      "Assasinu Credi",
      "Zeh",
      "Mal"
    ],
    "kills": {
      "Oootsimo": 20,
      "Zeh": 19,
      "Isgalamido": 17,
      "Assasinu Credi": 13,
      "Dono da Bola": 10,
      "Mal": 6
    },
    "kill_by_means": {
      "MOD_ROCKET": 37,
      "MOD_TRIGGER_HURT": 14,
      "MOD_RAILGUN": 9,
      "MOD_ROCKET_SPLASH": 60,
      "MOD_MACHINEGUN": 4,
      "MOD_SHOTGUN": 4,
      "MOD_FALLING": 3
    }
  }
}
```
