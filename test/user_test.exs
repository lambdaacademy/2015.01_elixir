defmodule UserTest do 
  use ExUnit.Case
  
  setup do
    Mix.Tasks.Ecto.Migrate.run(["--all", "PhoenixCrud.Repo"])

    on_exit fn ->
      Mix.Tasks.Ecto.Rollback.run(["--all", "PhoenixCrud.Repo"])
    end
  end

  def valid_user do 
    %PhoenixCrud.User{
      email: "pawel@pawel.com",
      password: "very_secret_password",
      admin: false, 
      username: "pawel"
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

    catch_error PhoenixCrud.Repo.insert(user)
    user = Map.merge(valid_user(), %{username: "another_nick"})
    catch_error PhoenixCrud.Repo.insert(user)
    user = Map.merge(valid_user(), %{email: "another@mail.com"})
    catch_error PhoenixCrud.Repo.insert(user)
  end 
end
