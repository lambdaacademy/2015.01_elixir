defmodule LambdaDays.RoomController do
  use Phoenix.Controller

  alias LambdaDays.Router

  plug :authentication
  plug :action

  defp authentication(conn, _options) do
    if get_session(conn, :user) do
      conn
    else
      halt(redirect(conn, to: Router.Helpers.signin_path(conn, :signin)))
    end
  end

  def index(conn, params) do
    user = Plug.Conn.get_session(conn, :user)
    user = LambdaDays.Repo.get(LambdaDays.User, user.id)
    stream = case params["room"] do
      "1.19" -> "lambda4/stream4"
      "1.20" -> "lambda3/stream3"
      "1.38" -> "lambda2/stream2"
      "2.41" -> "lambda/stream1"
    end

    render conn, "index.html", room: params["room"], user: user, stream: stream
  end
end
