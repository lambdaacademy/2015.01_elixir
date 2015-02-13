defmodule PhoenixCrud.User do
  use Ecto.Model

  # has_format gives an error with message "is_valid" in the current state of the framework.
  validate user,
    email: has_format(~r/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/),
    password: present(),
    admin: present(),
    username: has_format(~r/^[a-zA-Z0-9_]+$/)

  schema "users" do
    field :content, :string
    field :email, :string
    field :password, :string
    field :admin, :boolean, default: false
    field :username, :string
  end
end
