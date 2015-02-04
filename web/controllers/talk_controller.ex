defmodule PhoenixCrud.TalkController do
  use Phoenix.Controller

  alias PhoenixCrud.Router
  alias PhoenixCrud.Repo
  alias PhoenixCrud.Talk

  plug :authorization, :admin
  plug :action

  defp authorization(conn, :admin) do
    if current_user(conn)[:admin] do
      conn
    else
      halt(redirect(conn, to: Router.Helpers.page_path(conn, :show, "unauthorized")))
    end
  end

  def index(conn, _params) do
    render conn, "index.html", talks: Repo.all(Talk)
  end

  def show(conn, %{"id" => id}) do
    authorization conn, :admin
    talk = Repo.get(Talk, id)
    if talk do
      render conn, "show.html", talk: talk
    else
      redirect(conn, to: Router.Helpers.page_path(conn, :show, "unauthorized"))
    end
  end

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"talk" => params}) do
    talk = %Talk{title: params["title"], description: params["description"]}
    case Talk.validate(talk) do
      nil ->
        talk = Repo.insert(talk)
        render conn, "show.html", talk: talk
      errors ->
        render conn, "new.html", talk: talk, errors: errors
    end
  end

  # to do, dać to do jakiegoś helpera
  def current_user(conn) do
    get_session(conn, :user)
  end
end
