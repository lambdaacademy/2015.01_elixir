defmodule LambdaDays.TalkApiController do
  use Phoenix.Controller
  import Ecto.Query

  alias LambdaDays.Talk
  alias LambdaDays.Repo

  plug :action

  def index(conn, _params) do
    json conn, %{talks: Repo.all(Talk)}
  end

  def update(conn, %{"id" => id, "zero_votes" => zero_votes, "plus_votes" => plus_votes, "minus_votes" => minus_votes}) do
    x = (Repo.transaction( fn ->
      case Repo.get(Talk, id) do
        talk when is_map(talk) ->
          talk_updated = Map.merge(talk, %{plus_votes: talk.plus_votes + plus_votes,
                                          minus_votes: talk.minus_votes + minus_votes,
                                          zero_votes: talk.zero_votes + zero_votes})
          Repo.update(talk_updated)
          %{talk: Repo.get(Talk, id)}
        _ -> %{error: "Talk with given id was not found"}
      end
    end))

    case x do
      {:ok, message} -> json conn, message
      _ -> json conn, %{error: "Error during executing transaction"}
    end
  end

  def update(conn, _params) do
    json conn, %{error: "Wrong parameters"}
  end
end
