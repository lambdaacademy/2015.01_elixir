defmodule PhoenixCrud.Repo.Migrations.AddConstraintsToUser do
  use Ecto.Migration

  def up do
    ["ALTER TABLE users ADD CONSTRAINT unique_email UNIQUE (email);",
      "ALTER TABLE users ADD CONSTRAINT unique_username UNIQUE (username);"]
  end

  def down do
    ["ALTER TABLE users DROP CONSTRAINT unique_email;",
      "ALTER TABLE users DROP CONSTRAINT unique_username;"]
  end
end
