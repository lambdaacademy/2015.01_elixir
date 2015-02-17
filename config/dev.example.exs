use Mix.Config

config :lambda_days, LambdaDays.Endpoint,
  http: [port: System.get_env("PORT") || 4000],
  debug_errors: true,
  cache_static_lookup: false

config :logger, :console, format: "[$level] $message\n"

config :lambda_days, LambdaDays.Repo,
  url: "ecto://username:password@localhost/lambda_days"

config :phoenix, :code_reloader, true
