# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :exinfiltr8,
  ecto_repos: [Exinfiltr8.Repo]

# Configures the endpoint
config :exinfiltr8, Exinfiltr8Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/PLkHqCpctqdt4UDZR0RrVaFPWGskUIUnK27mQbH9qAb34zcadTClC3/MQG+i4JB",
  render_errors: [view: Exinfiltr8Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Exinfiltr8.PubSub, adapter: Phoenix.PubSub.PG2]

config :ueberauth, Ueberauth,
  providers: [
    grapevine: {Grapevine.Ueberauth.Strategy, [scope: "profile email"]}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :militerm, Militerm.Cache.LocalSession,
  # 24 hrs
  gc_interval: 86_400

config :militerm, Militerm.Cache.LocalComponent,
  # 24 hrs
  gc_interval: 86_400

config :militerm, Militerm.Cache.Session,
  primary: Militerm.Cache.Session.Primary,
  node_selector: Nebulex.Adapters.Partitioned

config :militerm, Militerm.Cache.Component,
  primary: Militerm.Cache.Component.Primary,
  node_selector: Nebulex.Adapters.Partitioned

import_config "militerm.exs"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
