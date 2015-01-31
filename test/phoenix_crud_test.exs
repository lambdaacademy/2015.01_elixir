defmodule PhoenixCrudTest do
  use ExUnit.Case
  use Plug.Test

  setup_all do
    session_options = Plug.Session.init(store: Plug.ProcessStore, key: "foobar")
    {:ok, [session_options: session_options]}
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

  test "frontpage should contain word CRUD", context do
    response = action(PhoenixCrud.WelcomeController,
                      :get,
                      :index,
                      context[:session_options])
    assert String.contains?(response.resp_body, "CRUD")
    assert response.state == :sent
    assert response.status == 200
  end
end
