defmodule LambdaDays.ChatController do
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
    conn
      |> put_layout(false)
      |> render "index.html", room: params["room"], user: user
  end
end
