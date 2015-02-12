defmodule TalkTest do 
  use ExUnit.Case
  
  setup do
    Mix.Tasks.Ecto.Migrate.run(["--all", "PhoenixCrud.Repo"])

    on_exit fn ->
      Mix.Tasks.Ecto.Rollback.run(["--all", "PhoenixCrud.Repo"])
    end
  end

  def valid_talk do 
    %PhoenixCrud.Talk{
      title: "Elixr",
      description: "is awesome",
      plus_votes: 0,
      zero_votes: 0,
      minus_votes: 0
    }
  end 

  test "should accept valid talk" do
    talk = valid_talk()
    refute PhoenixCrud.Talk.validate(talk)
  end

  test "should not accept talk without title" do
    talk = valid_talk()
    talk = Map.merge(talk, %{title: ""})
    assert PhoenixCrud.Talk.validate(talk) != nil
  end

  test "should not accept talk without description" do
    talk = valid_talk()
    talk = Map.merge(talk, %{description: ""})
    assert PhoenixCrud.Talk.validate(talk) != nil
  end

  test "doesn't accepts vote counts lower than zero" do
    talk = valid_talk()
    talk = Map.merge(talk, %{plus_votes: -1})
    assert PhoenixCrud.Talk.validate(talk) != nil

    talk = valid_talk()
    talk = Map.merge(talk, %{zero_votes: -1})
    assert PhoenixCrud.Talk.validate(talk) != nil

    talk = valid_talk()
    talk = Map.merge(talk, %{minus_votes: -1})
    assert  PhoenixCrud.Talk.validate(talk) != nil
  end
end
