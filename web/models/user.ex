defmodule PhoenixCrud.User do
  use Ecto.Model

  validate user,
    content: present(message: "must be present")

  schema "users" do
    field :content, :string
    field :email, :string
    field :password, :string
    field :admin, :boolean
  end
end
