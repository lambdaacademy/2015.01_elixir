defmodule MongooseApiTest do
  use ExUnit.Case
  use Plug.Test

  setup do
    Mix.Tasks.Ecto.Migrate.run(["--all", "PhoenixCrud.Repo"])

    user = %PhoenixCrud.User{email: "pawel@lambdaacademy.org", password: "pawel",
                             admin: :false, username: "pawel"}
    PhoenixCrud.Repo.insert(user)

    ## is it required ?
    on_exit fn ->
      Mix.Tasks.Ecto.Rollback.run(["--all", "PhoenixCrud.Repo"])
    end
  end

  def action(verb, method, path,  params) do
    conn = conn(verb, path, params, []) |> Plug.Conn.fetch_params
    controller = PhoenixCrud.MongooseApiController
    controller.call(conn, controller.init(method))
  end

  test "user_exists returns false if user doesn't exist" do
    params = %{user: "invaliduser", server: "lambdadays.org"}
    response = action(:get, :user_exists,"/api/user_exists", params)
    assert response.resp_body == "false"
    assert response.state == :sent
    assert response.status == 200
  end

  test "user_exists returns true if user exists" do
    params = %{user: "pawel", server: "lambdadays.org"}
    response = action(:get, :user_exists,"/api/user_exists", params)
    assert response.resp_body == "true"
    assert response.state == :sent
    assert response.status == 200
  end

  test "check_password returns false if username or password is invalid" do
    params = %{user: "pawel", server: "lambdadays.org", pass: "invalidpass"}
    response = action(:get, :check_password,"/api/check_password", params)
    assert response.resp_body == "false"
    assert response.state == :sent
    assert response.status == 200

    params = %{user: "invaliduser", server: "lambdadays.org", pass: "invalidpass"}
    response = action(:get, :check_password,"/api/check_password", params)
    assert response.resp_body == "false"
    assert response.state == :sent
    assert response.status == 200

    params = %{user: "invaliduser", server: "lambdadays.org", pass: "pawel"}
    response = action(:get, :check_password,"/api/check_password", params)
    assert response.resp_body == "false"
    assert response.state == :sent
    assert response.status == 200
  end

  test "check_password returns true when credentials are valid" do
    params = %{user: "pawel", server: "lambdadays.org", pass: "pawel"}
    response = action(:get, :check_password,"/api/check_password", params)
    assert response.resp_body == "true"
    assert response.state == :sent
    assert response.status == 200
  end
end
