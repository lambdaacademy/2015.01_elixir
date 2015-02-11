defmodule PhoenixCrud.TalkApiController do
  use Phoenix.Controller
  import Ecto.Query

  alias PhoenixCrud.Talk
  alias PhoenixCrud.Repo

  plug :action

  def index(conn, _params) do
    json conn, %{talks: Repo.all(Talk)}
  end

  def update(conn, %{"id" => id, "zero_votes" => zero_votes, "plus_votes" => plus_votes, "minus_votes" => minus_votes}) do
    case Repo.get(Talk, id) do
      talk when is_map(talk) ->
        talk_updated = Map.merge(talk, %{plus_votes: talk.plus_votes + plus_votes,
                              minus_votes: talk.minus_votes + minus_votes,
                              zero_votes: talk.zero_votes + zero_votes})
        Repo.update(talk_updated)
        json conn, %{talk: Repo.get(Talk, id)}
      _ ->
        json conn, %{error: "Talk with given id was not found"}
    end
  end

  def update(conn, _params) do
    json conn, %{error: "Wrong parameters"}
  end
end
