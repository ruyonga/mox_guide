use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :mox_guide, MoxGuideWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :mox_guide,
  user_service: MoxGuideWeb.UserServiceMock

# Configure your database
config :mox_guide, MoxGuide.Repo,
  username: "postgres",
  password: "postgres",
  database: "mox_guide_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
