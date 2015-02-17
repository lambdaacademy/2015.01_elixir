defmodule LambdaDays.Endpoint do
  use Phoenix.Endpoint, otp_app: :lambda_days

  plug Plug.Static,
    at: "/", from: :lambda_days

  plug Plug.Logger

  # Code reloading will only work if the :code_reloader key of
  # the :phoenix application is set to true in your config file.
  plug Phoenix.CodeReloader

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_lambda_days_key",
    signing_salt: "DMvYZyHU",
    encryption_salt: "BLo9jMYR"

  plug :router, LambdaDays.Router
end
