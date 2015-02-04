defmodule PhoenixCrud.ApiController do
  use Phoenix.Controller
  import Ecto.Query

  alias PhoenixCrud.User
  alias PhoenixCrud.Repo

  plug :action

  defp get_user_by_email(email) do
    Repo.one( from u in User, where: u.email == ^email, select: u)
  end

  def user_exists(conn, params) do
    user = get_user_by_email(params["user"])
    if user do
      text conn, "true"
    else
      text conn, "false"
    end
  end

  def check_password(conn, params) do
    user = get_user_by_email(params["user"])
    if user && user.password == params["password"] do
      text conn, "true"
    else
      text conn, "false"
    end
  end
end
