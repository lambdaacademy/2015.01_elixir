defmodule PhoenixCrud.User do
  use Ecto.Model

  validate user,
    email: has_format(~r/^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,6}$/),
    password: present(),
    admin: present()

  schema "users" do
    field :content, :string
    field :email, :string
    field :password, :string
    field :admin, :boolean, default: false
  end
end
