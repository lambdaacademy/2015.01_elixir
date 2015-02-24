defmodule LambdaDays.RoomController do
  use Phoenix.Controller

  plug :action

  def index(conn, params) do
    IO.puts inspect params
    render conn, "index.html", room: params["room"]
  end
end
