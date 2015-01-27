defmodule PhoenixCrud.User do
  use Ecto.Model

  validate user,
    email: present(),
    password: present(),
    admin: present()

  schema "users" do
    field :content, :string
    field :email, :string
    field :password, :string
    field :admin, :boolean, default: false
  end
end
