# Militerm game configuration
import Config

config :militerm, :game,
  dir: {:exinfiltr8, "priv/game"},
  character_archetype: "std:character",
  character_start_location: {"on", "scene:well:infrared:atrium", "floor"},
  character_start_data: {Exinfiltr8.Master, :character_start_data}

config :militerm, :master, Exinfiltr8.Master

config :militerm, :repo, Exinfiltr8.Repo

config :gossip, :callback_modules,
  core: Militerm.Gossip,
  players: Militerm.Gossip,
  tells: Militerm.Gossip,
  games: Militerm.Gossip
