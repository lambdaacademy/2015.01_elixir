defmodule PhoenixCrud.AuthController do
  use Phoenix.Controller
  import Ecto.Query

  alias PhoenixCrud.Router
  alias PhoenixCrud.User
  alias PhoenixCrud.Repo

  plug :action

  def signin(conn, _params) do
    render conn, "signin.html"
  end

  def authenticate(conn, %{"user" => params}) do
    user = Repo.one(
      from u in User, where: u.email == ^params["email"], select: u)
    if user do
      if user.password == params["password"] do
        conn = put_session(conn, :user, %{:email => user.email, :admin => user.admin})
        redirect conn, to: "/"
      end
    end

    conn = put_flash(conn, :error, "Wrong email, password combination.")
    render conn, "signin.html"
  end
end
