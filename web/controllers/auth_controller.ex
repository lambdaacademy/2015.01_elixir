defmodule LambdaDays.AuthController do
  use Phoenix.Controller
  import Ecto.Query

  alias LambdaDays.Router
  alias LambdaDays.User
  alias LambdaDays.Repo

  plug :action

  def signin(conn, _params) do
    render conn, "signin.html"
  end

  def register(conn, _params) do
    render conn, "register.html"
  end

  def create(conn, %{"user" => params}) do
    user = %User{email: params["email"],
                 password: params["password"],
                 admin: false,
                 username: params["username"]}
    case User.validate(user) do
      nil ->
        user = Repo.insert(user)
        render conn, "signin.html", errors: [{:registration, "succesfull"}]
      errors ->
        render conn, "signin.html", errors: errors
    end
  end

  def authenticate(conn, %{"user" => params}) do
    user = User.find_by_email(params["email"])

    if user != nil and user.password == params["password"] do
      conn = put_session(conn, :user, %{:email => user.email, :admin => user.admin, :id => user.id})
      redirect conn, to: "/"
    else
      conn = put_flash(conn, :error, "Wrong email, password combination.")
      render conn, "signin.html"
    end
  end

  def logout(conn, _options) do
    conn = delete_session(conn, :user)
    redirect conn, to: "/"
  end
end
