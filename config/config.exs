# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :mox_guide,
  ecto_repos: [MoxGuide.Repo]

# Configures the endpoint
config :mox_guide, MoxGuideWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Lc2OcPRGFzrI2Ew7RyYK5NCu3WsItpULO1/xlsojcmt6ZkmTGbgDYFqJtZ+9Yqc/",
  render_errors: [view: MoxGuideWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MoxGuide.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :mox_guide,
  user_service: MoxGuide.UserService

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
