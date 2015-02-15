defmodule PhoenixRepoTest do
  use ExUnit.Case
  use Plug.Test

  setup do
    Mix.Tasks.Ecto.Migrate.run(["--all", "PhoenixCrud.Repo"])

    on_exit fn ->
      Mix.Tasks.Ecto.Rollback.run(["--all", "PhoenixCrud.Repo"])
    end
  end

  test "add admin user to database", context do
    user = %PhoenixCrud.User{email: "admin@admin.com", password: "admin", admin: :true, username: "admin"}
    PhoenixCrud.Repo.insert(user)
    users = PhoenixCrud.Repo.all(PhoenixCrud.User)
    assert length(users) == 1
  end
end
