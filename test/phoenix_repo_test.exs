defmodule PhoenixRepoTest do
  use ExUnit.Case
  use Plug.Test

  setup do
    Mix.Tasks.Ecto.Migrate.run(["--all", "LambdaDays.Repo"])

    on_exit fn ->
      Mix.Tasks.Ecto.Rollback.run(["--all", "LambdaDays.Repo"])
    end
  end

  test "add admin user to database", context do
    user = %LambdaDays.User{email: "admin@admin.com", password: "admin", admin: :true, username: "admin"}
    LambdaDays.Repo.insert(user)
    users = LambdaDays.Repo.all(LambdaDays.User)
    assert length(users) == 1
  end
end
