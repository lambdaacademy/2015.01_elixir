defmodule LambdaDays.WelcomeController do
  use Phoenix.Controller

  plug :action

  def index(conn, _params) do
    user = Plug.Conn.get_session(conn, :user)
    render conn, "index.html", user: user
  end
end
