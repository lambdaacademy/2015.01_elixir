defmodule LambdaDays.User do
  use Ecto.Model

  # has_format gives an error with message "is_valid" in the current state of the framework.
  validate user,
    email: has_format(~r/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/),
    password: present(),
    admin: present(),
    username: has_format(~r/^[a-zA-Z0-9_]+$/),
    also: validate_uniqness

  schema "users" do
    field :email, :string
    field :password, :string
    field :admin, :boolean, default: false
    field :username, :string
  end

  def validate_uniqness(user) do
    Map.merge(check_email(user), check_username(user))
  end

  defp check_email(user) do
    found_user = find_by_email(user.email)
    if found_user != nil and found_user.id != user.id do
      %{ email: "is already in our database" }
    else
      %{}
    end
  end

  defp check_username(user) do
    found_user = find_by_username(user.username)
    if found_user != nil and found_user.id != user.id do
      %{ username: "is already in our database" }
    else
      %{}
    end
  end

  def find_by_username(username) do
    LambdaDays.Repo.one( from u in LambdaDays.User, where: u.username  == ^username, select: u)
  end

  def find_by_email(email) do
    LambdaDays.Repo.one( from u in LambdaDays.User, where: u.email  == ^email, select: u)
  end
end
