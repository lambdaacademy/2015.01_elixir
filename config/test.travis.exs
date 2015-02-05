use Mix.Config

config :phoenix_crud, PhoenixCrud.Endpoint,
  http: [port: System.get_env("PORT") || 4000],
  debug_errors: true,
  cache_static_lookup: false

config :logger, :console, format: "[$level] $message\n"

config :phoenix_crud, PhoenixCrud.Repo,
  url: "ecto://postgres:@localhost/phoenix_crud"
