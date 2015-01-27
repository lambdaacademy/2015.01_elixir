use Mix.Config

config :phoenix_crud, PhoenixCrud.Endpoint,
  http: [port: System.get_env("PORT") || 4000],
  debug_errors: true,
  cache_static_lookup: false

# Enables code reloading for development
config :phoenix, :code_reloader, true

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

config :phoenix_crud, PhoenixCrud.Repo,
  url: "ecto://username:password@localhost/phoenix_crud"
