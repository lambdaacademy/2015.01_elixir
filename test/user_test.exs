defmodule UserTest do
  use ExUnit.Case

  setup do
    Mix.Tasks.Ecto.Migrate.run(["--all", "PhoenixCrud.Repo"])

    on_exit fn ->
      Mix.Tasks.Ecto.Rollback.run(["--all", "PhoenixCrud.Repo"])
    end
  end

  def email do
    "pawel@pawel.com"
  end

  def username do
    "pawel"
  end

  def valid_user do
    %PhoenixCrud.User{
      email: email(),
      password: "very_secret_password",
      admin: false,
      username: username()
    }
  end

  test "should accept valid user" do
    user = valid_user()
    refute PhoenixCrud.User.validate(user)
  end

  test "should not accept user with invalid mail" do
    user = valid_user()
    user = Map.merge(user, %{email: ""})
    assert PhoenixCrud.User.validate(user) != nil

    user = Map.merge(user, %{email: "aksldjalks@"})
    assert PhoenixCrud.User.validate(user) != nil

    user = Map.merge(user, %{email: "aksldjalks@domain"})
    assert PhoenixCrud.User.validate(user) != nil

    user = Map.merge(user, %{email: "aksldjalks"})
    assert PhoenixCrud.User.validate(user) != nil
  end

  test "should not accept user with empty password" do
    user = valid_user()
    user = Map.merge(user, %{password: ""})
    assert PhoenixCrud.User.validate(user) != nil
  end

  test "should not accept user with invalid username" do
    user = valid_user()
    user = Map.merge(user, %{username: ""})
    assert PhoenixCrud.User.validate(user) != nil

    user = Map.merge(user, %{username: "?asdas"})
    assert PhoenixCrud.User.validate(user) != nil
  end

  test "username and email should be unique" do
    user = valid_user()
    # check and insert
    refute PhoenixCrud.User.validate(user)
    assert PhoenixCrud.Repo.insert(user) != nil

    assert PhoenixCrud.User.validate(user) != nil
    catch_error PhoenixCrud.Repo.insert(user)

    user = Map.merge(valid_user(), %{username: "another_nick"})
    assert PhoenixCrud.User.validate(user) != nil
    catch_error PhoenixCrud.Repo.insert(user)

    user = Map.merge(valid_user(), %{email: "another@mail.com"})
    assert PhoenixCrud.User.validate(user) != nil
    catch_error PhoenixCrud.Repo.insert(user)
  end

  test "find_by_email" do
    user = valid_user()
    assert PhoenixCrud.User.find_by_email(email()) == nil
    user = PhoenixCrud.Repo.insert(user)
    assert PhoenixCrud.User.find_by_email(email()).id == user.id
  end

  test "find_by_username" do
    user = valid_user()
    assert PhoenixCrud.User.find_by_username(username()) == nil
    user = PhoenixCrud.Repo.insert(user)
    assert PhoenixCrud.User.find_by_username(username()).id == user.id
  end
end
