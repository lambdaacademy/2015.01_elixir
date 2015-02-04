defmodule PhoenixCrud.Talk do
  use Ecto.Model

  validate talk,
    title: present()

  schema "talks" do
    field :title,:string
    field :description, :string
    field :plus_votes, :integer, default: 0
    field :zero_votes, :integer, default: 0
    field :minus_votes, :integer, default: 0
  end
end
