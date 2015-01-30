defmodule PhoenixCrud.Repo.Migrations.AddUsernameToUsers do
  use Ecto.Migration

  def up do
    "ALTER TABLE users ADD COLUMN username varchar(50)"
  end

  def down do
    "ALTER TABLE users DROP COLUMN username"
  end
end
