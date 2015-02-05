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
    talk1 = Repo.get(Talk, id)
    talk2 = Map.merge(talk1, %{plus_votes: talk1.plus_votes + plus_votes,
                              minus_votes: talk1.minus_votes + minus_votes,
                              zero_votes: talk1.zero_votes + zero_votes})
    Repo.update(talk2)
    json conn, %{talk: Repo.get(Talk, id)}
  end
end
