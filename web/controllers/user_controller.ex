defmodule LambdaDays.UserController do
  use Phoenix.Controller

  alias LambdaDays.Router
  alias LambdaDays.User
  alias LambdaDays.Repo

  plug :authentication
  plug :authorization, :admin
  plug :action

  defp authentication(conn, _options) do
    if get_session(conn, :user) do
      conn
    else
      halt(redirect(conn, to: Router.Helpers.signin_path(conn, :signin)))
    end
  end

  defp authorization(conn, :admin) do
    if action_name(conn) in [:index, :new, :create, :destroy] do
      if current_user(conn)[:admin] do
        conn
      else
        halt(redirect(conn, to: Router.Helpers.page_path(conn, :show, "unauthorized")))
      end
    else
      conn
    end
  end

  def authorization(conn, :user, id) do
    if !(current_user(conn)[:admin] || {current_user(conn)[:id], ""} == Integer.parse(id)) do
      halt(redirect(conn, to: Router.Helpers.page_path(conn, :show, "unauthorized")))
    end
  end

  def index(conn, _params) do
    IO.puts inspect conn
    render conn, "index.html", users: Repo.all(User)
  end

  def show(conn, %{"id" => id}) do
    authorization(conn, :user, id)

    case Repo.get(User, id) do
      user when is_map(user) ->
        render conn, "show.html", user: user
      _ ->
        redirect conn, to: Router.Helpers.page_path(conn, :show, "unauthorized")
    end
  end

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"user" => params}) do
    user = %User{email: params["email"],
                 password: params["password"],
                 admin: map_admin(params["admin"]),
                 username: ensure_username(params)}
    case User.validate(user) do
      nil ->
        user = Repo.insert(user)
        render conn, "show.html", user: user
      errors ->
        render conn, "new.html", user: user, errors: errors
    end
  end

  def edit(conn, %{"id" => id}) do
    authorization(conn, :user, id)

    case Repo.get(User, id) do
      user when is_map(user) ->
        render conn, "edit.html", user: user
      _ ->
        redirect conn, to: Router.Helpers.page_path(conn, :show, "unauthorized")
    end
  end

  def update(conn, %{"id" => id, "user" => params}) do
    authorization(conn, :user, id)

    user = Repo.get(User, id)
    user = %User{user | email: params["email"],
                 password: params["password"],
                 username: ensure_username(params)}
    case User.validate(user) do
      nil ->
        Repo.update(user)
        # [g] really hacky way to redirect in the client.. (is there a better way?)
        conn
        |> put_status(201)
        |> json %{location: Router.Helpers.user_path(conn, :show, user.id) }
      errors ->
        conn |> json %{errors: errors}
    end
  end

  def destroy(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    case user do
      user when is_map(user) ->
        Repo.delete(user)
        conn
        |> put_status(201)
        |> json %{location: Router.Helpers.user_path(conn, :index)}
      _ ->
        redirect conn, Router.Helpers.page_path(page: "unauthorized")
    end
  end

  def current_user(conn) do
    get_session(conn, :user)
  end

  def map_admin(value) do
    value == "on"
  end

  def ensure_username(params) do
    if params["username"] != "" do
      params["username"]
    else
      hd(String.split(params["email"], "@"))
    end
  end
end
