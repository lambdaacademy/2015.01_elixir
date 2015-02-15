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
    user = User.find_by_email(params["email"])

    if user and user.password == params["password"] do
      conn = put_session(conn, :user, %{:email => user.email, :admin => user.admin, :id => user.id})
      redirect conn, to: "/"
    end

    conn = put_flash(conn, :error, "Wrong email, password combination.")
    render conn, "signin.html"
  end

  def logout(conn, _options) do
    conn = delete_session(conn, :user)
    redirect conn, to: "/"
  end
end
