defmodule PhoenixCrudTest do
  use ExUnit.Case
  use Plug.Test

  setup_all do
    session_options = Plug.Session.init(store: Plug.ProcessStore, key: "foobar")
    {:ok, [session_options: session_options]}
  end

  setup do
    Mix.Tasks.Ecto.Migrate.run(["--all", "PhoenixCrud.Repo"])

    on_exit fn ->
      Mix.Tasks.Ecto.Rollback.run(["--all", "PhoenixCrud.Repo"])
    end
  end

  def action(controller,
             verb,
             action,
             session_options \\ nil,
             params \\ nil,
             headers \\ []) do
    conn = conn(verb, "/", params, headers)
    conn = Plug.Session.call(conn, session_options) |> fetch_session
    controller.call(conn, controller.init(action))
  end

  test "get list of talks using talk_api/index", context do
    response = action(PhoenixCrud.TalkApiController,
      :get,
      :index,
      context[:session_options])
    assert String.contains?(response.resp_body, "{\"talks\":")
    assert response.state == :sent
    assert response.status == 200
  end

  test "add votes for talks using talk_api/update", context do
    talk = %PhoenixCrud.Talk{title: "sample talk",
                              description: "this is sample talk about some interesting stuff",
                              plus_votes: 1,
                              zero_votes: 2,
                              minus_votes: 4}
    PhoenixCrud.Repo.insert(talk)
    talk = PhoenixCrud.Repo.one(PhoenixCrud.Talk)

    response = action(PhoenixCrud.TalkApiController,
      :get,
      :update,
      context[:session_options],
      %{"id" => talk.id, "plus_votes" => 1, "zero_votes" => 2, "minus_votes" => 3})
    talk_response = Poison.decode!(response.resp_body, as: %{"talk" => PhoenixCrud.Talk})

    assert talk_response["talk"].plus_votes == 2
    assert talk_response["talk"].zero_votes == 4
    assert talk_response["talk"].minus_votes == 7
    assert response.state == :sent
    assert response.status == 200
  end
end
