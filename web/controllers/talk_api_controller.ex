defmodule LambdaDays.TalkApiController do
  use Phoenix.Controller
  import Ecto.Query

  alias LambdaDays.Talk
  alias LambdaDays.Repo

  plug :action

  def index(conn, _params) do
    json conn, %{talks: Repo.all(Talk)}
  end

  def update(conn, talk_rating) do
    x = (Repo.transaction( fn ->
      case Repo.get(Talk, talk_rating["id"]) do
        talk when is_map(talk) ->
          talk = %LambdaDays.Talk{
                   talk |
                   plus_votes: talk_rating["plus_votes"],
                   zero_votes: talk_rating["zero_votes"],
                   minus_votes: talk_rating["minus_votes"]}
          IO.puts inspect talk
          Repo.update(talk)
          %{talk: Repo.get(Talk, talk_rating["id"])}
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
