defmodule LambdaDays.Talk do
  use Ecto.Model

  validate talk,
    title: present(),
    description: present(),
    plus_votes: greater_than_or_equal_to(0),
    zero_votes: greater_than_or_equal_to(0),
    minus_votes: greater_than_or_equal_to(0)

  schema "talks" do
    field :title,:string
    field :description, :string
    field :plus_votes, :integer, default: 0
    field :zero_votes, :integer, default: 0
    field :minus_votes, :integer, default: 0
  end
end
