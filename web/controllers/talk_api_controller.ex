defmodule LambdaDays.TalkApiController do
  use Phoenix.Controller
  import Ecto.Query

  alias LambdaDays.Talk
  alias LambdaDays.Repo

  plug :action

  def index(conn, _params) do
    json conn, %{talks: Repo.all(Talk)}
  end

  def update(conn, %{"id" => id,
                     "zero_votes" => zero_votes,
                     "plus_votes" => plus_votes,
                     "minus_votes" => minus_votes}) do
    x = (Repo.transaction( fn ->
      case Repo.get(Talk, id) do
        talk when is_map(talk) ->
          talk = %LambdaDays.Talk{
                   talk |
                   plus_votes: plus_votes,
                   zero_votes: zero_votes, 
                   minus_votes: minus_votes}
          Repo.update(talk)
          %{talk: Repo.get(Talk, id)}
        _ ->
          %{error: "Talk with given id was not found"}
      end
    end))

    case x do
      {:ok, message} ->
        json conn, message
      _ ->
        conn
        |> put_status(:bad_request)
        |> json %{error: "Error during executing transaction"}
    end
  end

  def update(conn, _params) do
    conn
    |> put_status(:bad_request)
    |> json %{error: "Wrong parameters"}
  end
end
