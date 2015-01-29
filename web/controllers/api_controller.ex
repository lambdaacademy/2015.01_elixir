defmodule PhoenixCrud.ApiController do
  use Phoenix.Controller
  import Ecto.Query

  alias PhoenixCrud.User
  alias PhoenixCrud.Repo

  plug :action

  defp getUserByEmail(email) do
    Repo.one( from u in User, where: u.email == ^email, select: u)
  end

  def userExists(conn, params) do
    user = getUserByEmail(params["user"])
    if user do
      text conn, "true"
    else
      text conn, "false"
    end
  end

  def checkPassword(conn, params) do
    user = getUserByEmail(params["user"])
    if user && user.password == params["password"] do
      text conn, "true"
    else
      text conn, "false"
    end
  end
end
