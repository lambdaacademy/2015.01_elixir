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
    Map.merge(check_mail(user.email), check_username(user.username))
  end

  defp check_mail(mail) do
    if find_by_email(mail) != nil do
      %{ email: "is already in our database" }
    else
      %{}
    end
  end

  defp check_username(username) do
    if find_by_username(username) != nil do
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
